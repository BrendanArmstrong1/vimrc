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
    Plug 'mhinz/vim-startify' " splash screen
    Plug 'justinmk/vim-dirvish'
    Plug 'roginfarrer/vim-dirvish-dovish'

    " Colours
    Plug 'sainnhe/sonokai'
    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'
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
    Plug 'rhysd/vim-lsp-ale'
    Plug 'dense-analysis/ale'

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
    Plug 'easymotion/vim-easymotion'

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
    Plug 'twitvim/twitvim'

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
"       - ale and vim-lsp with asyncomplete for autocompletion.
"       - ale for linting from the language server
" TODO Set up project management with vimwiki and taskwarrior
" TODO complete ripgrep todo finder
" DONE Clean up personal scripts section of the mappings.
" TODO Fix calendar and get it synced with google
" TODO get better terminal motions. Its hard to move around.
" DONE set up ctrlsf. Fix interaction with multicursor and inc search
" DONE FZF ripgrep needs to ignore .gitignore but also ignore .git
" DONE Searching movements with incsearch and sneak.
" DONE Change fzf window to a split of some sort
" DONE SWITCH TO COLMAK regular version

"======================================================
" ____                                  _
"|  _ \ ___ _ __ ___   __ _ _ __  _ __ (_)_ __   __ _
"| |_) / _ \ '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` |
"|  _ <  __/ | | | | | (_| | |_) | |_) | | | | | (_| |
"|_| \_\___|_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |
"                          |_|   |_|            |___/
"======================================================

nnoremap <C-z> <NOP>
nnoremap <space> <NOP>
let mapleader="\<space>"
nmap <leader>cd <CMD>cd %:p:h<CR>
nnoremap <silent> [os <CMD>call myfunc#Resize_Execution_Term(20)<CR>
nnoremap <silent> ]os <CMD>call myfunc#Resize_Execution_Term(-20)<CR>
nnoremap <silent> <leader>ic :<C-U>%s/\<<c-r><c-w>\>//gn<CR>g``
" source stuff
nnoremap <silent> <leader>R <CMD>so$MYVIMRC<CR>
nnoremap <silent> <leader>T <CMD>so %<CR>
source $HOME/.vim/sources/50-YankSettings.vim
" Yank Settings
nmap y <Plug>YAMotion
xmap y <Plug>YAVisual
nmap yy <Plug>YALine
" revisual after indent
xnoremap < <gv
xnoremap > >gv




" Completion and linting
set omnifunc=lsp#complete
let g:asyncomplete_auto_completeopt = 0
source /home/brendan/.vim/sources/50-Ultisnips.vim
" Ultisnips settings
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"


" hacky pop up close workaround
function s:myCompletionConfirm() abort
  let l:items = complete_info(['items', 'selected'])
  let l:selected = l:items['items'][l:items['selected']]
  if stridx(l:selected['menu'], "Snips:") == 0
      return "\<C-y>\<c-r>=UltiSnips#ExpandSnippet()\<CR>"
  else
      return "\<C-y>"
  endif
endfunction
inoremap <expr> <CR> <c-r>=asyncomplete#cancel_popup()<CR><CR>
inoremap <expr> <C-y> pumvisible() ? <SID>myCompletionConfirm()  : "\<C-y>"
" inoremap <expr> <C-e> pumvisible() ? asyncomplete#cancel_popup() : "\<C-e>"

" Prefix CTRL
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
tnoremap <c-l> <c-w><C-l>
tnoremap <c-h> <c-w><C-h>
" remapping hack to fix FZF popup selection and terminal window switching
tmap <expr><c-j> len(popup_list()) ? "\<C-n>" : "\<C-w>\<C-j>"
tmap <expr><c-k> len(popup_list()) ? "\<C-p>" : "\<C-w>\<C-k>"
tmap <c-z> <c-\><c-n>
imap <expr> <c-j> pumvisible() ? "\<down>" : "\<c-j>"
imap <expr> <c-k> pumvisible() ? "\<up>" : "\<c-k>"

nnoremap <silent> <c-z><c-s> <CMD>w!<CR>
nmap <C-W><C-F> <CMD>vsplit <cfile><CR>
" Terminal stuff
map <C-w><C-t> <CMD>vert ter<CR>

" scroll stuff
let g:smoothie_no_default_mappings = 1
nmap <C-f>      <Plug>(SmoothieForwards)
nmap <C-b>      <Plug>(SmoothieBackwards)
nmap <C-D>      <Plug>(SmoothieDownwards)
nmap <C-U>      <Plug>(SmoothieUpwards)
noremap <expr> <C-e> repeat("\<C-e>", 5)
noremap <expr> <C-y> repeat("\<C-y>", 5)

