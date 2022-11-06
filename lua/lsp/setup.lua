
local M = {}

function merge(x, y) 
    x = x or {}
    y = y or {}

    for k, v in pairs(y) do
        x[k] = v
    end

    return x
end


function M.setup(lsp, config)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local c = merge({
        capabilities = capabilities
    }, config)
    
    require('lspconfig')[lsp].setup(c)

end

return M

