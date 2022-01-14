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
    Plug 'sainnhe/sonokai'
    Plug 'itchyny/lightline.vim'
    Plug 'BourgeoisBear/clrzr'

    Plug 'machakann/vim-highlightedyank' "Guilty pleasure
    Plug 'svban/YankAssassin.vim'

    Plug 'sheerun/vim-polyglot'
    Plug 'vim-syntastic/syntastic'

    Plug 'vim-jp/vital.vim'

    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'rhysd/git-messenger.vim'
    Plug 'mhinz/vim-signify'

    Plug 'justinmk/vim-sneak'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'michaeljsmith/vim-indent-object'

    Plug 'jremmen/vim-ripgrep'
    Plug 'itchyny/calendar.vim'
    Plug 'vimwiki/vimwiki'

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

source /home/brendan/.vim/settings/basic-settings.vim
source /home/brendan/.vim/settings/bracketed-paste.vim
source /home/brendan/.vim/settings/Functions.vim
source /home/brendan/.vim/settings/vimwiki.vim

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

nnoremap <silent> <leader>o <Cmd>setlocal spell! spelllang=en_ca<CR>
nnoremap <silent> <leader>ec <Cmd>Calendar<CR>
nnoremap <silent> <leader>es <Cmd>UltiSnipsEdit<CR>
nnoremap <silent> <leader>er <Cmd>e $MYVIMRC<CR>
nnoremap <silent> <leader>en <CMD>call ExecuteScript('right')<CR>
nnoremap <silent> <leader>eh <CMD>call ExecuteScript('bot')<CR>
nnoremap <silent> <leader>b <Cmd>call ToggleNetrw()<CR>
nnoremap <silent> <leader>ct <CMD>call CloseTerm()<CR>
nnoremap <silent> <leader>qq <CMD>call Quitout()<CR>
nnoremap <silent> <leader>qw <CMD>call SaveQuitout()<CR>
nnoremap <silent> <leader>W <CMD>wq!<CR>
nnoremap <silent> <leader>ih <CMD>call Resize_Execution_Term(20)<CR>
nnoremap <silent> <leader>il <CMD>call Resize_Execution_Term(-20)<CR>
nnoremap <silent> <leader>sr <CMD>so$MYVIMRC<CR>
nnoremap <silent> <leader>gs <CMD>G<CR>
nnoremap <silent> <leader>ic :<C-U>%s/\<<c-r><c-w>\>//gn<CR>g``
nnoremap <leader>rs :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>

xnoremap < <gv
xnoremap > >gv

nmap gf :edit <cfile><CR>
nmap <C-W><C-F> :vsplit <cfile><CR>

nmap <silent> ]b <CMD>bnext<CR>
nmap <silent> [b <CMD>bprev<CR>
nmap <silent> ]B <CMD>blast<CR>
nmap <silent> [B <CMD>bfirst<CR>
nmap <silent> [g <plug>(signify-prev-hunk)
nmap <silent> [G 9999[g
nmap <silent> ]g <plug>(signify-next-hunk)
nmap <silent> ]G 9999]g
nmap <expr> j (v:count? 'j' : 'gj')
nmap <expr> k (v:count? 'k' : 'gk')
nmap <silent> <leader>cd <CMD>cd %:p:h<CR>

imap <c-x><c-k> <c-x><c-k>
imap <c-x><c-l> <c-x><c-l>
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T


set termguicolors
let &t_8f = "\e[38;2;%lu;%lu;%lum" "sets foreground color (ANSI, true-color mode)
let &t_8b = "\e[48;2;%lu;%lu;%lum" "sets background color (ANSI, true-color mode)
let g:clrzr_startup = 0

let g:rg_window_hieght = 25
let g:rg_derive_root = v:true

let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_transparent_background = 1 "before the colorscheme assignment
let g:sonokai_menu_selection_background = 'red'
let g:sonokai_better_performance = 1


let g:git_messenger_always_into_popup=v:true
let g:git_messenger_include_diff="current"
let g:git_messenger_floating_win_opts = { 'border': 'single' }
let g:git_messenger_popup_content_margins = v:true

let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_change_delete     = g:signify_sign_change .
    \ g:signify_sign_delete_first_line
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1


let g:highlightedyank_highlight_duration = 400
let g:yankassassin_use_mappings = 1
nmap y <Plug>YAMotion
xmap y <Plug>YAVisual
nmap yy <Plug>YALine






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



        nnoremap <Esc>[Z <CMD>call Bracket_check()<CR>
        inoremap <silent><expr> <Esc>[Z <SID>shift_tab_fix()

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

        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

"=============================================================================

highlight MyWhiteTrails ctermbg=red guibg=red
augroup standard_group
    autocmd!

    autocmd BufEnter * match MyWhiteTrails /\s\+$/
    autocmd InsertEnter * match MyWhiteTrails /\s\+\%#\@<!$/
    autocmd InsertLeave * match MyWhiteTrails /\s\+$/
    autocmd ColorScheme *  highlight SpellBad
        \ cterm=Underline ctermfg=red ctermbg=NONE
    autocmd ColorScheme *  highlight SpellCap
        \ cterm=Underline,italic ctermfg=Blue ctermbg=NONE
    autocmd ColorScheme *  highlight SpellLocal
        \ cterm=Underline ctermfg=Yellow ctermbg=NONE
    autocmd ColorScheme *  highlight SpellRare
        \ cterm=Underline ctermfg=Magenta ctermbg=NONE

    "Ensure files open the way that i want
    autocmd BufRead,BufNewFile *.tex set filetype=tex
    autocmd BufRead,BufNewFile *.json setfiletype json
    autocmd BufRead,BufNewFile *.json.* setfiletype json
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd BufNewFile,BufReadPost *.dockerfile set filetype=Dockerfile
    autocmd BufNewFile,BufReadPost *.jenkinsfile set filetype=groovy

    " Open Ggrep results in a quickfix window (Suggested by tpope)
    autocmd QuickFixCmdPost *grep* cwindow

    " Disable line numbers in :term
    " https://stackoverflow.com/a/63908546
    autocmd terminalopen * setlocal nonumber norelativenumber

    " Resize splits in all tabs upon window resize
    " https://vi.stackexchange.com/a/206
    autocmd VimResized * tabdo wincmd =

    " Reload file on focus/enter. This seems to break in Windows.
    " https://stackoverflow.com/a/20418591
    if !has("win32")
        autocmd FocusGained,BufEnter * :silent! !
    endif
augroup END
colorscheme sonokai
let g:lightline = {'colorscheme' : 'sonokai'}
highlight HighlightedyankRegion cterm=reverse gui=reverse
