
local opt = { noremap = true, silent = true }

local map = vim.api.nvim_set_keymap

map('n', '<leader>duo', ':lua require("dapui").open()<CR>', opt)
map('n', '<leader>duc', ':lua require("dapui").close()<CR>', opt)
map('n', '<leader>dut', ':lua require("dapui").toggle()<CR>', opt)

map('n', '<F5>', ":lua require'dap'.continue()<CR>", opt)
map('n', '<F10>', ":lua require'dap'.step_over()<CR>", opt)
map('n', '<F11>', ":lua require'dap'.step_into()<CR>", opt)
map('n', '<F12>', ":lua require'dap'.step_out()<CR>", opt)
map('n', '<Leader>db', ":lua require'dap'.toggle_breakpoint()<CR>", opt)
map('n', '<Leader>dcb', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opt)
-- map('n', '<Leader>lp', ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opt)
map('n', '<Leader>dr', ":lua require'dap'.repl.open()<CR>", opt)
map('n', '<Leader>drl', ":lua require'dap'.run_last()<CR>", opt)



