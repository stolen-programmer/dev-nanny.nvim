
local M = { query_base = './build/.cmake/api/v1/query/', reply_base = './build/.cmake/api/v1/reply/' }

--- @class Unistd
local u = require('posix.unistd')
local cmake = require('backend.cmake')

function M.detect()
    if not cmake.detect() then
        return true
    end

    return true
end
function M.activation()
    require 'lsp.setup'.setup('clangd', {})

    cmake.activation()
end

return M

