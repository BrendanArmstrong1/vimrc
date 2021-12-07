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

    Plug 'sainnhe/sonokai'
    Plug 'itchyny/lightline.vim'

    Plug 'sheerun/vim-polyglot'
    Plug 'vim-syntastic/syntastic'

    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'rhysd/git-messenger.vim'

    Plug 'justinmk/vim-sneak'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'michaeljsmith/vim-indent-object'

    Plug 'skanehira/preview-markdown.vim'

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

nnoremap Q !!sh<CR>
nnoremap <space> <NOP>
set encoding=utf-8
set backspace=indent,eol,start
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

source /home/brendan/.vim/settings/bracketed-paste.vim
source /home/brendan/.vim/settings/Functions.vim

"set termguicolors
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_transparent_background = 1 "This has to appear before the colorscheme assignment
let g:sonokai_menu_selection_background = 'red'
colorscheme sonokai
let g:lightline = {'colorscheme' : 'sonokai'}
let g:preview_markdown_parser = 'mdcat'
let g:preview_markdown_auto_update = 1

let g:git_messenger_always_into_popup=v:true
let g:git_messenger_include_diff="current"
let g:git_messenger_floating_win_opts = { 'border': 'single' }
let g:git_messenger_popup_content_margins = v:false



set laststatus=2

highlight MyWhiteTrails ctermbg=red guibg=red
augroup standard_group
    autocmd!
    autocmd BufEnter * match MyWhiteTrails /\s\+$/
    autocmd InsertEnter * match MyWhiteTrails /\s\+\%#\@<!$/
    autocmd InsertLeave * match MyWhiteTrails /\s\+$/

    "Ensure files open the way that i want
    autocmd BufRead,BufNewFile *.tex set filetype=tex
    autocmd BufRead,BufNewFile *.json setfiletype json
    autocmd BufRead,BufNewFile *.json.* setfiletype json
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd BufNewFile,BufReadPost *.dockerfile set filetype=Dockerfile
    autocmd BufNewFile,BufReadPost *.jenkinsfile set filetype=groovy

    " Don't fold automatically https://stackoverflow.com/a/8316817
    autocmd BufRead * normal zR

    " Open Ggrep results in a quickfix window
    autocmd QuickFixCmdPost *grep* cwindow

    " Disable line numbers in :term
    " https://stackoverflow.com/a/63908546
    autocmd terminalopen * setlocal nonumber norelativenumber

    " Resize splits in all tabs upon window resize
    " https://vi.stackexchange.com/a/206
    autocmd VimResized * Tabdo wincmd =

    " Reload file on focus/enter. This seems to break in Windows.
    " https://stackoverflow.com/a/20418591
    if !has("win32")
        autocmd FocusGained,BufEnter * :silent! !
    endif
augroup END



let mapleader="\<space>"

"set lazyredraw " NoNoNo, Just No
"set noshowmode "This is for lightline disabling
set number relativenumber
set ruler
set showmatch
set cpoptions+=>
set noswapfile
set noerrorbells
set title
set splitbelow splitright
set updatetime=500
set hidden
let &titleold="Terminal"
set complete+=i,kspell
set signcolumn=number

"Line wrapping
set nowrap
set linebreak
set showbreak=+++
set textwidth=130

"Undo stuff
set undodir=~/.vim/undodir
set undofile
set undolevels=10000

"Tab stuff
set tabstop=4 expandtab softtabstop=4

"Shift stuff
set shiftwidth=4 shiftround

"Indentation
set autoindent smartindent smarttab
set incsearch ignorecase smartcase

"File Browsing
set path+=.,**
set path+="/usr/include"
set path+=$VIMRUNTIME
let g:netrw_banner=0 "Disable Banner
let g:netrw_browse_split=4 "open in prior window
let g:netrw_altv=1 " open splits to the right
let g:netrw_liststyle=3 " tree view
let g:netrw_winsize=12 " Window size
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
let g:NetrwIsOpen=0

" auto-completion
set omnifunc=syntaxcomplete#Complete
set thesaurus=~/.vim/thesaurus/english.txt

"Wild Menu
set wildmenu
set wildmode=longest,list,full
set complete-=i
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"==========================================================================
"|  _____                       __     __   _____ _           _
"| |  ___|   _ _________   _   / _|___/ _| |  ___(_)_ __   __| | ___ _ __
"| | |_ | | | |_  /_  / | | | | ||_  / |_  | |_  | | '_ \ / _` |/ _ \ '__|
"| |  _|| |_| |/ / / /| |_| | |  _/ /|  _| |  _| | | | | | (_| |  __/ |
"| |_|   \__,_/___/___|\__, | |_|/___|_|   |_|   |_|_| |_|\__,_|\___|_|
"|                     |___/
"==========================================================================

command! MakeTags !ctags -R . " Tag Jumping with ctags
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'
if has('win32') " Disable preview on Windows since it doesn't really work
  let g:fzf_preview_window = ''
else
  " Show file previews
  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
endif

