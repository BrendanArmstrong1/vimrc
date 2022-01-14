set encoding=utf-8
set backspace=indent,eol,start
set laststatus=2
if has("macunix") || has('win32')
  set clipboard=unnamed
elseif has("unix")
  set clipboard=unnamedplus
endif

set viminfo=%,<800,'100,/50,:100,h,n~/.vim/settings/viminfo
"           | |    |    |   |    | + viminfo file path
"           | |    |    |   |    + disable 'hlsearch' loading viminfo
"           | |    |    |   + command-line history saved
"           | |    |    + search history saved
"           | |    + files marks saved
"           | + lines saved each register (old name for <, vi6.2)
"           + save/restore buffer list


"set lazyredraw " NoNoNo, Just No
set number relativenumber
set ruler
set showmatch
set cpoptions+=>
set noswapfile
set noerrorbells
set title
set splitbelow splitright
set updatetime=1000
set timeout timeoutlen=1000 ttimeoutlen=50
set hidden
let &titleold="Terminal"
set signcolumn=yes
"Line wrapping
set nowrap
set linebreak
set showbreak=+++

set completeopt=menuone,popup,noinsert
set complete+=kspell
set complete-=i
set completepopup=height:20,width:70
set shortmess+=c

"Undo stuff
set undodir=~/.vim/undodir
set undofile
set undolevels=10000

"Tab stuff
set tabstop=4 softtabstop=4 expandtab autoindent smartindent smarttab

"Shift stuff
set shiftwidth=4 shiftround

"Search stuff
set incsearch ignorecase smartcase

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

"File Browsing
set path=.,./**,,
let g:netrw_banner=0 "Disable Banner
let g:netrw_browse_split=4 "open in prior window
let g:netrw_altv=1 " open splits to the right
let g:netrw_liststyle=3 " tree view
let g:netrw_winsize=20 " Window size
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
let g:NetrwIsOpen=0

" auto-completion
"set omnifunc=syntaxcomplete#Complete
set thesaurus=~/.vim/thesaurus/english.txt
"Wild Menu
set wildmenu
set wildmode=longest,list,full
autocmd FileType * setlocal
    \ formatoptions-=c
    \ formatoptions-=r
    \ formatoptions-=o
    \ formatoptions-=l