" Multi cursor mappings
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-s>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-s>'           " replace visual C-n
let g:VM_show_warnings = 0

" Prifix r
let g:ctrlsf_backend = 'rg'
let g:ctrlsf_extra_backend_args = {
    \ 'rg': '--no-ignore --glob "!.git"'
    \ }
let g:ctrlsf_position = 'left_local'
xmap <leader>r <Plug>CtrlSFVwordExec
nmap <leader>rr <Plug>CtrlSFPrompt
nmap <leader>rs <Plug>CtrlSFCwordExec
nmap <leader>rS <Plug>CtrlSFCwordPath
nmap <leader>rb <Plug>CtrlSFCCwordExec
nmap <leader>rB <Plug>CtrlSFCCwordPath
nmap <leader>r/ <Plug>CtrlSFPwordExec
nmap <leader>r? <Plug>CtrlSFPwordPath
nmap <leader>ru <CMD>CtrlSFUpdate<CR>
nmap <leader>ro <CMD>CtrlSFToggle<CR>
nmap <leader>rh <CMD>CtrlSFClearHL<CR>
let g:ctrlsf_mapping = { "vsplit": "<C-v>", }
let g:ctrlsf_auto_focus = { "at" : "start", }


" Prifix t



" Prefix q
source $HOME/.vim/sources/50-Signify.vim
nnoremap <silent> <leader>qq <CMD>call myfunc#Quitout()<CR>
nnoremap <silent> <leader>qw <CMD>call myfunc#SaveQuitout()<CR>
nnoremap <silent> <leader>qf <CMD>Startify<CR>
nnoremap <silent> <leader>qt <CMD>call Terminal#CloseTerm()<CR>

nnoremap Q !!sh<CR>

nmap <silent> ]d <CMD>ALENext<CR> 
nmap <silent> [d <CMD>ALEPrevious<CR> 
" Prefix g
source $HOME/.vim/sources/50-git.vim
" Git Mapping
nnoremap <silent> <leader>gg <CMD>G<CR>
nmap <leader>gP <CMD>Git push<CR>
nmap <silent> [g <Plug>(GitGutterPrevHunk)
nmap <silent> ]g <Plug>(GitGutterNextHunk)
nmap <silent> <leader>gs <Plug>(GitGutterStageHunk)
nmap <silent> <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gm  <CMD>GitMessenger<CR>
vmap <leader>gb  <CMD>'<,'>GBrowse!<CR>
vmap <leader>gB  <CMD>'<,'>GBrowse<CR>
nmap gf :edit <cfile><CR>
nmap gp `[v`]
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys = 'neioluy''mtsrapfwqgj'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
map gs <Plug>(easymotion-bd-f2)
map gj <Plug>(easymotion-j)
map gk <Plug>(easymotion-k)
map gn <Plug>(easymotion-bd-n)
map gw <Plug>(easymotion-lineanywhere)
let g:EasyMotion_re_line_anywhere = '\v' .
    \       '(<.|^)' . '|' .
    \       '(>.|.$)' . '|' .
    \       '(\l)\zs(\u)' . '|' .
    \       '(_\zs.)' . '|' .
    \       '(#\zs.)'

" Prefix e
" Quickrun mappings
nmap <leader>em <Plug>(quickrun)
xmap <leader>er :QuickRun<CR>
nmap <leader>er <Plug>(quickrun-op)
nnoremap <silent> <leader>en <CMD>call myfunc#ExecuteStuff('right')<CR>
nnoremap <silent> <leader>eh <CMD>call myfunc#ExecuteStuff('bot')<CR>


" Prefix o
source /home/brendan/.vim/sources/50-otherPrograms.vim
source /home/brendan/.vim/sources/50-Async.vim
" Open stuff
nnoremap <silent> <leader>on <Cmd>UltiSnipsEdit<CR>
nnoremap <silent> <leader>or <Cmd>e $MYVIMRC<CR>
nnoremap <silent> <leader>oc <Cmd>Calendar -position=tab<CR>
" Toggling stuff
nnoremap <silent> <leader>os <Cmd>call myAsyncFuncs#ToggleSpell()<CR>
nnoremap <silent> <leader>oa <Cmd>call myAsyncFuncs#ToggleTabnine()<CR>
nnoremap <silent> <leader>ou <Cmd>call myAsyncFuncs#ToggleUltisnips()<CR>
nnoremap <silent> <leader>oL <Cmd>ALEToggle<CR>
nnoremap <silent> <leader>ol <Cmd>call myAsyncLsp#ToggleLsp()<CR>