let g:fzf_action = {
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

" - down / up / left / right
let g:fzf_layout = { 'down': '20%' }

" https://github.com/junegunn/fzf.vim/issues/162
let g:fzf_commands_expect = 'enter'

" Find files with fzf
nmap <leader>?   :Rg<CR>
nmap <leader>pf  :Files<CR>
nmap <leader>pg  :GFiles<CR>
nmap <leader>pl  :Lines<CR>
nmap <leader>pt  :Tags<CR>
nmap <leader>pL  :Locate ""<left>
nmap <leader>gm  :GitMessenger<CR>
" Copy the GitHub deeplink for the selected lines (requires Fugitive/Rhubarb)
vmap <leader>gb  :'<,'>GBrowse!<CR>
" Navigate to the GitHub deeplink for the selected lines (requires Fugitive/Rhubarb)
vmap <leader>gB  :'<,'>GBrowse<CR>
" Shows Git history for the current buffer
command! FileHistory execute ":BCommits"
"============================================================================
"============================================================================


"Auto Pair stuff
function! s:bracket_pairing(name) abort
    let l:line = getline('.')
    let l:len = l:line->len()
    let l:count = 0
    if a:name == "("
        let l:pair = ")"
    elseif a:name == "["
        let l:pair = "]"
    elseif a:name == "{"
        let l:pair = "}"
    elseif a:name == "\""
        let l:pair = "\""
    elseif a:name == "'"
        let l:pair = "'"
    endif
    for i in range(l:len)
        if a:name == "\""
            if l:line[i] == a:name && l:line[i-1] !~ '[\\]'
                if l:count
                    let l:count = 0
                else
                    let l:count += 1
                endif
            endif
        elseif a:name == "'"
            if l:line[col('.')-2] =~ '[A-Z]'
                return a:name
                echon l:line[col('.')-1]
            endif
            if l:line[i] == a:name && l:line[i-1] !~ '[A-Z\\]'
                if l:count
                    let l:count = 0
                else
                    let l:count += 1
                endif
            endif
        else
            if l:line[i] == a:name && l:line[i-1] != "\\"
                let l:count += 1
            elseif l:line[i] == l:pair && l:line[i-1] != "\\"
                let l:count -= 1
            endif
        endif
    endfor
    if l:count
        return a:name
    else
        return a:name . l:pair . "\<left>"
    endif
endfunction
inoremap <expr><silent> ( <SID>bracket_pairing("(")
inoremap <expr><silent> [ <SID>bracket_pairing("[")
inoremap <expr><silent> { <SID>bracket_pairing("{")
inoremap <expr><silent> " <SID>bracket_pairing("\"")
inoremap <expr><silent> ' <SID>bracket_pairing("'")


"Auto backspace after an autopair
function! s:bs_delete() abort
    let l:line = getline('.')
    let l:before = l:line[col(".")-2]
    let l:after = l:line[col(".")-1]
    if l:before == "("
        if l:after == ")"
            return "\<right>\<BS>\<BS>"
        endif
    elseif l:before == "["
        if l:after == "]"
            return "\<right>\<BS>\<BS>"
        endif
    elseif l:before == "{"
        if l:after == "}"
            return "\<right>\<BS>\<BS>"
        endif
    elseif l:before == "\""
        if l:after == "\""
            return "\<right>\<BS>\<BS>"
        endif
    elseif l:before == "'"
        if l:after == "'"
            return "\<right>\<BS>\<BS>"
        endif
    endif
    return "\<BS>"
endfunction
inoremap <expr><silent> <BS> <SID>bs_delete()


"======================================================
" ____                                  _
"|  _ \ ___ _ __ ___   __ _ _ __  _ __ (_)_ __   __ _
"| |_) / _ \ '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` |
"|  _ <  __/ | | | | | (_| | |_) | |_) | | | | | (_| |
"|_| \_\___|_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |
"                          |_|   |_|            |___/
"======================================================

"Highlighting groups for match macros
nnoremap <silent> <leader>o :setlocal spell! spelllang=en_us<CR>
nnoremap <silent> <leader>ic :%s/\<<c-r><c-w>\>//gn<CR>g``
nnoremap <silent> <leader>es :UltiSnipsEdit<CR>
nnoremap <silent> <leader>er :e $MYVIMRC<CR>
nnoremap <silent> <leader>n :call ToggleNetrw()<CR>
nnoremap <silent> <leader>b <CMD>call ExecuteScript('right')<CR>
nnoremap <silent> <leader>v <CMD>call ExecuteScript('bot')<CR>
nnoremap <silent> <leader>c <CMD>call CloseTerm()<CR>
nnoremap <silent> <leader>q <CMD>call Quitout()<CR>
nnoremap <silent> <leader>w <CMD>call SaveQuitout()<CR>
nnoremap <silent> <leader>ih <CMD>call Resize_Execution_Term(20)<CR>
nnoremap <silent> <leader>il <CMD>call Resize_Execution_Term(-20)<CR>
xnoremap < <gv
xnoremap > >gv
nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
nmap gf :edit <cfile><CR>
nmap <silent> [b :bprevious<CR>
nmap <silent> ]b :bnext<CR>
nmap <silent> ]B :bNext<CR>
imap <c-x><c-k> <c-x><c-k>
imap <c-x><c-l> <c-x><c-l>
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k

"========================================================================================
"====================  _   _ _ _   _      ____        _            ======================
"==================== | | | | | |_(_)    / ___| _ __ (_)_ __  ___  ======================
"==================== | | | | | __| |____\___ \| '_ \| | '_ \/ __| ======================
"==================== | |_| | | |_| |_____|__) | | | | | |_) \__ \ ======================
"====================  \___/|_|\__|_|    |____/|_| |_|_| .__/|___/ ======================
"====================                                |_|           ======================
"========================================================================================

        let g:UltiSnipsExpandTrigger="<C-y>"
        let g:UltiSnipsJumpForwardTrigger="<nop>"
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
            return "\<c-x>\<c-p>"
        endif
        endfunction

        function! Check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[:col - 1]  =~# "^\\s*$"
        endfunction
        inoremap <silent> <tab> <C-R>=(Ulti_ExpandOrJump_Res() > 0) ? "" : Tab_Completion()<CR>
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

"======================================================================================

