" --------------------------------------------------------------------------------
" Vundle
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" --------------------------------------------------------------------------------
set nocompatible    " be iMproved, required
filetype off        " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'gregsexton/MatchTag'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
" snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'python.vim'
Plugin 'surround.vim'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required


" ignore modeline
set nomodeline

" no ToolBar
set go=aeg

set encoding=utf-8
set fileencodings=latin-1,utf-8
set termencoding=utf-8
set fileformats=unix

syntax enable

" Color Scheme
if !has('gui_running')
  " Compatibility for Terminal
  let g:solarized_termtrans=1
  if $TERM == 'xterm-256color'
    set t_Co=256
  else
    " Make Solarized use 16 colors for Terminal support
    let g:solarized_termcolors=16
  endif
endif

set background=dark
colorscheme solarized "desert  

" auto reload .vimrc
autocmd! bufwritepost .vimrc source ~/.vimrc

" no error bell
set noeb

" Font
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    "Mac options here
    set gfn=Monaco:h14
  else
    set gfn=Monaco\ 11
  endif
endif
"set gfn=Inconsolata:h16
"set gfn=DroidSansMono\ 11 "Monaco\ 11

" highlight search terms
set hlsearch
" show search matches as you type
set incsearch

set nobackup
set noswapfile

" show line number
set number

" always show status line
set laststatus=2

" better auto complete command mode
set wildmenu

set wildignore+=*.o,*~,*.pyc,*.so,*.png,*.jpg
set suffixes+=.in,.a

" spell check
set spelllang=en_us
set spell

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" --------------------------------------------------------------------------------
" configure editor with tabs and nice stuff...
" --------------------------------------------------------------------------------
set textwidth=120        " break lines when line length increases
set fo=cqt
set wm=0

set tabstop=2           " use 4 spaces to represent tab
set shiftwidth=2        " number of spaces to use for auto indent
set softtabstop=2
set autoindent          " copy indent from current line when starting a new line

" make backspaces more powerful
set backspace=indent,eol,start

" save and restor fold
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

" ======================
" Compile and Run
" ======================
nmap ,com :call Compile()<cr>
nmap ,car :call CompileAndRun()<cr>
function! Compile()
	if expand("%:e") == "cpp"
		execute "w"
		execute "!g++ -o %:r %"
	elseif expand("%:e") == "java"
		execute "w"
		execute "!javac %:p"
	elseif expand("%:e") == "erl"
		execute "w"
		execute "!erlc %:p"
	endif
endfunction
function! CompileAndRun()
	if expand("%:e") == "cpp"
		exec "w"
		exec "!g++ -o %:r % && ./%:r"
	elseif expand("%:e") == "java"
		exec "w"
		exec "!javac %:p && java -cp %:p:h %:t:r"
    elseif expand("%:e") == "py"
		exec "w"
		exec "!python %:p"
	endif
endfunction

" ======================
" Tab control
" ======================
" go to prev tab 
nmap <S-H> gT
" go to next tab
nmap <S-L> gt

" ======================
" Windows control
" ======================
nmap <C-J> <C-w>j
nmap <C-K> <C-w>k
nmap <C-H> <C-w>h
nmap <C-L> <C-w>l

nmap ,wv <C-w>v
nmap ,wc <C-w>c
nmap ,ws <C-w>s

" =======================
" MiniBufferExplorer
" =======================
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplSplitBelow=0
let g:miniBufExplDebugLevel=0
"map <F3> :MBEbp<cr>
"map <F4> :MBEbn<cr>
"nmap <S-H> :MBEbp<cr>
"nmap <S-L> :MBEbn<cr>

" =======================
" NERD Tree
" =======================
let g:NERDTreeWinPos = "right"
let g:NERDChristmasTree = 1
let g:NEROTreeWinSize = 20
map <F5> :NERDTree<cr>
map <F6> :NERDTreeClose<cr>
let NERDTreeIgnore=['\.pyc$', '\~$']

" =======================
" Tagbar
" =======================
nmap <F7> :TagbarToggle<CR> 

" =======================
" SnipMate
" =======================
let g:snips_author = "Wenbin Wu  admin@wenbinwu.com"

" =======================
" Syntastic
" =======================
map ,sc :SyntasticCheck<cr>
let g:syntastic_check_on_open=1
let g:syntastic_mode_map = { 'mode': 'active',
													 \ 'active_filetypes': ['python'],
													 \ 'passive_filetypes': ['puppet'] }

" ======================
" ctrlp
" ======================
let g:ctrlp_working_path_mode = 2
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/var/*,*/build/*,*/regress/*,*/virtualenv/*   " for Linux/MacOSX
let g:ctrlp_clear_cache_on_exit = 1

" =======================
" Files
" =======================
au BufRead,BufNewFile *.c set noexpandtab
au BufRead,BufNewFile *.h set noexpandtab
au BufRead,BufNewFile Makefile* set noexpandtab
au BufRead,BufNewFile *.html set noexpandtab

" =======================
" Python
au BufEnter,BufNewFile *.py set expandtab | set list! | set listchars=tab:>
autocmd FileType python setl sw=4 | setl ts=4 | setl sts=4

" ======================
" JS
autocmd BufEnter,BufReadPre *.js setl ts=2 | setl sts=2 | setl sw=2 | setl expandtab

" ======================
" HTML
au BufEnter,BufNewFile *.html set expandtab | set list! | set listchars=tab:>-
autocmd BufEnter,BufReadPre *.html setl ts=2 | setl sts=2 | setl sw=2

" ======================
" Less
" compile less
nnoremap ,m :w <BAR> !lessc % > %:p:r.css<CR><space>

" =====================
" tags
" =====================
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Mac options here
    set tags=/Users/wwu/tags
  else
    " Ubuntu only
    set tags=/home/wwu/.tags
  endif
endif
