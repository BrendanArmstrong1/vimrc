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

    Plug 'vim-jp/vital.vim'

    " File finding
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter' " find project root auto
    Plug 'mhinz/vim-startify' " splash screen
    Plug 'tpope/vim-vinegar' " netrw enhancement

    " Colours
    Plug 'romgrk/doom-one.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'BourgeoisBear/clrzr'
    Plug 'machakann/vim-highlightedyank'

    " Vim heuristics (more functionality)
    Plug 'sheerun/vim-polyglot'
    Plug 'vim-syntastic/syntastic'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-repeat'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-scriptease'
    Plug 'AndrewRadev/splitjoin.vim'

    "Git stuff
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'rhysd/git-messenger.vim'
    Plug 'airblade/vim-gitgutter'

    " Vim in-frame navigation
    Plug 'svban/YankAssassin.vim' " cursor stay in place after yank
    Plug 'haya14busa/vim-asterisk'
    Plug 'haya14busa/is.vim'
    Plug 'justinmk/vim-sneak'
    Plug 'psliwka/vim-smoothie'

    " Broad file simultaneous edit
    Plug 'dyng/ctrlsf.vim'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}

    " typist help
    Plug 'tpope/vim-endwise'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-rsi'
    Plug 'SirVer/ultisnips' "Ultisnips from 'honza/vim-snippets'

    " Code Execution
    Plug 'thinca/vim-quickrun'

    " Org mode in vim
    Plug 'vimwiki/vimwiki'
    Plug 'itchyny/calendar.vim'

call plug#end()

filetype plugin indent on
syntax enable

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    q
endif

source $HOME/.vim/cache/calendar.vim/credentials.vim
source $HOME/.vim/sources/50-bracketed-paste.vim
source $HOME/.vim/sources/50-Signify.vim
source $HOME/.vim/sources/50-pluginSettings.vim
source $HOME/.vim/sources/50-basic-settings.vim
source $HOME/.vim/sources/50-git.vim
source $HOME/.vim/sources/50-FuzzyFind.vim
source $HOME/.vim/sources/50-Ultisnips.vim
source $HOME/.vim/sources/50-autostuff.vim

" TODO CoC integration plus fix the autocomplete function in general
" TODO Set up project management with vimwiki and taskwarrior
" TODO Clean up personal scripts section of the mappings.
" TODO Fix calendar and get it synced with google
" TODO get better terminal motions. Its hard to move around.
" TODO set up ctrlsf. Fix interaction with multicursor and inc search
" DONE FZF ripgrep needs to ignore .gitignore but also ignore .git
" DONE Searching movements with incsearch and sneak.

"======================================================
" ____                                  _
"|  _ \ ___ _ __ ___   __ _ _ __  _ __ (_)_ __   __ _
"| |_) / _ \ '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` |
"|  _ <  __/ | | | | | (_| | |_) | |_) | | | | | (_| |
"|_| \_\___|_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |
"                          |_|   |_|            |___/
"======================================================

nnoremap <space> <NOP>
let mapleader="\<space>"

nnoremap Q !!sh<CR>
nmap <silent> <leader>cd <CMD>cd %:p:h<CR>
nnoremap <silent> <leader>en <CMD>call myfunc#ExecuteStuff('right')<CR>
nnoremap <silent> <leader>eh <CMD>call myfunc#ExecuteStuff('bot')<CR>
nnoremap <silent> <leader>ih <CMD>call myfunc#Resize_Execution_Term(20)<CR
nnoremap <silent> <leader>il <CMD>call myfunc#Resize_Execution_Term(-20)<CR>


nnoremap <silent> <leader>qq <CMD>call myfunc#Quitout()<CR>
nnoremap <silent> <leader>qw <CMD>call myfunc#SaveQuitout()<CR>
nnoremap <silent> <leader>qf <CMD>Startify<CR>
nnoremap <silent> <leader>qt <CMD>call Terminal#CloseTerm()<CR>

" Toggling stuff
nnoremap <silent> <leader>ts <Cmd>setlocal spell! spelllang=en_ca<CR>
nnoremap <silent> <leader>ec <Cmd>Calendar -position=tab<CR>


