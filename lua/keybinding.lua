
local opt = {noremap = true, silent = true}

local map = vim.api.nvim_set_keymap;

map('n', '<leader>rc', ':RunConfigurations<CR>', opt)
map('n', '<leader>b', ':Build<CR>', opt)
map('n', '<leader>r', ':Run<CR>', opt)

map('n', '<C-b>', ':lua require "build".build()<CR>', opt)

