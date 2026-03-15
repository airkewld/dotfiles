-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git' },
    keys = {
      { '<leader>gp', '<cmd>G pull<CR>', desc = 'Git pull' },
      { '<leader>gfe', "<cmd>G fetch origin '*:*'<CR>", desc = 'Git fetch' },
      { '<leader>gs', '<cmd>G<CR>', desc = 'Git status' },
      { '<leader>ga', '<cmd>Git fetch --all<CR>', desc = 'Git fetch all' },
      { '<leader>grum', '<cmd>Git rebase upstream/master<CR>', desc = 'Git rebase upstream/master' },
      { '<leader>grom', '<cmd>Git rebase origin/master<CR>', desc = 'Git rebase origin/master' },
    },
  },
  { 'tpope/vim-rhubarb', cmd = 'GBrowse' },
  {
    'ruifm/gitlinker.nvim',
    keys = { { '<leader>gu', desc = 'Open git link in browser' } },
    config = function()
      require('gitlinker').setup({
        opts = {
          action_callback = require('gitlinker.actions').open_in_browser,
          print_url = true,
        },
        mappings = '<leader>gu'
      })
    end
  },

  -- Dashboard
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "Neovim " .. vim.version().major .. "." .. vim.version().minor,
        "",
        "     🚀"
      }
      dashboard.section.buttons.val = {
        dashboard.button("SPC ff", "🔍  Find file",
          ":lua require('telescope.builtin').find_files({ find_command = { 'rg', '--ignore', '--hidden', '--files' } })<CR>"),
        dashboard.button("SPC lg", "🗂  Find text", ":lua require('telescope.builtin').live_grep()<CR>"),
      }

      dashboard.section.footer.val = function()
        local stats = require("lazy").stats()
        return "⚡ " .. stats.count .. " plugins loaded in " .. stats.startuptime .. "ms"
      end

      require("alpha").setup(dashboard.config)
    end,
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',

      -- Add this for buffer completion
      'hrsh7th/cmp-buffer',

      -- Add this for path completion
      'hrsh7th/cmp-path',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  -- {
  --   -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'go',
          'lua',
          'python',
          'vimdoc',
          'vim',
          'bash',
          'terraform',
          'yaml',
          'json',
          'dockerfile',
          'toml',
          'hcl',
        },
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
  },


  -- my stuff
  --
  {
    -- catppuccin
    'catppuccin/nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- telescope file browser
  'nvim-telescope/telescope-file-browser.nvim',

  -- harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- worktrees
  'ThePrimeagen/git-worktree.nvim',

  -- lazygit
  {
    'kdheepak/lazygit.nvim',
    cmd = 'LazyGit',
    keys = {
      { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'LazyGit' },
    },
  },

  -- status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
  },

  -- terminals
  {
    'voldikss/vim-floaterm',
    cmd = 'FloatermNew',
    keys = {
      { '<leader>cff', [[<cmd>FloatermNew --name=sleep --title=taking_a_break... lolcat ~/dotfiles/art/thisIsFine.txt && caffeinate -d<CR>]], desc = 'Caffeinate' },
      { '<leader>tm', [[<cmd>FloatermNew --name=tmux --title=open_new_project ~/.config/new-windows.sh<CR>]], desc = 'New tmux project' },
      { '<leader>ts', [[<cmd>FloatermNew --name=tmux --title=open_new_session ~/.config/new-session.sh<CR>]], desc = 'New tmux session' },
      { '<leader>dm', [[<cmd>FloatermNew --name=tmux --title=update_dotfiles ~/.config/dotfiles-update.sh<CR>]], desc = 'Update dotfiles' },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
      { '<leader>ft', '<cmd>ToggleTerm direction=horizontal size=10<CR>', desc = 'Toggle terminal' },
    },
    config = function()
      require("toggleterm").setup {
        size = 20,
        open_mapping = [[<c-\>]],
        direction = 'horizontal',
        close_on_exit = true,
        shell = vim.o.shell
      }

      vim.api.nvim_set_keymap('t', '<C-o>', [[<C-\><C-n>]], { noremap = true, silent = true })
    end
  },

  -- window animation
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim"
    },
    cmd = 'WindowsMaximize',
    keys = {
      { '<leader>wm', '<cmd>WindowsMaximize<CR>', desc = 'Maximize window' },
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require('windows').setup()
    end
  },

  -- smooth scroll
  {
    'karb94/neoscroll.nvim',
    event = 'VeryLazy',
    config = function()
      require('neoscroll').setup()
    end
  },


  -- git-blame
  {
    'f-person/git-blame.nvim',
    cmd = { 'GitBlameToggle', 'GitBlameOpenCommitURL' },
    keys = {
      { '<leader>gco', '<cmd>GitBlameOpenCommitURL<CR>', desc = 'Open commit URL' },
    },
  },

  -- markdown reader
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- vimwiki
  {
    'vimwiki/vimwiki',
    cmd = { 'VimwikiIndex', 'VimwikiToggleListItem' },
    ft = 'vimwiki',
    keys = {
      { '<leader>lt', '<cmd>VimwikiToggleListItem<CR>', desc = 'Toggle list item' },
    },
    init = function()
      vim.g.vimwiki_list = { { path = '~/work/obsidian/notes/', syntax = 'markdown', ext = '.md' } }
      vim.g.vimwiki_global_ext = 0
    end,
  },

  -- Use auto-pairs
  { 'jiangmiao/auto-pairs', event = 'InsertEnter' },

  -- -- copilot
  -- 'github/copilot.vim',

  -- nvim tree
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      { '<C-n>', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle file tree' },
    },
    config = function()
      require("nvim-tree").setup {
        view = {
          float = {
            enable = true,
            quit_on_focus_loss = true,
            open_win_config = {
              relative = "editor",
              border = "rounded",
              width = 50,
              height = 30,
              row = 1,
              col = 1,
            },
          },
        },
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          expand_all = {
            max_folder_discovery = 300,
            exclude = {},
          },
          file_popup = {
            open_win_config = {
              col = 1,
              row = 1,
              relative = "cursor",
              border = "shadow",
              style = "minimal",
            },
          },
          open_file = {
            quit_on_open = true,
            resize_window = true,
            window_picker = {
              enable = true,
              picker = "default",
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
          remove_file = {
            close_window = true,
          },
        },
      }
    end
  },

  -- oil.nvim
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },

  -- obsidian
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",

    },
    opts = {
      workspaces = {
        {
          name = "work",
          path = "~/work/obsidian/notes/",
        },
        {
          name = "personal",
          path = "~/dev/obsidian/notes/",
        },
      },

      templates = {
        folder = "~/work/obsidian/Templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },

      -- see below for full list of options 👇
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Work/dailies",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil
      },
      note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
          note:add_alias(note.title)
          note:add_tag(note.title)
        end

        local out = { id = note.id, aliases = note.aliases, tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return suffix
      end,
    },
  },

  -- AI
  -- Amp Plugin
  {
    "sourcegraph/amp.nvim",
    branch = "main",
    lazy = false,
    opts = { auto_start = true, log_level = "info" },
  },
  {
    "robitx/gp.nvim",
    cmd = { 'GpChatNew', 'GpChatRespond', 'GpNew' },
    keys = {
      { '<leader>ch', '<cmd>GpChatNew vsplit<CR>', desc = 'GP chat' },
      { '<leader>cr', '<cmd>GpChatRespond<CR>', desc = 'GP respond' },
      { '<leader>gcc', '<cmd>GpNew<CR>', desc = 'GP new' },
    },
    config = function()
      require("gp").setup({
        openai_api_key = os.getenv("OPENAI_API_KEY"),
        providers = {
          openai = {
            disable = true,
          },
          copilot = {
            disable = false,
            endpoint = "https://api.githubcopilot.com/chat/completions",
            secret = {
              "bash",
              "-c",
              "cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\".*//'",
            },
          },
        }
      })
    end,
  },

  {
    'airkewld/claude.nvim',
    config = function()
      require('claude').setup()
    end,
  },

  -- END PLUGINS
  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})

-- vim: ts=2 sts=2 sw=2 et
