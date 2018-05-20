set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" Plugin 'Valloric/YouCompleteMe'
" Plugin 'scrooloose/syntastic'

Plugin 'w0rp/ale' " better syntax highlighting?
Plugin 'google/yapf' " google auto formatting for python

Plugin 'scrooloose/nerdtree'
" Plugin 'jcf/vim-latex'
Plugin 'altercation/vim-colors-solarized'
" Plugin 'tpope/vim-fugitive'
" Plugin 'suan/vim-instant-markdown'
" Plugin 'amix/vim-zenroom2'
" Plugin 'junegunn/goyo.vim'
Plugin 'JuliaLang/julia-vim'
" Plugin 'vim-pandoc/vim-pantondoc'
Plugin 'ethanmuller/scratch.vim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
" Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
" Plugin 'plasticboy/vim-markdown'
Plugin 'hynek/vim-python-pep8-indent'
" Plugin 'wlangstroth/vim-racket'
Plugin 'luochen1990/rainbow'
Plugin 'Shougo/vimproc.vim'
" Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimshell.vim'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
" Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-obsession'
Plugin 'jpalardy/vim-slime.git'

Plugin 'dhruvasagar/vim-table-mode'


" nvim-qt stuff
Plugin 'equalsraf/neovim-gui-shim'

call vundle#end()
filetype plugin indent on

set noswapfile

set nocp
syntax on

colorscheme molokai

set mouse=a

set foldmethod=indent
set foldlevelstart=99

set noswapfile

" let g:vim_markdown_folding_disabled=1
" let g:vim_markdown_initial_foldlevel=1

let g:rainbow_active = 1

" better colors in neovim
set termguicolors

" turn off highlighting after search
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

set colorcolumn=80
" set lines=86
" set columns=85

" better split defaults
set splitbelow
set splitright

" python auto formatting
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>

" vim-pandoc-syntax stuff
" let g:pandoc#syntax#conceal#blacklist = ["newline","image","super","sub","strike","atx","codelang","abbrev","footnote","definition","li"]
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#formatting#mode = 'ha'
" autocmd FileType pandoc setlocal fo:want

let g:pandoc#folding#fdc = 0

" pollen lozenge character
imap @@ ◊


" auto-exponent
imap <leader>- $^{-1}$

let g:ale_linters = {
\   'python': ['flake8'],
\}


" Vim-Slime config
let g:slime_target = "tmux"


" try to fix clipboard problems in tmux
if $TMUX == ''
    set clipboard+=unnamed
end


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
set statusline+=%1*\ %n\ %*


set ruler
set number

set cindent
set expandtab
set shiftwidth=4
set tabstop=4

" change cursor in terminal vim based on mode
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

au FileType python setl shiftwidth=4 tabstop=4 expandtab
au FileType html setl shiftwidth=2 tabstop=2 expandtab " RainbowToggle
au FileType markdown setl shiftwidth=2 tabstop=2 expandtab " RainbowToggle

" pandoc markdown for pollen markdown files
au BufRead,BufNewFile *.html.pmd set filetype=pandoc
au BufRead,BufNewFile *.html.p set filetype=html

" let g:Tex_CompileRule_pdf = 'xelatex -interaction=nonstopmode *$'
let g:Tex_CompileRule_pdf = 'pdflatex *$'

" markdown formatting, maybe should expand to
" au FileType mkd setl fo=a2t


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
