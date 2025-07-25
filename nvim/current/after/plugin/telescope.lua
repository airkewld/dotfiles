-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
--
--
local fb_actions = require "telescope._extensions.file_browser.actions"

require('telescope').setup {
    defaults = {
        prompt_prefix = "🔍 ",
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
        },
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
    extensions = {
        file_browser = {
            theme = "ivy",
            hijack_netrw = false,
            depth = 5,
            collapse_dirs = true,
            hidden = { file_browser = true, folder_browser = true },
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                    ["<C-n>"] = fb_actions.create,
                },
                ["n"] = {
                    -- your custom normal mode mappings
                },
            },
        },
    }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:

-- Telescope integration for git worktrees
require("telescope").load_extension("git_worktree")

-- Telescope file browser improved
require("telescope").load_extension("file_browser")

--Add leader shortcuts
vim.keymap.set('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
    { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff',
    [[<cmd>lua require('telescope.builtin').find_files({find_command = {"rg", "--ignore", "--hidden", "--files"}})<CR>]],
    -- [[<cmd>lua require('telescope.builtin').find_files({find_command="rg","--ignore","--hidden","--files",prompt_prefix="🔍"})<CR>]],
    { noremap = true, silent = true })
vim.keymap.set('n', '<leader>df',
    [[<cmd>lua require('telescope.builtin').find_files({prompt_title = "<Dotfiles>", cwd = "~/dotfiles"})<CR>]],
    { noremap = true, silent = true })
vim.keymap.set('n', '<leader>bf', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
    { noremap = true, silent = true })
vim.keymap.set('n', '<leader>lg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
    { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gwl', function()
    -- Close nvim-tree if it's open
    local ok, api = pcall(require, "nvim-tree.api")
    if ok then
        api.tree.close()
    end

    -- Open Telescope git worktrees
    require("telescope").extensions.git_worktree.git_worktrees()
end, { noremap = true, silent = true, desc = "List Git Worktrees" })
vim.keymap.set('n', '<leader>gwn', function()
    -- Close nvim-tree if it's open
    local ok, api = pcall(require, "nvim-tree.api")
    if ok then
        api.tree.close()
    end

    -- Open Telescope create_git_worktree picker
    require("telescope").extensions.git_worktree.create_git_worktree()
end, { noremap = true, silent = true, desc = "Create Git Worktree" })
-- vim.keymap.set('n', '<leader>gf', [[<cmd>lua require('telescope.builtin').git_files()<CR>]],
--     { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<CR>]],
    { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]],
    { noremap = true, silent = true })
-- quickfix commands
vim.keymap.set('n', '<leader>cn', [[<cmd>:cn <CR>]], { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cp', [[<cmd>:cp <CR>]], { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cc', [[<cmd>:cclose <CR>]], { noremap = true, silent = true })

-- buffer fuzzy find
vim.keymap.set('n', '<leader>/', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
    { noremap = true, silent = true })

-- telescope file browser
vim.keymap.set('n', '<leader>fb', [[<cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>]],
    { noremap = true, silent = true })
-- file_browser docs

-- <A-c>/c	Create file/folder at current path (trailing path separator creates folder)
-- <A-r>/r	Rename multi-selected files/folders
-- <A-m>/m	Move multi-selected files/folders to current path
-- <A-y>/y	Copy (multi-)selected files/folders to current path
-- <A-d>/d	Delete (multi-)selected files/folders
-- <C-o>/o	Open file/folder with default system application
-- <C-g>/g	Go to parent directory
-- <C-e>/e	Go to home directory
-- <C-w>/w	Go to current working directory (cwd)
-- <C-t>/t	Change nvim's cwd to selected folder/file(parent)
-- <C-f>/f	Toggle between file and folder browser
-- <C-h>/h	Toggle hidden files/folders
-- <C-s>/s	Toggle all entries ignoring ./ and ../
