vim.api.nvim_set_keymap('n', '<leader>fh', [[<cmd>lua require("nvterm.terminal").toggle "horizontal"
<CR>]],
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fv', [[<cmd>lua require("nvterm.terminal").toggle "vertical"
<CR>]],
    { noremap = true, silent = true })
