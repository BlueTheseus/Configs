" -- BASICS -----
set nocompatible
filetype plugin on
set mouse=a
syntax on
set ignorecase
set smartcase
set number
"set relativenumber
set nowrap
set incsearch
set smartindent

" tab completion
set wildmenu



" -- THEME -----
" true color
"set termguicolors



" -- CURSOR -----
set cursorline
"set cursorcolumn
"set colorcolumn=80
"set colorcolumn=120
set colorcolumn=80,100

" vertical scrolling
set scrolloff=4

" horizontal scrolling
set sidescrolloff=4

"highlight CursorLine   ctermbg=16 cterm=bold guibg=lightgrey
"highlight CursorColumn ctermbg=16 cterm=bold guibg=lightgrey
"highlight ColorColumn  ctermbg=4 guibg=lightgrey
highlight ColorColumn  ctermbg=4 guibg=lightgrey



" -- FILES -----

" save files as unicode
"set encoding=utf-8

" fuzzy finding
"   note: ** searches through all subdirectories
"set path+=**



" -- EDITING -----
" vertically center document when enter insert mode
"autocmd InsertEnter * norm zz

" remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" enable and disable autocomment

" tab settings
"set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4



" -- REMAP -----
" remap leader key
"<leader>

" alias write and quit to q
"nnoremap <leader>q :wq<CR>
