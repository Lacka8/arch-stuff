" Some of the settings came form https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim

" General

" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" :W sudo saves the file
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Interface

" Turn on the Wild menu
set wildmenu

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Show incremental search results
set incsearch

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" Show relative line number and current line number
set number relativenumber

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Tabulating

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2

" smart auto indenting
set autoindent
set smartindent

" Status line
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Mappings

" Move a line of text using ALT+[jk]
nnoremap <A-j> mz:m+<cr>==
nnoremap <A-k> mz:m-2<cr>==
" vmap <A-j> :m'>+<cr>`<my`>mzgv`yo`z
" vmap <A-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trialing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" Unhighlight search resoults with Esc
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" powerline
let g:powerline_pycmd="python3"

