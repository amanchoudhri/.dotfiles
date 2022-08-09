" Automatically install vim plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nu
filetype plugin on
syntax on
au FileType gitcommit setlocal tw=72
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

"Map the save key to \w
nnoremap <leader>w :w<cr>
"And wq to \wq
nnoremap <leader>wq :wq<cr>

"Map pane navigation from ctrl + w + key to ctrl + key
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Onehalf theme plugin
call plug#begin()

Plug 'mhartington/oceanic-next'
Plug 'itchyny/lightline.vim'

call plug#end()

colorscheme OceanicNext

"Lightline settings
let g:lightline = {'colorscheme': 'oceanicnext'}

set laststatus=2
set noshowmode

set ttimeout ttimeoutlen=5