source /home/brendan/.vim/sources/50-TwitVim.vim
" Prefix t (TwitVim mappings)
nmap <leader>tf <CMD>FriendsTwitter<CR>
nmap <leader>tt <CMD>TrendTwitter<CR>
nmap <leader>ta :<C-U>FollowTwitter<Space>@<c-r><c-w><CR>
nmap <leader>tA :<C-U>UnfollowTwitter<Space>@<c-r><c-w><CR>
nmap <leader>te :<C-u>EnableRetweetsTwitter<Space>@<c-r><c-w><CR>
nmap <leader>tE :<C-u>DisableRetweetsTwitter<Space>@<c-r><c-w><CR>
nmap <leader>tu <CMD>UserTwitter<CR>
nmap <leader>tm <CMD>MentionsTwitter<CR>
nmap <leader>td <CMD>DMTwitter<CR>
nmap <leader>tD <CMD>DMSentTwitter<CR>
nmap <leader>tr <CMD>RetweetedToMeTwitter<CR>
nmap <leader>tR <CMD>RetweetedByMeTwitter<CR>
nmap <leader>tv <CMD>FavTwitter<CR>
nmap <leader>tb :<C-U>BlockTwitter<Space>@<c-r><c-w>
nmap <leader>tB :<C-U>UnblockTwitter<Space>@
nmap <leader>tq :<C-U>MuteTwitter<Space>@<c-r><c-w>
nmap <leader>tQ :<C-U>UnmuteTwitter<Space>@
nmap <leader>tU :<C-u>UserTwitter<Space>@<C-r><C-w>
nmap <leader>tll :<C-u>ListTwitter<Space>
nmap <leader>tla :<C-u>AddToListTwitter<Space>
nmap <leader>tlA :<C-u>RemoveFromListTwitter<Space>
nmap <leader>tlL :<C-u>ListInfoTwitter<Space>
nmap <leader>tlf :<C-u>FollowListTwitter<Space>
nmap <leader>tlF :<C-u>UnfollowListTwitter<Space>
nmap <leader>tlm :<C-u>MembersOfListTwitter<Space>
nmap <leader>tlM :<C-u>MemberListTwitter<Space>
nmap <leader>tls :<C-u>SubsOfListTwitter<Space>
nmap <leader>tlS :<C-u>SubsListTwitter<Space>
nmap <leader>tlo :<C-u>OwnedListTwitter<Space>
" Prefix ti (twitter info)
nmap <leader>tif <CMD>FollowingTwitter<CR>
nmap <leader>tiF <CMD>FollowersTwitter<CR>
nmap <leader>tio <CMD>OwnedListsTwitter<CR>
" Prefix tp (Twitter Posting)
nmap <leader>tpp <CMD>PosttoTwitter<CR>
nmap <leader>tpl <CMD>CPosttoTwitter<CR>
nmap <leader>tpb <CMD>BPosttoTwitter<CR>
nmap <leader>tpd <CMD>SendDMTwitter<CR>


" Dervish
let g:loaded_netrwPlugin = 1
let g:dirvish_dovish_map_keys = 0
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

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

" Solving surround remap with Zurround pnemonic. 'Z' works better for colmak
" https://github.com/justinmk/vim-sneak/issues/268
let g:surround_no_mappings= 1
xmap z <Plug>VSurround
nmap yzz <Plug>Yssurround
nmap yz  <Plug>Ysurround
nmap dz  <Plug>Dsurround
nmap cz  <Plug>Csurround

" Fuzzy Finder Stuff
source $HOME/.vim/sources/50-FuzzyFind.vim
" Project Prefix p
nmap <leader>pc  <CMD>BCommits<CR>
nmap <leader>p/  <CMD>RG<CR>
nmap <leader>?   <CMD>RgWord<CR>
xmap <leader>?   <CMD>RgWordVis<CR>
nmap <leader>p?  :RG <c-r><c-w><CR>
xmap <leader>p?  "vy:<c-u>RG <c-r>v<CR>
nmap <leader>pf  <CMD>Files<CR>
nmap <leader>pp  <CMD>GFiles<CR>
nmap <leader>pg  <CMD>GFiles?<CR>
nmap <leader>pl  <CMD>Lines<CR>
nmap <leader>p'  <CMD>Tags<CR>
nmap <leader>pt  <CMD>RgTODO<CR>
" Files Prefix f
nmap <leader>fL  :Locate ""<left>
nmap <leader>fb  <CMD>Buffers<CR>
nmap <leader>ff  <CMD>ProjectFiles<CR>
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


let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"
