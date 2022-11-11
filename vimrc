let g:loaded_matchit = 1
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
    Plug 'mhinz/vim-startify' " splash screen
    Plug 'justinmk/vim-dirvish'
    Plug 'roginfarrer/vim-dirvish-dovish'
    Plug 'stsewd/fzf-checkout.vim'

    " Colours
    Plug 'sainnhe/sonokai'
    Plug 'itchyny/lightline.vim'
    Plug 'maximbaz/lightline-ale'
    Plug 'machakann/vim-highlightedyank'

    " Vim heuristics (more functionality)
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-repeat'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'andymass/vim-matchup'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-scriptease'
    Plug 'AndrewRadev/splitjoin.vim'

    " Auto Completion and linting
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
    Plug 'rhysd/vim-lsp-ale'
    Plug 'dense-analysis/ale'

    "Git stuff
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'rhysd/git-messenger.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/gv.vim'

    " Vim in-frame navigation
    Plug 'haya14busa/vim-asterisk'
    Plug 'haya14busa/is.vim'
    Plug 'justinmk/vim-sneak'

    " Broad file simultaneous edit
    Plug 'dyng/ctrlsf.vim'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}

    " typist help
    Plug 'tpope/vim-endwise'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-rsi'
    Plug 'SirVer/ultisnips'

    " Org mode in vim
    Plug 'superevilmegaco/Screenshot.nvim'
    Plug 'jmckiern/vim-shoot', { 'do': '\"./install.py\" chromedriver' }

call plug#end()

filetype plugin indent on
syntax enable

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    q
endif


source $HOME/.vim/sources/50-bracketed-paste.vim
source $HOME/.vim/sources/50-basicSettings.vim
source $HOME/.vim/sources/50-completionSettings.vim
source $HOME/.vim/sources/50-autostuff.vim


let g:lsp_document_code_action_signs_enabled = 0
let g:ale_linters = {
            \ 'python': [ 'flake8', 'pylint --disable=C', 'pyright' ],
            \ 'rust': ['rust-analyzer', 'cargo'],
            \ }
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'python': ['black'],
      \ 'rust' : ['rustfmt'],
      \ 'go' : ['gofmt'],
      \}
let lsp_ale_diagnostics_severity = "warning"
let g:lsp_settings_enable_suggestions = 0
let g:ale_floating_preview = 1
let g:ale_hover_to_floating_preview = 1

let g:vimwiki_auto_chdir = 1
let g:vimwiki_list = [
        \ {'path': '~/.vim/vimwiki/',
            \ 'name': 'Main',
            \ 'index': 'Index',
            \ 'syntax': 'markdown',
            \ 'ext': '.md',
            \ 'auto_tags': 1,
            \ 'auto_generate_tags': 1,
            \ 'links_space_char': '_',
            \ 'auto_generate_links': 1}
        \ ]



let g:highlightedyank_highlight_duration = 400
let g:asyncomplete_auto_popup = 1
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
" Yank Settings
nmap Y y$

xnoremap < <gv
xnoremap > >gv

" Completion and linting
source /home/brendan/.vim/sources/50-Ultisnips.vim
" Ultisnips settings
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"


" hacky pop up close workaround
function s:myCompletionConfirm() abort
    if pumvisible()
        let l:items = complete_info(['items', 'selected'])
        let l:selected = l:items['items'][l:items['selected']]
        if stridx(l:selected['menu'], "Snips:") == 0
            return "\<C-y>\<c-r>=UltiSnips#ExpandSnippet()\<CR>"
        else
            return "\<C-y>"
        endif
    else
        if UltiSnips#CanExpandSnippet()
            return "\<c-r>=UltiSnips#ExpandSnippet()\<CR>"
        else
            return "\<C-y>"
        endif
    endif
endfunction
inoremap <expr> <C-y> <SID>myCompletionConfirm()
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
imap <c-n> <Plug>(asyncomplete_force_refresh)

nnoremap <silent> <c-z><c-s> <CMD>w!<CR>
nnoremap <silent> <c-w><c-q> ZQ
nnoremap <silent> <c-w><c-w> ZZ
nmap <C-W><C-F> <CMD>vsplit <cfile><CR>
" Terminal stuff
map <C-w><C-t> <CMD>vert ter ++kill=hup<CR>

" scroll stuff
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
" search for word under cursor with 'c'
nmap <leader>rc <Plug>CtrlSFCwordExec
nmap <leader>rC <Plug>CtrlSFCwordPath
" add word boundaries to search with 'b'
nmap <leader>rb <Plug>CtrlSFCCwordExec
nmap <leader>rB <Plug>CtrlSFCCwordPath
" search for last search '/' term
nmap <leader>r/ <Plug>CtrlSFPwordExec
nmap <leader>r? <Plug>CtrlSFPwordPath
" update, toggle open, clear hl
nmap <leader>ru <CMD>CtrlSFUpdate<CR>
nmap <leader>ro <CMD>CtrlSFToggle<CR>
nmap <leader>rh <CMD>CtrlSFClearHL<CR>
let g:ctrlsf_mapping = { "vsplit": "<C-v>", }
let g:ctrlsf_auto_focus = { "at" : "start", }

" Prefix q
source $HOME/.vim/sources/50-Signify.vim
nnoremap <silent> <leader>qq <CMD>call myfunc#Quitout()<CR>
nnoremap <silent> <leader>qw <CMD>call myfunc#SaveQuitout()<CR>
nnoremap <silent> <leader>qf <CMD>Startify<CR>
nnoremap <silent> <leader>qt <CMD>call Terminal#CloseTerm()<CR>

