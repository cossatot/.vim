set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'jcf/vim-latex'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
Bundle 'plasticboy/vim-markdown'
" Bundle 'suan/vim-instant-markdown'
" Bundle 'amix/vim-zenroom2'
Bundle 'junegunn/goyo.vim'
Bundle 'JuliaLang/julia-vim'
Bundle 'vim-pandoc/vim-pantondoc'
Bundle 'vim-scripts/scratch.vim'

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
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>
nmap <leader>a <Esc>:Ack!

let g:pyflakes_use_quickfix = 0
let g:pep8_map='<leader>8'

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview


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
