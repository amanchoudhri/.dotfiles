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