nnoremap Q !!sh<CR>

" Prefix g
source $HOME/.vim/sources/50-git.vim
" Git Mapping
nnoremap <silent> <leader>gg <CMD>Git<CR>
nnoremap <silent> <leader>gl <CMD>Git log<CR>
nnoremap <silent> <leader>gb <CMD>Git blame<CR>
nnoremap <silent> <leader>gd <CMD>Gdiffsplit<CR>
nnoremap <silent> <leader>gD <CMD>Gdiffsplit!<CR>
nnoremap <leader>gP <CMD>Git push<CR>
nmap <silent> <leader>gv <CMD>GV<CR>
nmap <silent> <leader>gV <CMD>GV!<CR>
nmap <silent> <leader>go <CMD>diffget //3<CR>
nmap <silent> <leader>ga <CMD>diffget //2<CR>
nmap <silent> <leader>gs <Plug>(GitGutterStageHunk)
nmap <silent> <leader>gu <Plug>(GitGutterUndoHunk)
nmap <leader>gr  <CMD>GBrowse<CR>
vmap <leader>gr  :GBrowse<CR>
vmap <leader>gR  :GBrowse!<CR>
nmap gf :edit <cfile><CR>
nmap gp `[v`]

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-peek-definition)
    nmap <buffer> gD <plug>(lsp-definition)
    nmap <buffer> ge <CMD>ALEDetail<CR>
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gC <plug>(lsp-code-action)
    vmap <buffer> gC :LspCodeAction<CR>
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gI <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-peek-type-definition)
    nmap <buffer> gT <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> <leader>F <plug>(lsp-document-format)
    vmap <buffer> <leader>F <plug>(lsp-document-format)
    nmap <buffer> ]> <plug>(lsp-next-diagnostic-nowrap)
    nmap <buffer> [> <plug>(lsp-previous-diagnostic-nowrap)
    nmap <buffer> K  <plug>(lsp-hover)
    nmap <buffer> gk  <plug>(lsp-hover-float)
    nmap <buffer> gK  <plug>(lsp-hover-preview)
    nmap <buffer> <c-k> <plug>(lsp-signature-help)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-b> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    " autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

nnoremap <silent> <bar>= z=
nmap <unique><silent> ]* ]s
nmap <unique><silent> [* [s
nmap <silent> [& <Plug>(GitGutterPrevHunk)
nmap <silent> ]& <Plug>(GitGutterNextHunk)
nmap <silent> [` <CMD>cprevious<CR>
nmap <silent> ]` <CMD>cnext<CR>
nmap <silent> [\ <CMD>bprevious<CR>
nmap <silent> ]\ <CMD>bnext<CR>
nmap <silent> [_ <CMD>previous<CR>
nmap <silent> ]_ <CMD>next<CR>

nmap <silent> } }zz
nmap <silent> { {zz


" Prefix e
nnoremap <silent> <leader>en <CMD>call myfunc#ExecuteStuff('right')<CR>
nnoremap <silent> <leader>eh <CMD>call myfunc#ExecuteStuff('bot')<CR>


" Prefix o
" Open stuff
function ToggleAuto() abort
    if g:asyncomplete_auto_popup
        echo "Lsp Off"
        let g:asyncomplete_auto_popup = 0
    else
        echo "Lsp On"
        let g:asyncomplete_auto_popup = 1
    endif
endfunction

nnoremap <silent> <leader>ol <Cmd>call ToggleAuto()<CR>
nnoremap <silent> <leader>on <Cmd>UltiSnipsEdit<CR>
nnoremap <silent> <leader>or <Cmd>e $MYVIMRC<CR>
" Toggling stuff
nnoremap <silent> <leader>oL <Cmd>ALEToggle<CR>


" Dervish
source /home/brendan/.vim/sources/50-Dirvish.vim
" unmap all default mappings
let g:dirvish_dovish_map_keys = 0

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
map t <Plug>Sneak_t
map T <Plug>Sneak_T
map f <Plug>Sneak_f
map F <Plug>Sneak_F

" Solving surround remap with Zurround pnemonic. 'Z' works better for colmak
" https://github.com/justinmk/vim-sneak/issues/268
let g:surround_no_mappings= 1
xmap Z <Plug>VSurround
nmap yzz <Plug>Yssurround
nmap yz  <Plug>Ysurround
nmap dz  <Plug>Dsurround
nmap cz  <Plug>Csurround

" Fuzzy Finder Stuff
source $HOME/.vim/sources/50-FuzzyFind.vim
" Project Prefix p
nmap <leader>pc  <CMD>BCommits<CR>
nmap <leader>/   <CMD>RG<CR>
nmap <leader>?   <CMD>RgWord<CR>
xmap <leader>?   <CMD>RgWordVis<CR>
nmap <leader>p/  :RG <c-r><c-w><CR>
xmap <leader>p/  "vy:<c-u>RG <c-r>v<CR>
nmap <leader>pF  <CMD>Files<CR>
nmap <leader>pf  <CMD>GFiles<CR>
nmap <leader>pg  <CMD>GFiles?<CR>
nmap <leader>pb  <CMD>GBranches<CR>
nmap <leader>pT  <CMD>GTags<CR>
nmap <leader>pl  <CMD>Lines<CR>
nmap <leader>p'  <CMD>Tags<CR>
nmap <leader>pt  <CMD>RgTODO<CR>
" Files Prefix f
nmap <leader>fL  :Locate ""<left>
nmap <leader>fb  <CMD>Buffers<CR>
nmap <leader>fd  <CMD>BD<CR>
nmap <leader>ff  <CMD>ProjectFiles<CR>


let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"
