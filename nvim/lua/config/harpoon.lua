vim.api.nvim_set_keymap('n', '<leader>ha', [[<cmd>lua require('harpoon.mark').add_file()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hm', [[<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hn', [[<cmd>lua require('harpoon.ui').nav_next()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hp', [[<cmd>lua require('harpoon.ui').nav_prev()<CR>]], { noremap = true, silent = true })
