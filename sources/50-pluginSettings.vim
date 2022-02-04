let g:calendar_cache_directory = expand('~/.vim/cache/calendar.vim/')
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

let g:highlightedyank_highlight_duration = 400
let g:yankassassin_use_mappings = 1
nmap y <Plug>YAMotion
xmap y <Plug>YAVisual
nmap yy <Plug>YALine
