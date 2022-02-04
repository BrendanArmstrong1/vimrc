"==============================
"|        _
"| __   _(_)_ __ ___  _ __ ___
"| \ \ / / | '_ ` _ \| '__/ __|
"|  \ V /| | | | | | | | | (__
"|   \_/ |_|_| |_| |_|_|  \___|
"|
"==============================
set nocompatible
let need_to_install_plugins = 0
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let need_to_install_plugins = 1
endif

call plug#begin('~/.vim/plugged')
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'romgrk/doom-one.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'BourgeoisBear/clrzr'

    Plug 'machakann/vim-highlightedyank'
    Plug 'svban/YankAssassin.vim'

    Plug 'sheerun/vim-polyglot'
    Plug 'vim-syntastic/syntastic'

    Plug 'vim-jp/vital.vim'

    "Git stuff
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'rhysd/git-messenger.vim'
    Plug 'airblade/vim-gitgutter'

    Plug 'justinmk/vim-sneak'
    Plug 'easymotion/vim-easymotion'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'jiangmiao/auto-pairs'

    Plug 'mhinz/vim-startify'

    Plug 'vimwiki/vimwiki'
    Plug 'itchyny/calendar.vim'

    Plug 'SirVer/ultisnips' "Ultisnips from 'honza/vim-snippets'
call plug#end()

filetype plugin indent on
syntax enable

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    q
endif

source /home/brendan/.vim/cache/calendar.vim/credentials.vim

for rcfile in split(globpath("~/.vim/sources", "*.vim"), "\n")
    execute('source ' . rcfile)
endfor

"======================================================
" ____                                  _
"|  _ \ ___ _ __ ___   __ _ _ __  _ __ (_)_ __   __ _
"| |_) / _ \ '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` |
"|  _ <  __/ | | | | | (_| | |_) | |_) | | | | | (_| |
"|_| \_\___|_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |
"                          |_|   |_|            |___/
"======================================================

nnoremap Q !!sh<CR>
nnoremap <space> <NOP>
let mapleader="\<space>"

nmap <silent> <leader>cd <CMD>cd %:p:h<CR>
nnoremap <silent> <leader>en <CMD>call myfunc#ExecuteScript('right')<CR>
nnoremap <silent> <leader>eh <CMD>call myfunc#ExecuteScript('bot')<CR>
nnoremap <silent> <leader>ih <CMD>call myfunc#Resize_Execution_Term(20)<CR>
nnoremap <silent> <leader>il <CMD>call myfunc#Resize_Execution_Term(-20)<CR>

nnoremap <silent> <leader>b <Cmd>call myfunc#ToggleNetrw()<CR>
nnoremap <silent> <c-x><c-s> <CMD>wq!<CR>

nnoremap <silent> <leader>qq <CMD>call myfunc#Quitout()<CR>
nnoremap <silent> <leader>qw <CMD>call myfunc#SaveQuitout()<CR>
nnoremap <silent> <leader>qf <CMD>Startify<CR>
nnoremap <silent> <leader>qt <CMD>call myfunc#CloseTerm()<CR>

" Toggling stuff
nnoremap <silent> <leader>ts <Cmd>setlocal spell! spelllang=en_ca<CR>

nnoremap <silent> <leader>S <Cmd>UltiSnipsEdit<CR>
nnoremap <silent> <leader>R <Cmd>e $MYVIMRC<CR>
nnoremap <silent> <leader>% <CMD>so$MYVIMRC<CR>

nnoremap <silent> <leader>gg <CMD>G<CR>
nnoremap <silent> <leader>ic :<C-U>%s/\<<c-r><c-w>\>//gn<CR>g``
nnoremap <leader>rs :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>

xnoremap < <gv
xnoremap > >gv

nmap gf :edit <cfile><CR>
nmap <C-W><C-F> :vsplit <cfile><CR>

nmap <silent> [g <Plug>(GitGutterPrevHunk)
nmap <silent> ]g <Plug>(GitGutterNextHunk)
nmap <silent> <leader>gs <Plug>(GitGutterStageHunk)
nmap <silent> <leader>gu <Plug>(GitGutterUndoHunk)

nmap <expr> j (v:count? 'j' : 'gj')
nmap <expr> k (v:count? 'k' : 'gk')

imap <c-x><c-k> <c-x><c-k>
imap <c-x><c-l> <c-x><c-l>
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k

let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T


set encoding=utf-8
set backspace=indent,eol,start
set laststatus=2
if has("macunix") || has('win32')
  set clipboard=unnamed
elseif has("unix")
  set clipboard=unnamedplus
endif

set viminfo=<800,'100,/50,:100,h,n~/.vim/viminfo
"            |    |    |   |    | + viminfo file path
"            |    |    |   |    + disable 'hlsearch' loading viminfo
"            |    |    |   + command-line history saved
"            |    |    + search history saved
"            |    + files marks saved
"            + lines saved each register (old name for <, vi6.2)


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

set completeopt=menuone,popup
set complete+=kspell
set complete-=i
set completepopup=height:20,width:70
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
set path=.,**,,
let g:netrw_banner=0 "Disable Banner
let g:netrw_browse_split=4 "open in prior window
let g:netrw_liststyle=3 " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

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

set termguicolors
let &t_8f = "\e[38;2;%lu;%lu;%lum" "sets foreground color (ANSI, true-color mode)
let &t_8b = "\e[48;2;%lu;%lu;%lum" "sets background color (ANSI, true-color mode)
let g:clrzr_startup = 0





"============================================================================
"====================  _____ __________ =====================================
"==================== |  ___|__  /  ___|=====================================
"==================== | |_    / /| |_   =====================================
"==================== |  _|  / /_|  _|  =====================================
"==================== |_|   /____|_|    =====================================
"====================                   =====================================
"============================================================================
let g:fzf_preview_window = ['up:60%:hidden', 'ctrl-/']

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)


