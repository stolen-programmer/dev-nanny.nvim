
local M = {}

function M.detect()
    return true
end

function M.activation()
    require 'lsp.setup'.setup('clangd', {})
end

return M

