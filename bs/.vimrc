call plug#begin()
"Colocar os plugins aqui"
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

colorscheme dracula

set nu!
set mouse=a
set cursorline
set encoding=utf-8

map <C-w> :quit<CR>
map <C-s> :write<CR>
map <C-F12> :terminal<CR>

" VIM AIRLINE
let g:airline_theme = 'dracula'
" powerline symbols
let g:airline_left_alt_sep = '  '
let g:airline_right_sep = '  '
let g:airline_right_alt_sep = '  '
let g:airline_symbols = {}
let g:airline_symbols.branch = '  '
let g:airline_symbols.readonly = '  '
let g:airline_symbols.linenr = ' ☰  '
let g:airline_symbols.maxlinenr = '  '
let g:airline_symbols.dirty=' ⚡ '
