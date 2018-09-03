"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My Vim Config File
"
"
"
" Overview:
" --> Basic
" --> Interface
" --> Colors and Fonts
" --> Files and backups
" --> Text, tab and indent related
" --> Moving around, tabs and buffers
" --> Status line
" --> Editing mappings
" --> vimgrep searching and cope displaying
" --> Filetypes 
" --> Spell checking
" --> Misc
" --> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic

" Plugins
set nocp

execute pathogen#infect()
syntax on
filetype plugin indent on

" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread
set mouse=a

" Set Colum numbers
set number
set foldcolumn=1

"Set MAPLeader and fast saving
let mapleader = ","

nmap<leader>w :w!<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Interface

"Turn on the wild menu
set wildmenu

"ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

"Always show current position
set ruler

" better backspace behaviour
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance)
set lazyredraw 

" regular expressions
set magic

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts

" Enable syntax highlighting
syntax enable 
" Enable 256 colors palette in Gnome Terminal

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

try
  colorscheme gruvbox
catch
endtry

set background=dark

" Set utf8 as standard encoding
set encoding=utf8
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around, tabs, windows and buffers

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" New Window
set splitbelow
set splitright

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>tq :tabclose<cr>
 
map <leader>tl :tabnext<cr>


" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files 
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing mappings

" Remap VIM 0 to first non-blank character
map 0 ^

" Closing braces
inoremap {  {}<Left>
inoremap [  []<Left>
inoremap (  ()<Left>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes

" Latex
autocmd Filetype tex,latex nnoremap <buffer> <leader>c :!pdflatex %:p:h/*.tex<cr>:!evince %:p:h/*.pdf<cr>

" Java
let JavaMainFile='Java_Main_File_not_set'
autocmd Filetype java nnoremap <buffer> <leader>c :!javac %:p:h/*.java<cr>:execute '!java ' . JavaMainFile<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spell Checking

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper Functions

function! HasPaste()
      if &paste
return 'PASTE MODE  '
endif
return ''
endfunction

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
let l:currentBufNum = bufnr("%")
let l:alternateBufNum = bufnr("#")

if buflisted(l:alternateBufNum)
buffer #
else
bnext
endif

if bufnr("%") == l:currentBufNum
new
endif

if buflisted(l:currentBufNum)
execute("bdelete! ".l:currentBufNum)
endif
endfunction

function! CmdLine(str)
call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
let l:saved_reg = @"
execute "normal! vgvy"

let l:pattern = escape(@", "\\/.*'$^~[]")
let l:pattern = substitute(l:pattern, "\n$", "", "")

if a:direction == 'gv'
call CmdLine("Ack '" . l:pattern . "' " )
elseif a:direction == 'replace'
call CmdLine("%s" . '/'. l:pattern . '/')
endif

let @/ = l:pattern
let @" = l:saved_reg
endfunction

