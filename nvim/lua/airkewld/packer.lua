vim.cmd [[packadd packer.nvim]]

return require('packer').startup({
    function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        -- Telescope the moon
        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.0',
            -- or                            , branch = '0.1.x',
            requires = {
                { 'nvim-lua/popup.nvim' },
                { 'nvim-lua/plenary.nvim' },
                { 'nvim-telescope/telescope-fzf-native.nvim',  run = 'make' },
                { 'kyazdani42/nvim-web-devicons' },
                { 'nvim-telescope/telescope-file-browser.nvim' }
            }
        }
        use { "nvim-telescope/telescope-file-browser.nvim" }
        -- harpoon
        use 'ThePrimeagen/harpoon'
        use 'nvim-lua/plenary.nvim'

        -- Color scheme
        use 'gruvbox-community/gruvbox'
        use { "catppuccin/nvim", as = "catppuccin" }

        -- Comments++
        use { 'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        }

        -- Git Worktrees
        use 'ThePrimeagen/git-worktree.nvim'

        -- Git
        use 'tpope/vim-fugitive'
        use 'kdheepak/lazygit.nvim'
        -- Add git related info in the signs columns and popups
        use { 'lewis6991/gitsigns.nvim',
            requires = { 'nvim-lua/plenary.nvim' }
        }
        -- Status line
        -- use 'itchyny/lightline.vim'
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

        -- Treesitter
        use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

        -- LSP
        use {
            'VonHeikemen/lsp-zero.nvim',
            requires = {
                -- LSP Support
                { 'neovim/nvim-lspconfig' },
                { 'williamboman/mason.nvim' },
                { 'williamboman/mason-lspconfig.nvim' },

                -- Autocompletion
                { 'hrsh7th/nvim-cmp' },
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-path' },
                { 'saadparwaiz1/cmp_luasnip' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-nvim-lua' },

                -- Snippets
                { 'L3MON4D3/LuaSnip' },
                { 'rafamadriz/friendly-snippets' },
            }
        }
        -- floaterm
        use 'voldikss/vim-floaterm'

        use { "anuvyklack/windows.nvim",
            requires = {
                "anuvyklack/middleclass",
                "anuvyklack/animation.nvim"
            },
            config = function()
                vim.o.winwidth = 10
                vim.o.winminwidth = 10
                vim.o.equalalways = false
                require('windows').setup()
            end
        }

        -- git-blame
        use 'f-person/git-blame.nvim'

        -- markdown reader
        use({
            "iamcco/markdown-preview.nvim",
            run = function() vim.fn["mkdp#util#install"]() end,
        })

        -- vimwiki
        use 'vimwiki/vimwiki'

        -- smooth Scrolling
        use { 'karb94/neoscroll.nvim',
            config = function()
                require('neoscroll').setup()
            end
        }
        -- Snippets and integration with k8s
        use 'andrewstuart/vim-kubernetes'

        -- Show me indentantion marks
        use 'Yggdroot/indentLine'

        -- ALE (Asynchronous Lint Engine)
        use 'dense-analysis/ale'

        -- Rego syntax support
        use 'tsandall/vim-rego'
        use 'sbdchd/neoformat'

        -- Use tabnine
        use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }

        -- Use auto-pairs
        use 'jiangmiao/auto-pairs'

        -- copilot
        use 'github/copilot.vim'

        -- nvim-terminal
        use {
            's1n7ax/nvim-terminal',
            config = function()
                vim.o.hidden = true
                require('nvim-terminal').setup({
                    window = {
                        -- Do `:h :botright` for more information
                        -- NOTE: width or height may not be applied in some "pos"
                        position = 'botright',

                        -- Do `:h split` for more information
                        split = 'sp',

                        -- Width of the terminal
                        width = 50,

                        -- Height of the terminal
                        height = 20,
                    },

                    -- keymap to disable all the default keymaps
                    disable_default_keymaps = false,

                    -- keymap to toggle open and close terminal window
                    toggle_keymap = '<leader>ft',

                    -- increase the window height by when you hit the keymap
                    window_height_change_amount = 5,

                    -- increase the window width by when you hit the keymap
                    window_width_change_amount = 2,

                    -- keymap to increase the window width
                    increase_width_keymap = '<leader><leader>+',

                    -- keymap to decrease the window width
                    decrease_width_keymap = '<leader><leader>-',

                    -- keymap to increase the window height
                    increase_height_keymap = '<leader>+',

                    -- keymap to decrease the window height
                    decrease_height_keymap = '<leader>-',

                    terminals = {
                        -- keymaps to open nth terminal
                        { keymap = '<leader>1' },
                        { keymap = '<leader>2' },
                        { keymap = '<leader>3' },
                        { keymap = '<leader>4' },
                        { keymap = '<leader>5' },
                    },
                })
            end,
        }

        -- nvim tree
        use {
            'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-tree/nvim-web-devicons', -- optional
            },
            config = function()
                require("nvim-tree").setup {}
            end
        }
        -- add rooter
        use 'airblade/vim-rooter'
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        }
    }
})
