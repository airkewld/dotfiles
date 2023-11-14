-- cwd term
vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>:FloatermNew --name=cwd --title=breaking-things <CR>]], { noremap = true, silent = true })
-- sleep
vim.api.nvim_set_keymap('n', '<leader>cff', [[<cmd>:FloatermNew --name=sleep --title=this_is_fine... lolcat ~/dotfiles/art/thisIsFine.txt && caffeinate -d<CR>]],{ noremap = true, silent = true })
-- tmux
vim.api.nvim_set_keymap('n', '<leader>tm', [[<cmd>:FloatermNew --name=tmux --title=tmux-windos ~/.config/tmux.sh<CR>]],{ noremap = true, silent = true })
