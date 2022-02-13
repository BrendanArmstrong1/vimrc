"|   \_/ |_|_| |_| |_|_|  \___|
"|
"==============================
set nocompatible
let need_to_install_plugins = 0
" Disable polyglot in favour of vim sleuth
let g:polyglot_disabled = ['autoindent']

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
    Plug 'justinmk/vim-dirvish'
    Plug 'roginfarrer/vim-dirvish-dovish'

    " Colours
    Plug 'sainnhe/sonokai'
    Plug 'itchyny/lightline.vim'
    Plug 'machakann/vim-highlightedyank'

    " Vim heuristics (more functionality)
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-sleuth'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-scriptease'
    Plug 'AndrewRadev/splitjoin.vim'

    " Auto Completion and linting
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
    Plug 'kitagry/asyncomplete-tabnine.vim', { 'do': './install.sh' }
    Plug 'htlsne/asyncomplete-look'
    Plug 'SirVer/ultisnips'

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
source $HOME/.vim/sources/50-basicSettings.vim
source $HOME/.vim/sources/50-completionSettings.vim
source $HOME/.vim/sources/50-autostuff.vim

" DONE CoC integration plus fix the autocomplete function in general
"       - went with a language server  with asyncomplete instead.
" TODO Set up project management with vimwiki and taskwarrior
" TODO Clean up personal scripts section of the mappings.
" TODO Fix calendar and get it synced with google
" TODO get better terminal motions. Its hard to move around.
" TODO set up ctrlsf. Fix interaction with multicursor and inc search
" DONE FZF ripgrep needs to ignore .gitignore but also ignore .git
" DONE Searching movements with incsearch and sneak.
" TODO Change fzf window to a split of some sort
" DONE SWITCH TO COLMAK regular version


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

" Completion and linting
set omnifunc=lsp#complete
let g:asyncomplete_auto_completeopt = 0
source /home/brendan/.vim/sources/50-Ultisnips.vim
" Ultisnips settings
let g:UltiSnipsExpandTrigger="<NOP>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

source /home/brendan/.vim/sources/50-Async.vim
" Toggling stuff
nnoremap <silent> <leader>ts <Cmd>call myAsyncFuncs#ToggleSpell()<CR>
nnoremap <silent> <leader>ta <Cmd>call myAsyncFuncs#ToggleTabnine()<CR>
nnoremap <silent> <leader>tu <Cmd>call myAsyncFuncs#ToggleUltisnips()<CR>

" hacky pop up close workaround
function s:myCompletionConfirm() abort
  let l:items = complete_info(['items', 'selected'])
  let l:selected = l:items['items'][l:items['selected']]
  if stridx(l:selected['menu'], "Snips:") == 0
      return "\<c-r>=asyncomplete#close_popup()\<CR>\<c-r>=UltiSnips#ExpandSnippet()\<CR>"
  else
      return "\<c-r>=asyncomplete#close_popup()\<CR>"
  endif
endfunction
inoremap <expr> <CR> <c-r>=asyncomplete#cancel_popup()<CR><CR>
inoremap <expr> <C-y> pumvisible() ? <SID>myCompletionConfirm()  : "\<C-y>"
inoremap <expr> <C-e> pumvisible() ? asyncomplete#cancel_popup() : "\<C-e>"
let g:AutoPairsMapCh = 0


source /home/brendan/.vim/sources/50-AutoPairs.vim " tabing out
" Window switching
noremap <c-l> <c-w>l
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-w>h <c-w>H
noremap <c-w>l <c-w>L
noremap <c-w>j <c-w>J
noremap <c-w>k <c-w>K
imap <expr> <c-j> pumvisible() ? "\<down>" : "\<c-j>"
imap <expr> <c-k> pumvisible() ? "\<up>" : "\<c-k>"

" scroll stuff
let g:smoothie_no_default_mappings = 1
nmap <C-D>      <Plug>(SmoothieDownwards)
nmap <C-U>      <Plug>(SmoothieUpwards)
noremap <expr> <C-e> repeat("\<C-e>", 5)
noremap <expr> <C-y> repeat("\<C-y>", 5)

nnoremap Q !!sh<CR>
nmap <silent> <leader>cd <CMD>cd %:p:h<CR>


source $HOME/.vim/sources/50-Signify.vim
nnoremap <silent> <leader>qq <CMD>call myfunc#Quitout()<CR>
nnoremap <silent> <leader>qw <CMD>call myfunc#SaveQuitout()<CR>
nnoremap <silent> <leader>qf <CMD>Startify<CR>
nnoremap <silent> <leader>qt <CMD>call Terminal#CloseTerm()<CR>




source $HOME/.vim/sources/50-git.vim
" Git Mapping
nnoremap <silent> <leader>gg <CMD>G<CR>
nmap <leader>gP <CMD>Git push<CR>
nmap <silent> [d <Plug>(GitGutterPrevHunk)
nmap <silent> ]d <Plug>(GitGutterNextHunk)
nmap <silent> <leader>ds <Plug>(GitGutterStageHunk)
nmap <silent> <leader>du <Plug>(GitGutterUndoHunk)



" Quickrun mappings
nmap <leader>em <Plug>(quickrun)
xmap <leader>er :QuickRun<CR>
nmap <leader>er <Plug>(quickrun-op)
nnoremap <silent> <leader>en <CMD>call myfunc#ExecuteStuff('right')<CR>
nnoremap <silent> <leader>eh <CMD>call myfunc#ExecuteStuff('bot')<CR>

nnoremap <silent> [os <CMD>call myfunc#Resize_Execution_Term(20)CR
nnoremap <silent> ]os <CMD>call myfunc#Resize_Execution_Term(-20)<CR>
nnoremap <silent> <leader>ic :<C-U>%s/\<<c-r><c-w>\>//gn<CR>g``
nnoremap <leader>rs :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>

" Source stuff
nnoremap <silent> <leader>R <CMD>so$MYVIMRC<CR>
nnoremap <silent> <leader>T <CMD>so %<CR>

source /home/brendan/.vim/sources/50-otherPrograms.vim
" Open stuff
nnoremap <silent> <leader>os <Cmd>UltiSnipsEdit<CR>
nnoremap <silent> <leader>or <Cmd>e $MYVIMRC<CR>
nnoremap <silent> <leader>oc <Cmd>Calendar -position=tab<CR>

source $HOME/.vim/sources/50-YankSettings.vim
" Yank Settings
nmap y <Plug>YAMotion
xmap y <Plug>YAVisual
nmap yy <Plug>YALine


nnoremap <silent> <c-x><c-s> <CMD>w!<CR>
nmap gf :edit <cfile><CR>
nmap <C-W><C-F> <CMD>vsplit <cfile><CR>

" Move in visual lines
nmap <expr> j (v:count? 'j' : 'gj')
nmap <expr> k (v:count? 'k' : 'gk')

" revisual after indent
xnoremap < <gv
xnoremap > >gv

" Dervish
let g:loaded_netrwPlugin = 1
let g:dirvish_dovish_map_keys = 0
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>


" Terminal stuff
map <C-w><C-t> <CMD>vert ter<CR>

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

" fine movement (Sneak Stuff)
let g:sneak#f_reset = 1
let g:sneak#t_reset = 1
let g:sneak#use_ic_scs = 1 " case sensitivity
let g:sneak#map_netrw = 1
let g:sneak#prompt = '>> '
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
source $HOME/.vim/sources/50-FuzzyFind.vim
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
nmap <leader>p'  <CMD>Tags<CR>
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
