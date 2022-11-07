
local M = { query_base = './build/.cmake/api/v1/query/', reply_base = './build/.cmake/api/v1/reply/' }

local u = require('posix.unistd')
local json = require('json')

local function mkdir(path)
    assert(type(path) == 'string')
    if u.access(path, u.F_OK) == 0 then
        return
    end

    vim.fn.mkdir(path, 'p')
end

local function touch(name)
    io.open(name, "w"):close()
end

local function json_parse(path)
    local fd = io.open(path, "r")
    local data = json.decode(fd:read('*a'))
    fd:close()
    
    return data

end

local function parse_codemodel()
    
    local codemodel = vim.fn.globpath(M.reply_base,'codemodel*')
    local codemodelJson = json_parse(codemodel)

    return codemodelJson

end

--- @param configurations table
--- @return table
local function parse_configurations(configurations)
    local result = {}
    for _, configuration in pairs(configurations) do
        for _, target in pairs(configuration.targets) do
            result[target.name] = target.jsonFile
        end
        
    end

    return result
    
end

--- @param targets table
local function parse_targets(targets)
    
    for name, targetJsonFile in pairs(targets) do
        local targetJson = json_parse(M.reply_base .. targetJsonFile)
        targets[name] = targetJson.artifacts[1].path
    end
end

local function cmake_prepare()
    --[[
    cache-v2
    cmakeFiles-v1
    codemodel-v2
    toolchains-v1
    --]]
    mkdir(M.query_base)

    touch(M.query_base .. 'cache-v2')
    touch(M.query_base .. 'cmakeFiles-v1')
    touch(M.query_base .. 'codemodel-v2')
    touch(M.query_base .. 'toolchains-v1')

    require('dap').adapters.lldb = {
        type = 'executable',
        command = 'lldb-vscode'
    }
end

local function cmake_job(id, data, event)
    if data ~= 0 then
        vim.notify('cmake generate failed', vim.log.levels.DEBUG)
        return
    end

    -- parse_codemodel
    -- parse_configurations
    local targets = parse_configurations(parse_codemodel().configurations)
    -- parse_targets
    parse_targets(targets)

    local dap_c = {}

    -- dap_configuration
    for name, path in pairs(targets) do
        table.insert(dap_c, {
            type = 'lldb',
            request = 'launch',
            name = 'Launch (' .. name .. ') - '.. path,
            program  =os.getenv('PWD') .. '/build/' ..  path
        })
    end

    require('dap').configurations.c = dap_c
    
end

local function cmake_build()
    
    vim.fn.jobstart('cmake --build build', {

        on_exit = function (id, data, event)
            if data ~= 0 then
                vim.notify('build failed', vim.log.levels.DEBUG)
                return
            end
            vim.notify('build success', vim.log.levels.DEBUG)
            
        end
    })
end

local function cmake_activation()

    cmake_prepare()

    vim.fn.jobstart('cmake -B build -DCMAKE_BUILD_TYPE=Debug', {
        on_exit = cmake_job
    })

    require('build').build = cmake_build
end

--- @return boolean
function M.detect()

    if u.access('./CMakeLists.txt', u.F_OK) ~= 0 then
        return false
    end

    M.active = cmake_activation

    return true
end

function M.activation()
    if M.active then
        M.active()
    end
    
end

return M

