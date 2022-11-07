
vim.api.nvim_create_autocmd({'BufReadPost'}, {

    callback = function ()
        -- 获取文件类型
        local ft = vim.api.nvim_buf_get_option(0, 'filetype')
        -- require detect.ft
        local succ, detect = pcall(require, 'detect.' .. ft)

        if not succ then
            vim.notify( 'detect/' .. ft .. '.lua' ..  ' not found', vim.log.levels.DEBUG)
            return
        end

        if not detect.detect() then
            vim.notify('detect failed', vim.log.levels.DEBUG)
            return
        end

        detect.activation()
        vim.api.nvim_command('LspStart')
    end
})

require('lsp')
require('dap-ui')
require('keybinding')

-- require('command')

