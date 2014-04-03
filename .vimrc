set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

" Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'jcf/vim-latex'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
" Plugin 'suan/vim-instant-markdown'
" Plugin 'amix/vim-zenroom2'
" Plugin 'junegunn/goyo.vim'
Plugin 'JuliaLang/julia-vim'
" Plugin 'vim-pandoc/vim-pantondoc'
Plugin 'ethanmuller/scratch.vim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
" Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'plasticboy/vim-markdown'

set nocp
syntax on
filetype on
filetype plugin on
filetype plugin indent on

colorscheme molokai

set mouse=a

set foldmethod=indent
set foldlevel=99

let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=1


set colorcolumn=80
set lines=80
set columns=81

" better split defaults
set splitbelow
set splitright

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
map <leader>n :NERDTreeToggle<CR>

let g:SuperTabDefaultCompletionType = "context"
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
autocmd FileType python setlocal completeopt-=preview

set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through fil
set statusline+=%{fugitive#statusline()}

set ruler
set number

set smartindent
set expandtab
set shiftwidth=4
set tabstop=4

au FileType python setl shiftwidth=4 tabstop=4 expandtab

" let g:Tex_CompileRule_pdf = 'xelatex -interaction=nonstopmode *$'
let g:Tex_CompileRule_pdf = 'pdflatex *$'


func! WordProcessorMode()
  setlocal formatoptions=1
  setlocal noexpandtab
  map j gj
  map k gk
  setlocal spell spelllang=en_us
  setlocal wrap
  setlocal linebreak
  setlocal nolist
  setlocal guifont=Monaco:h12
  setlocal linespace=3
  setlocal tw=79 
endfu
com! WP call WordProcessorMode()


" stuff for relative/absolute line number switching
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

:au FocusLost * :set number
:au FocusGained * :set relativenumber

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber


" functions to help parse fixed width files to csv
command Onespace %s![^ ]\zs \+! !g

command Rmtrail %s/\s\+$//

command Rmlead %s/^\s\+

command FormatJSON %!python -m json.tool
