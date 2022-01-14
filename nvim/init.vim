set number
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set colorcolumn=150
set signcolumn=yes
set cmdheight=2
set updatetime=50
set shortmess+=c

source $HOME/.config/nvim/plug-config/coc.vim

""" Vim-Plug
call plug#begin('~/.config/nvim/plugged')
" color shceme
Plug 'gruvbox-community/gruvbox'
" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ctrlpvim/ctrlp.vim'
" Borrowed from Aristides
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'vim-utils/vim-man'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'onsails/lspkind-nvim'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'andrewstuart/vim-kubernetes'
Plug 'Yggdroot/indentLine'
Plug 'dense-analysis/ale'
Plug 'tsandall/vim-rego'
Plug 'sbdchd/neoformat'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'nvim-lua/completion-nvim'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "I«Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "I<Esc>[48;2;%lu;%lu;%Lum"
endif
let g:gruvbox_invert_selection='0'

colorscheme gruvbox
set background=dark

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

"lua require('nvim_lsp').tsserver.setup{ on_attach=require'completion'.on_attach }
lua require('lspconfig').tsserver.setup{ on_attach=require'completion'.on_attach }
lua require('lspconfig').terraformls.setup{}

"require for file_browser
lua require("telescope").load_extension "file_browser"

"require for comments
lua require('Comment').setup()

" Telescope remaps
let mapleader = " "
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fbb <cmd>Telescope file_browser hidden=true<cr>
nnoremap <leader>dso <cmd>Telescope find_files cwd=~/work/devsecops hidden=true no_ignore=true <cr>
nnoremap <leader>fh <cmd>Telescope find_files hidden=true no_ignore=true<cr>
nnoremap <leader>lg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fc <cmd>Telescope git_commits<cr>
lua require("telescope").load_extension('harpoon')
nnoremap <leader>th <cmd>Telescope harpoon marks<cr>

" Fugitive
nnoremap <leader>fg <cmd>:G<cr>
nnoremap <leader>gp <cmd>:Git push<cr>
nnoremap <leader>gpp <cmd>:G pull<cr>

" Quickfix
nnoremap <leader>cc <cmd>:cclose<cr>
nnoremap <leader>cn <cmd>:cnext<cr>
nnoremap <leader>cb <cmd>:cprevious<cr>

" Plug
nnoremap <leader>pli <cmd>:PlugInstall<cr>
nnoremap <leader>plu <cmd>:PlugUpdate<cr>
nnoremap <leader>plg <cmd>:PlugUpgrade<cr>

" Harpoon
nnoremap <leader>ha <cmd>:lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>hm <cmd>:lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap <leader>hn <cmd>:lua require("harpoon.ui").nav_next()<cr>
nnoremap <leader>hb <cmd>:lua require("harpoon.ui").nav_prev()<cr>
"require for primagen worktree
lua require("telescope").load_extension("git_worktree")
nnoremap <leader>wc <cmd>:lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>
nnoremap <leader>wl <cmd>:lua require('telescope').extensions.git_worktree.git_worktrees()<cr>

nnoremap <leader>rm <cmd>:call delete(expand('%'))<cr>

" DAMN WHITESPACE
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup TRIMTRIMTRIM
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
augroup END

" Find files inside dotfiles
nnoremap <leader>df :lua require('telescope.builtin').find_files({ prompt_title = "< Dotfiles>", cwd = "$HOME/dotfiles.git/main"})<cr>
