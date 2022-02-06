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
    Plug 'easymotion/vim-easymotion'
    Plug 'haya14busa/incsearch.vim'
    Plug 'haya14busa/incsearch-fuzzy.vim'
    Plug 'haya14busa/incsearch-easymotion.vim'
    Plug 'haya14busa/vim-asterisk'
    Plug 'psliwka/vim-smoothie'

    " Broad file simultaneous edit
    Plug 'dyng/ctrlsf.vim'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}

    " typist help
    Plug 'tpope/vim-endwise'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-rsi'
    Plug 'SirVer/ultisnips' "Ultisnips from 'honza/vim-snippets'

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
nnoremap <silent> <leader>ih <CMD>call myfunc#Resize_Execution_Term(20)<CR
nnoremap <silent> <leader>il <CMD>call myfunc#Resize_Execution_Term(-20)<CR>


nnoremap <silent> <leader>qq <CMD>call myfunc#Quitout()<CR>
nnoremap <silent> <leader>qw <CMD>call myfunc#SaveQuitout()<CR>
nnoremap <silent> <leader>qf <CMD>Startify<CR>
nnoremap <silent> <leader>qt <CMD>call myfunc#CloseTerm()<CR>

" Toggling stuff
nnoremap <silent> <leader>ts <Cmd>setlocal spell! spelllang=en_ca<CR>
nnoremap <silent> <leader>ec <Cmd>Calendar -position=tab<CR>


" Git Mapping
nnoremap <silent> <leader>gg <CMD>G<CR>
nmap <leader>gp <CMD>Git push<CR>
nmap <silent> [g <Plug>(GitGutterPrevHunk)
nmap <silent> ]g <Plug>(GitGutterNextHunk)
nmap <silent> <leader>gs <Plug>(GitGutterStageHunk)
nmap <silent> <leader>gu <Plug>(GitGutterUndoHunk)

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
nmap <C-W><C-F> :vsplit <cfile><CR>

" Move in visual lines
nmap <expr> j (v:count? 'j' : 'gj')
nmap <expr> k (v:count? 'k' : 'gk')

" revisual after indent
xnoremap < <gv
xnoremap > >gv

" scroll stuff
noremap <expr> <C-e> repeat("\<C-e>", 3)
noremap <expr> <C-y> repeat("\<C-y>", 3)

" Window switching
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k

" Navigation with IncSearch
set hlsearch
let g:incsearch#consistent_n_direction = 1
let g:incsearch#auto_nohlsearch = 1
let g:incsearch#separate_highlight = 0
let g:incsearch#no_inc_hlsearch = 0
let g:incsearch#do_not_save_error_message_history = 0
let g:asterisk#keeppos = 1
map /  <Plug>(incsearch-nohl)<Plug>(incsearch-forward)
map ?  <Plug>(incsearch-nohl)<Plug>(incsearch-backward)
map g/ <Plug>(incsearch-nohl)<Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *   <Plug>(incsearch-nohl)<Plug>(asterisk-*)
map g*  <Plug>(incsearch-nohl)<Plug>(asterisk-g*)
map #   <Plug>(incsearch-nohl)<Plug>(asterisk-#)
map g#  <Plug>(incsearch-nohl)<Plug>(asterisk-g#)
map z*  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)
map gz* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)
map z#  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)
map gz# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)

" Navigation with Easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_startofline = 0 " keep cursor colum JK motion
let g:EasyMotion_move_highlight = 1 " LAGGY!! turn off if ; and , lag
let g:EasyMotion_verbose = 0
let g:EasyMotion_keys = 'neioluy]arstzxcdqwfpb'
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyspell#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

" Searching across buffers
nmap gsb <Plug>(easymotion-overwin-f2)
nmap gsl <Plug>(easymotion-overwin-line)
nmap <silent><expr> gs<Space> incsearch#go(<SID>config_easyfuzzymotion())

nmap ; <Plug>(incsearch-nohl)<Plug>(easymotion-next)
nmap , <Plug>(incsearch-nohl)<Plug>(easymotion-prev)
map gsn <Plug>(easymotion-bd-n)
map gs. <Plug>(easymotion-repeat)

" up/down course motions
map <leader>J <Plug>(easymotion-sol-j)
map <leader>K <Plug>(easymotion-sol-k)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

" Correct line movement with easymotion
let g:EasyMotion_re_line_anywhere = '\v' .
        \       '(<.|^$)' . '|' .
        \       '(>.|^$)' . '|' .
        \       '(\l)\zs(\u)' . '|' .
        \       '(_\zs.)' . '|' .
        \       '(#\zs.)'

" linewise course movement
map b <Plug>(easymotion-linebackward)
map B <Plug>(easymotion-bl)
map w <Plug>(easymotion-lineforward)
map W <Plug>(easymotion-wl)
map E <Plug>(easymotion-bd-el)
map e <Plug>(easymotion-lineanywhere)

" linewise fine movement
map t <Plug>(incsearch-nohl)<Plug>(easymotion-bd-tl)
map f <Plug>(incsearch-nohl)<Plug>(easymotion-sl)

" bi-directional fine movement
map T <Plug>(incsearch-nohl)<Plug>(easymotion-bd-t2)
map F <Plug>(incsearch-nohl)<Plug>(easymotion-s2)
map s <Plug>(incsearch-nohl)<Plug>(easymotion-sn)

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
