set encoding=utf-8
syntax on

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'agude/vim-eldar'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'rubberduck203/aosp-vim'
Plugin 'gburca/vim-logcat'
Plugin 'mileszs/ack.vim'
call vundle#end()
filetype plugin indent on

colorscheme elflord
colorscheme eldar

set nocompatible
set backspace=2  " allow backspacing over autoindent and line breaks
set cursorline
set autoindent
" t: auto-wrap text using textwidth,
" c: auto-wrap comments using textwidth, inserting the comment leader
" r: insert the current comment leader after hitting Enter in i-mode
" o: insert the current comment leader after hitting o or O in i-mode
" q: format comments with gq
" n: recognize numbered lists when formatting text
" l: don't break already existing long lines
" j: remove a comment leader when joining lines
set formatoptions=croqtnlj
set cindent
set cinoptions=(0
set incsearch
set smartindent
set smarttab
set hlsearch
set ignorecase
set smartcase
set laststatus=2
set mouse=a  " mouse in all modes
set number  " line numbers
set statusline=%f\ %m%=%c:%l/%L\ %P
set wildmenu
set pumheight=7
set completeopt=menu
set scrolloff=5  " when scrolling, show 5 lines above and below the cursor
set textwidth=0
set winminheight=0
set noequalalways
set ttymouse=sgr  " for columns beyond 223
set fillchars=vert:\│,fold:-
set noexpandtab
set shiftwidth=8
set softtabstop=8
set tabstop=8

let maplocalleader = ","
autocmd BufNewFile,BufRead * setlocal formatoptions=croqt

if filereadable('tags')
    set tags=tags
endif

" Width of a commit message title
au FileType gitcommit set tw=78

" Highlight tabs
highlight Tab ctermbg=234
match Tab /\t/
autocmd BufWinEnter * match Tab /\t/
autocmd InsertEnter * match Tab /\t/
autocmd InsertLeave * match Tab /\t/
autocmd BufWinLeave * call clearmatches()

" Ctrl-arrows split window navigation
map <silent> <ESC>Od :wincmd h<CR>
map <silent> <ESC>Oc :wincmd l<CR>
map <silent> <ESC>[1;5D :wincmd h<CR>
map <silent> <ESC>[1;5C :wincmd l<CR>
"map <silent> <ESC>Oa :wincmd k<CR>
"map <silent> <ESC>Ob :wincmd j<CR>
map <silent> <ESC>Oa :wincmd k<CR><C-W>_
map <silent> <ESC>Ob :wincmd j<CR><C-W>_
map <silent> <ESC>[1;5A :wincmd k<CR><C-W>_
map <silent> <ESC>[1;5B :wincmd j<CR><C-W>_
map <silent> <C-k> :wincmd k<CR>
map <silent> <C-j> :wincmd j<CR>

" ,w+ and ,w- to maximize and minimize split windows
map <LocalLeader>w+ 100<C-w>+
map <LocalLeader>w- 100<C-w>-

" Airline
let g:airline_section_x = ""
let g:airline_section_y = ""
let g:airline_section_warning = ""
" let g:airline_theme = "murmur"
let g:airline_theme = "base16_bright"
let g:airline_powerline_fonts = 1
set ttimeoutlen=10

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.colnr = '㏇'
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ' '
let g:airline_symbols.whitespace = ' '
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.ellipsis = '…'

" Allow tabs in Makefiles.
autocmd FileType make,automake set noexpandtab shiftwidth=8 softtabstop=8

" Ack config
if executable('rg')
  let g:ackprg = 'rg --vimgrep -u'
endif
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
let g:ackhighlight = 1
let g:ackpreview = 1
