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

    Plug 'easymotion/vim-easymotion'
    Plug 'haya14busa/incsearch.vim'
    Plug 'haya14busa/incsearch-fuzzy.vim'
    Plug 'haya14busa/incsearch-easymotion.vim'
    Plug 'haya14busa/vim-asterisk'

    Plug 'justinmk/vim-sneak'
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

source $HOME/.vim/cache/calendar.vim/credentials.vim
source $HOME/.vim/sources/50-bracketed-paste.vim
source $HOME/.vim/sources/50-Signify.vim
source $HOME/.vim/sources/50-pluginSettings.vim
source $HOME/.vim/sources/50-basic-settings.vim
source $HOME/.vim/sources/50-git.vim
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
nnoremap <silent> <leader>ih <CMD>call myfunc#Resize_Execution_Term(20)<CR>
nnoremap <silent> <leader>il <CMD>call myfunc#Resize_Execution_Term(-20)<CR>

nnoremap <silent> <leader>b <Cmd>call myfunc#ToggleNetrw()<CR>
nnoremap <silent> <c-x><c-s> <CMD>w!<CR>

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

" Inc search stuff
set hlsearch
let g:incsearch#consistent_n_direction = 1
let g:incsearch#auto_nohlsearch = 1
let g:incsearch#separate_highlight = 1
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyspell#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:asterisk#keeppos = 1
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

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_startofline = 0 " keep cursor colum JK motion
nmap <silent><expr> gs<Space> incsearch#go(<SID>config_easyfuzzymotion())
nmap gss <Plug>(easymotion-overwin-f2)
nmap gsb <Plug>(easymotion-overwin-line)
map gw <Plug>(easymotion-bd-wl)
map ge <Plug>(easymotion-bd-el)
map gsw <Plug>(easymotion-iskeyword-w)
map gsW <Plug>(easymotion-bd-W)
map gse <Plug>(easymotion-iskeyword-e)
map gsE <Plug>(easymotion-bd-E)
map gsn <Plug>(easymotion-bd-n)
map gst <Plug>(easymotion-bd-t)
map gsf <Plug>(easymotion-s)
map gsj <Plug>(easymotion-j)
map gsk <Plug>(easymotion-k)
map gsJ <Plug>(easymotion-sol-j)
map gsK <Plug>(easymotion-sol-k)
map gs. <Plug>(easymotion-repeat)
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap <Leader>s <Plug>(easymotion-sn)
xmap <Leader>s <Plug>(easymotion-sn)
omap <Leader>z <Plug>(easymotion-sn)




"=============================================================================
"====================  _   _ _ _   _      ____        _            ===========
"==================== | | | | | |_(_)    / ___| _ __ (_)_ __  ___  ===========
"==================== | | | | | __| |____\___ \| '_ \| | '_ \/ __| ===========
"==================== | |_| | | |_| |_____|__) | | | | | |_) \__ \ ===========
"====================  \___/|_|\__|_|    |____/|_| |_|_| .__/|___/ ===========
"====================                                |_|           ===========
"=============================================================================

        let g:UltiSnipsExpandTrigger="<C-y>"
        let g:UltiSnipsJumpForwardTrigger="<C-f>"
        let g:UltiSnipsJumpBackwardTrigger="<C-b>"
        let g:UltiSnipsEditSplit="vertical"
        let g:UltiSnipesRemoveSelectModeMappings = 0
        let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

        let g:ulti_expand_or_jump_res = 0
        function! Ulti_ExpandOrJump_Res() abort
            if pumvisible()
                return 0 "Sloppy Workaround for out of order operations
            endif
            call UltiSnips#ExpandSnippetOrJump()
            return g:ulti_expand_or_jump_res
        endfunction

        function! Tab_Completion() abort
        if pumvisible()
            return "\<c-n>"
        elseif Check_back_space()
            return "\<TAB>"
        else
            return "\<c-n>"
        endif
        endfunction

        function! Check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[:col - 1]  =~# "^\\s*$"
        endfunction
        inoremap <silent> <tab> <C-R>=(Ulti_ExpandOrJump_Res() > 0) ? "" :
            \ Tab_Completion()<CR>
        snoremap <silent> <tab> <Esc>:call UltiSnips#ExpandSnippetOrJump()<cr>
        xmap <tab> <C-y>




        function! s:shift_tab_fix() abort
            if pumvisible()
                return "\<C-p>"
            else
                return "\<CMD>call Bracket_check()\<CR>"
            endif
        endfunction

        function! Bracket_check() abort
            let l:aft = searchpos('[{}()\[\]`''"]','cnz',line('.'))
            call cursor(l:aft[0], l:aft[1]+1)
            startinsert
        endfunction


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

