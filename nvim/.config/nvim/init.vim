" Automatically install vim plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nu
set numberwidth=4

filetype plugin on
syntax on

"Force wrap lines in a git commit to 72 characters
au FileType gitcommit setlocal tw=72

"Tab settings
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

"Intuitive splits
set splitbelow
set splitright

"Start scrolling when 8 lines from top or bottom
set scrolloff=12

"Case insensitive search unless capital letters are used
set ignorecase
set smartcase

set termguicolors

"Don't wrap too-long text
set nowrap

"Map the save key to \w
nnoremap <leader>w :w<cr>
"And wq to \wq
nnoremap <leader>wq :wq<cr>

"Map pane navigation from ctrl + w + key to ctrl + key
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Plugins
call plug#begin('~/.config/nvim/plugins')

"Themes
"Plug 'mhartington/oceanic-next'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'itchyny/lightline.vim'

" CHADTree - file manager
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}

"Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lua'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" LSP Config
Plug 'neovim/nvim-lspconfig'

" LSP Installer
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'


Plug 'VonHeikemen/lsp-zero.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

"Diagnostics formatting
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

"LaTeX plugin
Plug 'lervag/vimtex'

call plug#end()

let g:catppuccin_flavour = "frappe"
lua << EOF
require("catppuccin").setup()
EOF
colorscheme catppuccin

lua << EOF
require 'nvim-treesitter'.setup {}
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python" },
    auto_install = true,
    highlight = {
        enable = true,
        disable = { "latex" }
    }
}

local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup()

require("trouble").setup {}

EOF

"VimTeX settings
let g:tex_flavor='latex'
let g:vimtex_compiler_latexmk = {'build_dir': 'aux'}
if has('macunix')
    let g:vimtex_view_method = 'skim'
endif

let g:chadtree_settings = { 'theme.text_colour_set': 'nord', 'keymap.trash': [] }
" Easy keybinding to open chadtree
nnoremap <C-t> <cmd>CHADopen<cr>


"Lightline settings
let g:lightline = {'colorscheme': 'catppuccin'}

set laststatus=2
set noshowmode

set ttimeout ttimeoutlen=5

