-- cwd term
-- vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>:FloatermNew --name=cwd --title=breaking_things <CR>]],
--     { noremap = true, silent = true })
-- sleep
vim.api.nvim_set_keymap('n', '<leader>cff',
    [[<cmd>:FloatermNew --name=sleep --title=taking_a_break... lolcat ~/dotfiles/art/thisIsFine.txt && caffeinate -d<CR>]],
    { noremap = true, silent = true })
-- tmux
vim.api.nvim_set_keymap('n', '<leader>tm',
    [[<cmd>:FloatermNew --name=tmux --title=open_new_project ~/.config/new-windows.sh<CR>]],
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ts',
    [[<cmd>:FloatermNew --name=tmux --title=open_new_session ~/.config/new-session.sh<CR>]],
    { noremap = true, silent = true })

-- floaterm
vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>:ToggleTerm direction=horizontal size=10<CR>]],
    { noremap = true, silent = true })

-- dotfiles
vim.api.nvim_set_keymap('n', '<leader>dm',
    [[<cmd>:FloatermNew --name=tmux --title=update_dotfiles ~/.config/dotfiles-update.sh<CR>]],
    { noremap = true, silent = true })

-- claude
vim.api.nvim_set_keymap('n', '<leader>cld',
    [[<cmd>:FloatermNew --name=claude --title=🤖 --wintype=split<CR>]],
    { noremap = true, silent = true })
