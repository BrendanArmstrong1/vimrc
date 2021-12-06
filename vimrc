""============================
""       _                    
""__   _(_)_ __ ___  _ __ ___ 
""\ \ / / | '_ ` _ \| '__/ __|
"" \ V /| | | | | | | | | (__ 
""  \_/ |_|_| |_| |_|_|  \___|
""                            
""============================


"Initial shit and colors
set nocompatible
filetype plugin indent on
syntax enable

call plug#begin('~/.vim/plugged')
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'sainnhe/sonokai'
    Plug 'itchyny/lightline.vim'

    Plug 'sheerun/vim-polyglot'
    Plug 'vim-syntastic/syntastic'

    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'

    Plug 'michaeljsmith/vim-indent-object'
    Plug 'skanehira/preview-markdown.vim'

    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
call plug#end()

source /home/brendan/.vim/settings/bracketed-paste.vim

"set termguicolors
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_transparent_background = 1 "This has to appear before the colorscheme assignment
let g:sonokai_menu_selection_background = 'red'
colorscheme sonokai
let g:lightline = {'colorscheme' : 'sonokai'}
let g:preview_markdown_parser = 'mdcat'
let g:preview_markdown_auto_update = 1

let g:UltiSnipsExpandTrigger="<C-y>"
let g:UltiSnipsListSnippets="<c-m>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-v>"
let g:UltiSnipsEditSplit="vertical"


nnoremap Q !!sh<CR>
nnoremap <space> <NOP>
let mapleader="\<space>"
set encoding=utf-8
set backspace=indent,eol,start
set clipboard=unnamedplus


set viminfo=%,<800,'100,/50,:100,h,n~/.vim/settings/viminfo
"           | |    |    |   |    | + viminfo file path
"           | |    |    |   |    + disable 'hlsearch' loading viminfo
"           | |    |    |   + command-line history saved
"           | |    |    + search history saved
"           | |    + files marks saved
"           | + lines saved each register (old name for <, vi6.2)
"           + save/restore buffer list


"set lazyredraw " NoNoNo, Just No

"set noshowmode "This is for lightline disabling
set laststatus=2



set ruler
set showmatch
set cpoptions+=>
set noswapfile
set noerrorbells
set title
set splitbelow splitright
set number relativenumber
set updatetime=500
set hidden
let &titleold="Terminal"
set complete+=i,kspell

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
set tabstop=4
set expandtab
set softtabstop=4

"Shift stuff
set shiftwidth=4
set shiftround

"Indentation
set autoindent
set smartindent
set smarttab
set smartcase
set incsearch
set ignorecase

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

"Ensure files open the way that i want
autocmd BufRead,BufNewFile *.tex set filetype=tex

function! CloseTerm() abort
    w
    let i = bufnr("$")
    while (i >= 1)
        if (bufexists(i))
            if (getbufvar(i, "&buftype") == "terminal")
                silent exe "bwipeout! " . i
            endif
        endif
        let i-=1
    endwhile
    let g:markdown_preview = 0
endfunction

function! SaveQuitout() abort
    w
    execute "%bd!\|q!"
endfunction

function! Quitout() abort
    execute "%bd!\|q!"
endfunction

function! ExecuteScript(location) abort
    w
    let l:name=expand('%:p')
    let l:exte=expand('%:e')
    if l:exte == 'md'
        if g:markdown_preview == 1
            return
        else
            call SetMarkdown(a:location)
            if a:location == 'right'
                call feedkeys("\<C-w>h")
            else
                call feedkeys("\<C-w>k")
            endif
            return
        endif
    endif
    if !term_list()->len()
        if l:exte == 'tex' || l:exte == 'html' || l:exte == 'css'
            ter ++hidden
        else
            if a:location == 'right'
                vert ter
            else
                ter
            endif
            call feedkeys("\<C-w>h")
        endif
    endif
    call term_sendkeys(term_list()[0], "clear && compiler " . Quoterepl(l:name) . "\<CR>")
endfunction

let g:markdown_preview = 0
function! SetMarkdown(loc) abort
    let g:markdown_preview = 1
    if a:loc == 'right'
        PreviewMarkdown right
    else
        PreviewMarkdown bottom
    endif
endfunction

function! Quoterepl(name) abort
    let l:len=len(a:name)
    for i in range(l:len)
        if a:name[i] == "\'"
            return strpart(a:name,0,i) . "\\" . strpart(a:name, i,l:len)
        endif
    endfor
    return a:name
endfunction

function! Resize_Execution_Term(amount) abort
    if term_list()->len()
        let l:size=term_getsize(term_list()[0])
        call term_setsize(term_list()[0],l:size[0],l:size[1] + a:amount)
    endif
endfunction

function! ToggleNetrw() abort
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

function! Bracket_check() abort
    let l:aft = searchpos('[<>{}()\[\]`''"]','cnz',line('.'))
    call cursor(l:aft[0], l:aft[1]+1)
    startinsert
endfunction


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


" Tag Jumping
command! MakeTags !ctags -R .

" LaTeX stuff
autocmd FileType tex inoremap ,st \documentclass{article}<CR><CR><CR>\begin{document}<CR><CR><CR>\end{document}<Esc>kki
autocmd FileType tex inoremap ,tt <Esc>/\\begin{document}<CR>o\maketitle<Esc>ggo\title{}<Esc>T{i
autocmd FileType tex inoremap ,ta <Esc>ggo\author{}<Esc>T{i

" HTML scriptsj
autocmd FileType html inoremap ,tag <Esc>yiwdawi<space><<Esc>"0pa></<Esc>"0pa><Esc>T>i

" Making suckless stuff
autocmd BufWritePost ~/.config/dwmblocks/config.h !cd
      \ ~/.config/dwmblocks/;
      \ sudo make install &&
      \ { killall -q dwmblocks;setsid dwmblocks & }
autocmd BufWritePost ~/.config/st/config.h !cd ~/.config/st/; sudo make install
autocmd BufWritePost ~/.config/surf/config.h !cd ~/.config/surf/; sudo make install


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


"Highlighting groups for match macros
highlight MyWhiteTrails ctermbg=82
nnoremap <silent> <leader>o :setlocal spell! spelllang=en_us<CR>
nnoremap <silent> <leader>mw :match MyWhiteTrails /\s\+$/<CR>
nnoremap <silent> <leader>mn :match none<CR>
nnoremap <silent> <leader>ic "ayiw :%s/\<<c-r>a\>//gn<CR>
nnoremap <silent> <leader>es :UltiSnipsEdit<CR>
nnoremap <silent> <leader>er :e $MYVIMRC<CR>
map <leader>gb <C-^>

" Remap keys for gotos
nmap gf :edit <cfile><CR>
nmap <silent> [b :bprevious<CR>
nmap <silent> ]b :bnext<CR>
nmap <silent> ]B :bNext<CR>
nnoremap <silent> <leader>f :call ToggleNetrw()<CR>
nnoremap <silent> <leader>b <CMD>call ExecuteScript('right')<CR>
nnoremap <silent> <leader>v <CMD>call ExecuteScript('bot')<CR>
nnoremap <silent> <leader>c <CMD>call CloseTerm()<CR>
nnoremap <silent> <leader>q <CMD>call Quitout()<CR>
nnoremap <silent> <leader>w <CMD>call SaveQuitout()<CR>
nnoremap <silent> <leader>ih <CMD>call Resize_Execution_Term(20)<CR>
nnoremap <silent> <leader>il <CMD>call Resize_Execution_Term(-20)<CR>
vnoremap < <gv
vnoremap > >gv
imap <c-x><c-k> <c-x><c-k>
imap <c-x><c-l> <c-x><c-l>
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k

"              This is CoC menu selection stuff
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[:col - 1]  =~# "^\\s*$"
endfunction
inoremap <silent><expr> <tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ "\<c-x><c-p>"

nnoremap <Esc>[Z <CMD>call Bracket_check()<CR>
inoremap <silent><expr> <Esc>[Z <SID>shift_tab_fix()
snoremap <silent><expr> <Esc>[Z <SID>shift_tab_fix()
function! s:shift_tab_fix() abort
    if pumvisible()
        return "\<C-p>"
    else
        return "\<CMD>call Bracket_check()\<CR>"
    endif
endfunction

function! Bracket_check() abort
    let l:aft = searchpos('[<>{}()\[\]`''"]','cnz',line('.'))
    call cursor(l:aft[0], l:aft[1]+1)
    startinsert
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"



