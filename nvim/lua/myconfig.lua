
-- "lua require('nvim_lsp').tsserver.setup{ on_attach=require'completion'.on_attach }
require('lspconfig').tsserver.setup{ on_attach=require'completion'.on_attach }
require('lspconfig').terraformls.setup{}
require('lspconfig').gopls.setup{ on_attach = function() }

-- "require for file_browser
require("telescope").load_extension "file_browser"

-- "require for comments
require('Comment').setup()

require("telescope").load_extension('harpoon')


require("telescope").load_extension("git_worktree")


require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
