let g:calendar_cache_directory = expand('~/.vim/cache/calendar.vim/')
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

let g:highlightedyank_highlight_duration = 400
let g:yankassassin_use_mappings = 1
nmap y <Plug>YAMotion
xmap y <Plug>YAVisual
nmap yy <Plug>YALine

let g:vimwiki_use_calendar = 0
let g:vimwiki_list = [
        \ {'path': '~/.vim/vimwiki/',
            \ 'name': 'Main',
            \ 'auto_tags': 1,
            \ 'auto_generate_tags': 1,
            \ 'links_space_char': '_',
            \ 'auto_generate_links': 1},
        \ {'path': '~/.vim/vimwiki/Academia',
            \ 'name': 'Academia',
            \ 'path_html': '~/.vim/vimwiki/Academia/HTML',
            \ 'auto_tags': 1,
            \ 'auto_generate_tags': 1,
            \ 'links_space_char': '_',
            \ 'auto_generate_links': 1},
        \ {'path': '~/.vim/vimwiki/Social',
            \ 'name': 'Social',
            \ 'path_html': '~/.vim/vimwiki/Social/HTML',
            \ 'auto_tags': 1,
            \ 'auto_generate_tags': 1,
            \ 'links_space_char': '_',
            \ 'auto_generate_links': 1},
        \ {'path': '~/.vim/vimwiki/Spiritual',
            \ 'name': 'Spiritual',
            \ 'path_html': '~/.vim/vimwiki/Spiritual/HTML',
            \ 'auto_tags': 1,
            \ 'auto_generate_tags': 1,
            \ 'links_space_char': '_',
            \ 'auto_generate_links': 1},
        \ {'path': '~/.vim/vimwiki/Programming',
            \ 'name': 'Programming',
            \ 'path_html': '~/.vim/vimwiki/Programming/HTML',
            \ 'auto_tags': 1,
            \ 'auto_generate_tags': 1,
            \ 'links_space_char': '_',
            \ 'auto_generate_links': 1},
        \ {'path': '~/.vim/vimwiki/Programming/Python',
            \ 'name': 'Python',
            \ 'path_html': '~/.vim/vimwiki/Programming/Python/HTML',
            \ 'auto_tags': 1,
            \ 'auto_generate_tags': 1,
            \ 'links_space_char': '_',
            \ 'auto_generate_links': 1},
        \ {'path': '~/.vim/vimwiki/Programming/C',
            \ 'name': 'C',
            \ 'path_html': '~/.vim/vimwiki/Programming/C/HTML',
            \ 'auto_tags': 1,
            \ 'auto_generate_tags': 1,
            \ 'links_space_char': '_',
            \ 'auto_generate_links': 1},
        \ {'path': '~/.vim/vimwiki/Programming/WebCode',
            \ 'name': 'WebCode',
            \ 'path_html': '~/.vim/vimwiki/Programming/WebCode/HTML',
            \ 'auto_tags': 1,
            \ 'auto_generate_tags': 1,
            \ 'links_space_char': '_',
            \ 'auto_generate_links': 1},
        \ {'path': '~/.vim/vimwiki/Programming/ShellScript',
            \ 'name': 'ShellScript',
            \ 'path_html': '~/.vim/vimwiki/Programming/ShellScript/HTML',
            \ 'auto_tags': 1,
            \ 'auto_generate_tags': 1,
            \ 'links_space_char': '_',
            \ 'auto_generate_links': 1},
        \ {'path': '~/.vim/vimwiki/Linux',
            \ 'name': 'Linux',
            \ 'path_html': '~/.vim/vimwiki/Linux/HTML',
            \ 'auto_tags': 1,
            \ 'auto_generate_tags': 1,
            \ 'links_space_char': '_',
            \ 'auto_generate_links': 1}
        \ ]
