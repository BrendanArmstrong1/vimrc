let g:startify_session_persistence = 1
let g:startify_session_dir = '~/.vim/session'
let g:startify_update_oldfiles = 1
let g:startify_change_to_dir = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_padding_left = winwidth(0)/2 - 30
let g:ascii = [
            \ "  =================     ===============     ===============   ========  ========",
            \ "  \\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //",
            \ "  ||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||",
            \ "  || . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||",
            \ "  ||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||",
            \ "  || . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||",
            \ "  ||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
            \ "  || . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||",
            \ "  ||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
            \ "  ||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
            \ "  ||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
            \ "  ||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
            \ "  ||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
            \ "  ||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
            \ "  ||   .=='    _-'          '-__\\._-'         '-_./__-'         `' |. /|  |   ||",
            \ "  ||.=='    _-'                                                     `' |  /==.||",
            \ "  =='    _-'                            Vim                             \\/   `==",
            \ "  \\   _-'                                                                `-_   /",
            \ "   `''                                                                      ``"
            \ ]
let g:startify_custom_header = startify#pad(g:ascii)
let g:startify_lists = [
    \ { 'type': 'dir',       'header': startify#center(['MRU '.getcwd()]) },
    \ { 'type': 'sessions',  'header': startify#center(['Sessions']) },
    \ { 'type': 'files',     'header': startify#center(['MRU']) },
    \ { 'type': 'bookmarks', 'header': startify#center(['Bookmarks']) },
    \ { 'type': 'commands',  'header': startify#center(['Commands']) },
    \ ]
