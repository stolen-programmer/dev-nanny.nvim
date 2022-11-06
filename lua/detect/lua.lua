

local M = {}

function M.detect()
    return true
end

function M.activation()
    require("neodev").setup({
        -- add any options here, or leave empty to use the default settings
    })

    -- then setup your lsp server as usual
    require('lsp.setup').setup('sumneko_lua', {
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace"
                }
            }
        }
    })
end

return M


