" Automatically install vim plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nu

syntax on

"Force wrap lines in a git commit to 72 characters
au FileType gitcommit setlocal tw=72

"Tab settings
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

set smartindent

"Intuitive splits
set splitbelow
set splitright

"Start scrolling when 8 lines from top or bottom
set scrolloff=12

"Case insensitive search unless capital letters are used
set ignorecase
set smartcase

"Always display space for diagnostic icons in gutter
set signcolumn=yes

set termguicolors

"Temporarily keep these for lightline
set laststatus=2
set noshowmode

set ttimeout ttimeoutlen=5

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
Plug 'nvim-lualine/lualine.nvim'

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
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
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


" Basic LSP keybindings + settings
Plug 'VonHeikemen/lsp-zero.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

"Diagnostics list
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

"Scrollbar
Plug 'petertriho/nvim-scrollbar'

"Lightbulb for suggestions
Plug 'kosayoda/nvim-lightbulb'
Plug 'antoinemadec/FixCursorHold.nvim'

"LaTeX plugin
Plug 'lervag/vimtex'

call plug#end()

lua << EOF
vim.g.catppuccin_flavour = "frappe"
require("catppuccin").setup()
vim.cmd [[colorscheme catppuccin]]

-- Status line
require("lualine").setup({
    options = {
        theme = "catppuccin"
    },
    extensions = { 'chadtree' }
})

-- Treesitter config
require 'nvim-treesitter'.setup {}
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "python" },
    auto_install = true,
    highlight = {
        enable = true,
        disable = { "latex" }
    },
    indent = {
        enable = true,
        disable = { "python" }
    }
}

local lsp = require('lsp-zero')


lsp.preset('recommended')

-- Add cmp-nvim-lsp-signature-help
lsp.setup_nvim_cmp({
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp', keyword_length = 2},
        {name = 'nvim_lsp_signature_help'},
        {name = 'buffer', keyword_length = 3},
        {name = 'luasnip', keyword_length = 2}
    }
})

-- Recommended sumneko lua config. See:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
-- For more information.

lsp.configure('sumneko_lua', { settings = {
    Lua = {
        runtime = {
            version = 'LuaJIT',
        },
        diagnostics = {
            globals = {'vim'},
        },
        workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
            enable = false,
        },
    },
}})

lsp.setup()

require("trouble").setup {}

require("scrollbar").setup {}
EOF

"VimTeX settings
let g:tex_flavor='latex'
let g:vimtex_compiler_latexmk = {'build_dir': 'aux'}
if has('macunix')
    let g:vimtex_view_method = 'skim'
endif

let g:chadtree_settings = { 'theme.text_colour_set': 'env', 'keymap.trash': [] }
" Easy keybinding to open chadtree
nnoremap <C-t> <cmd>CHADopen<cr>

