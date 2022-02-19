set termguicolors
let &t_8f = "\e[38;2;%lu;%lu;%lum" "sets foreground color (ANSI, true-color mode)
let &t_8b = "\e[48;2;%lu;%lu;%lum" "sets background color (ANSI, true-color mode)
highlight MyWhiteTrails ctermbg=red guibg=red
augroup standard_group
    autocmd!

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
    autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight LineNr guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight SignColumn guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight EndOfBuffer guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight Todo guibg=NONE guifg=#33cc33
    autocmd ColorScheme * highlight Terminal guibg=NONE ctermbg=NONE
    autocmd ColorScheme * highlight Comment guifg=#5C6370 ctermfg=59

    "Inc-Search stuff
    autocmd ColorScheme * highlight Search guibg=#3d3d5c guifg=#c2c2d6

    " Sneak Highlighting
    autocmd ColorScheme * highlight Sneak guibg=#800033 guifg=#ff80b3
    autocmd ColorScheme * highlight SneakScope guibg=#3d3d5c guifg=#c2c2d6
    autocmd ColorScheme * highlight SneakLabel guibg=#800033 guifg=#ff80b3
    autocmd ColorScheme * highlight SneakLabelMask guibg=#800033 guifg=#ff80b3

    "Ensure files open the way that i want
    autocmd BufRead,BufNewFile *.tex set filetype=tex
    autocmd BufRead,BufNewFile *.json setfiletype json
    autocmd BufRead,BufNewFile *.json.* setfiletype json
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd BufNewFile,BufReadPost *.dockerfile set filetype=Dockerfile
    autocmd BufNewFile,BufReadPost *.jenkinsfile set filetype=groovy

    " Open Ggrep results in a quickfix window (Suggested by tpope)
    autocmd QuickFixCmdPost *grep* cwindow

    "https://github.com/junegunn/fzf.vim/issues/503
    autocmd TerminalWinOpen * setlocal nonumber norelativenumber

    " Resize splits in all tabs upon window resize
    " https://vi.stackexchange.com/a/206
    autocmd VimResized * tabdo wincmd =

    " Reload file on focus/enter. This seems to break in Windows.
    " https://stackoverflow.com/a/20418591
    if !has("win32")
        autocmd FocusGained,BufEnter * :silent! !
    endif
augroup END
let g:sonokai_enable_italic = 1
let g:sonokai_transparent_background = 1
let g:sonokai_disable_italic_comment = 1
colorscheme sonokai
" itchyny/lightline.vim --- {{{
let g:lightline#bufferline#modified = ' ✎'
let g:lightline = {
      \ 'colorscheme': 'sonokai',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'gitbranch', 'relativepath', 'cocstatus' ] ],
      \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ], ['lineinfo'],
      \              ['filetype'] ]
      \ },
      \
      \ 'inactive': {
      \   'left': [ [ 'filename' ] ],
      \   'right': [ [ 'lineinfo' ]]
      \ },
      \
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \
      \ 'component': {
      \   'lineinfo': '%3l/%L'
      \},
      \
      \ 'component_expand': {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \
      \  'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \  'linter_checking': 'right',
      \  'linter_infos': 'right',
      \  'linter_warnings': 'warning',
      \  'linter_errors': 'error',
      \  'linter_ok': 'success'
      \ }
      \ }
" }}}

highlight HighlightedyankRegion cterm=reverse gui=reverse
