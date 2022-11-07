
local opt = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap

map('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', opt)



