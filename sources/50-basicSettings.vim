set encoding=utf-8
set backspace=indent,eol,start
set laststatus=2
set clipboard=unnamedplus

set viminfo=<800,'100,/50,:100,h,n~/.vim/viminfo
"            |    |    |   |    | + viminfo file path
"            |    |    |   |    + disable 'hlsearch' loading viminfo
"            |    |    |   + command-line history saved
"            |    |    + search history saved
"            |    + files marks saved
"            + lines saved each register (old name for <, vi6.2)


set nolazyredraw " Watch what I can do
set nowrapscan " wrapping around the end of the file for searches
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
set wrap
set linebreak
set showbreak=∵∴∵



set background=dark


set shortmess+=c
set cmdheight=1

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
"let g:netrw_banner=0 "Disable Banner
"let g:netrw_browse_split=4 "open in prior window
let g:netrw_liststyle=3 " tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

"Wild Menu
set wildmenu
set wildmode=longest,list,full
autocmd FileType * setlocal
    \ formatoptions-=c
    \ formatoptions-=r
    \ formatoptions-=o
    \ formatoptions-=l
