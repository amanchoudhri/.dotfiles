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
set scrolloff=8

"Case insensitive search unless capital letters are used
set ignorecase
set smartcase

set termguicolors

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
Plug 'mhartington/oceanic-next'
Plug 'itchyny/lightline.vim'

" CHADTree - file manager
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

" Coq - completion client
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
" Need to **configure separately**

Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
" - shell repl
" - nvim lua api
" - scientific calculator
" - comment banner
" - etc


call plug#end()

let g:coq_settings = { 'auto_start': 'shut-up', 'keymap.jump_to_mark': '<c-J>' }

let g:chadtree_settings = { 'theme.text_colour_set': 'nord', 'keymap.trash': [] }
" Easy keybinding to open chadtree
nnoremap t <cmd>CHADopen<cr>

colorscheme OceanicNext

"Lightline settings
let g:lightline = {'colorscheme': 'oceanicnext'}

set laststatus=2
set noshowmode

set ttimeout ttimeoutlen=5

