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

    "Inc-Search stuff
    autocmd ColorScheme * highlight IncSearchMatch guibg=NONE guifg=#ff0000
    autocmd ColorScheme * highlight Search guibg=NONE guifg=#ff0000
    autocmd ColorScheme * highlight IncSearch guibg=NONE guifg=#ff0000
    autocmd ColorScheme * highlight IncSearchOnCursor guibg=NONE guifg=#ff3399
    autocmd ColorScheme * highlight IncSearchCursor guibg=#ffffff guifg=#000000
    "autocmd ColorScheme * highlight IncSearchMatchReverse guibg=#5200cc guifg=#d1b3ff

    " Sneak Highlighting
    autocmd ColorScheme * highlight Sneak guibg=NONE guifg=#ff0000
    autocmd ColorScheme * highlight SneakScope guibg=#bfbfbf guifg=#000000
    autocmd ColorScheme * highlight SneakLabel guibg=NONE guifg=#ff0000
    autocmd ColorScheme * highlight SneakLabelMask guibg=NONE guifg=#666666

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
colorscheme doom-one
let g:lightline = {'colorscheme' : 'one'}
highlight HighlightedyankRegion cterm=reverse gui=reverse