" Git Mapping
nnoremap <silent> <leader>gg <CMD>G<CR>
nmap <leader>gP <CMD>Git push<CR>
nmap <silent> ]g <Plug>(GitGutterPrevHunk)
nmap <silent> [g <Plug>(GitGutterNextHunk)
nmap <silent> <leader>gs <Plug>(GitGutterStageHunk)
nmap <silent> <leader>gu <Plug>(GitGutterUndoHunk)

" Quickrun mappings
nmap <leader>gr <Plug>(quickrun)
xmap gr :QuickRun<CR>
nmap gr <Plug>(quickrun-op)
nmap grr mt^gr$g`t

nnoremap <silent> <leader>ic :<C-U>%s/\<<c-r><c-w>\>//gn<CR>g``
nnoremap <leader>rs :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>

" Source stuff
nnoremap <silent> <leader>R <CMD>so$MYVIMRC<CR>
nnoremap <silent> <leader>T <CMD>so %<CR>

" Open stuff
nnoremap <silent> <leader>os <Cmd>UltiSnipsEdit<CR>
nnoremap <silent> <leader>or <Cmd>e $MYVIMRC<CR>

nnoremap <silent> <c-x><c-s> <CMD>w!<CR>
nmap gf :edit <cfile><CR>
nmap <C-W><C-F> <CMD>vsplit <cfile><CR>

" Move in visual lines
nmap <expr> j (v:count? 'j' : 'gj')
nmap <expr> k (v:count? 'k' : 'gk')

" revisual after indent
xnoremap < <gv
xnoremap > >gv

" scroll stuff
let g:smoothie_no_default_mappings = 1
nmap <unique> <C-D>      <Plug>(SmoothieDownwards)
nmap <unique> <C-U>      <Plug>(SmoothieUpwards)
noremap <expr> <C-e> repeat("\<C-e>", 5)
noremap <expr> <C-y> repeat("\<C-y>", 5)

" Window switching
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-w>h <c-w>H
noremap <c-w>l <c-w>L
noremap <c-w>j <c-w>J
noremap <c-w>k <c-w>K

" Terminal stuff
map <C-w><C-t> <CMD>vert ter<CR>
tmap <C-Esc> <C-\><C-n>

" Inc search stuff
set hlsearch
let g:asterisk#keeppos = 1
map *  <Plug>(asterisk-*)<Plug>(is-nohl-1)
map g* <Plug>(asterisk-g*)<Plug>(is-nohl-1)
map #  <Plug>(asterisk-#)<Plug>(is-nohl-1)
map g# <Plug>(asterisk-g#)<Plug>(is-nohl-1)
map z*  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map zg* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map z#  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map zg# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)

let g:sneak#f_reset = 1
let g:sneak#t_reset = 1
let g:sneak#absolute_dir = 1
let g:sneak#use_ic_scs = 1 " case sensitivity
let g:sneak#map_netrw = 1
let g:sneak#prompt = '>>> '
" fine movement
map s <Plug>Sneak_s
map S <Plug>Sneak_S
map t <Plug>Sneak_t
map T <Plug>Sneak_T
map f <Plug>Sneak_f
map F <Plug>Sneak_F

" Solving surround remap with Xurround pnemonic. 'X' works better for colmak
" https://github.com/justinmk/vim-sneak/issues/268
let g:surround_no_mappings= 1
xmap x <Plug>VSurround
nmap yxx <Plug>Yssurround
nmap yx  <Plug>Ysurround
nmap dx  <Plug>Dsurround
nmap cx  <Plug>Csurround

" Fuzzy Finder Stuff
" Project
let g:rooter_cd_cmd = 'lcd'
let g:rooter_change_directory_for_non_project_files = ''
let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']
nmap <leader>pc  <CMD>BCommits<CR>
nmap <leader>p/  <CMD>RG<CR>
nmap <leader>pf  <CMD>Files<CR>
nmap <leader>pp  <CMD>GFiles<CR>
nmap <leader>pg  <CMD>GFiles?<CR>
nmap <leader>pl  <CMD>Lines<CR>
nmap <leader>p]  <CMD>Tags<CR>
" Files
nmap <leader>fL  :Locate ""<left>
nmap <leader>fb  <CMD>Buffers<CR>
nmap <leader>ff  <CMD>ProjectFiles<CR>

nmap <leader>gm  <CMD>GitMessenger<CR>
" Copy the GitHub deeplink for the selected lines (requires Fugitive/Rhubarb)
vmap <leader>gb  <CMD>'<,'>GBrowse!<CR>
" Navigate to the GitHub deeplink for the selected lines (requires Fugitive/Rhubarb)
vmap <leader>gB  <CMD>'<,'>GBrowse<CR>
" Tag Jumping with ctags
command! MakeTags !ctags -R .







" Calendar!!!

function! s:prefix_zero(num) abort
  if a:num < 10
    return '0'.a:num
  endif
  return a:num
endfunction

" Callback function for Calendar.vim
function! DiaryDay(day, month, year, week, dir, wnum) abort
  let day = s:prefix_zero(a:day)
  let month = s:prefix_zero(a:month)

  let link = a:year.'-'.month.'-'.day
  if winnr('$') == 1
    if a:dir ==? 'V'
      vsplit
    else
      split
    endif
  else
    wincmd p
    if !&hidden && &modified
      new
    endif
  endif

  call vimwiki#diary#make_note(a:wnum, 0, link)
endfunction

autocmd FileType calendar nmap <buffer> <CR>
    \ :call DiaryDay(b:calendar.day().get_day(), b:calendar.day().get_month(),
    \ b:calendar.day().get_year(), b:calendar.day().week(), "V", v:count1)<CR>
