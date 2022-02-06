"==========================================================================
"|  _____                       __     __   _____ _           _
"| |  ___|   _ _________   _   / _|___/ _| |  ___(_)_ __   __| | ___ _ __
"| | |_ | | | |_  /_  / | | | | ||_  / |_  | |_  | | '_ \ / _` |/ _ \ '__|
"| |  _|| |_| |/ / / /| |_| | |  _/ /|  _| |  _| | | | | | (_| |  __/ |
"| |_|   \__,_/___/___|\__, | |_|/___|_|   |_|   |_|_| |_|\__,_|\___|_|
"|                     |___/
"==========================================================================

let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_action = {
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

let $FZF_DEFAULT_COMMAND = "rg --files --no-ignore --hidden --follow --glob '!.git'
            \ --glob '!*.git*'"
let g:rg_derive_root='true'

if has('win32') " Disable preview on Windows since it doesn't really work
  let g:fzf_preview_window = []
else
    " Show file previews
    command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    function! RipgrepFzf(query, fullscreen)
        let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --glob "!.git/*" -- %s || true'
        let initial_command = printf(command_fmt, shellescape(a:query))
        let reload_command = printf(command_fmt, '{q}')
        let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
        call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
endif
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d
            \ %s %C(cyan)%C(bold)%cr"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'enter'
command! -bang ProjectFiles call fzf#vim#files('~/S', fzf#vim#with_preview(), <bang>0)

