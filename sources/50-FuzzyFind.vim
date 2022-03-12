"==========================================================================
"|  _____                       __     __   _____ _           _
"| |  ___|   _ _________   _   / _|___/ _| |  ___(_)_ __   __| | ___ _ __
"| | |_ | | | |_  /_  / | | | | ||_  / |_  | |_  | | '_ \ / _` |/ _ \ '__|
"| |  _|| |_| |/ / / /| |_| | |  _/ /|  _| |  _| | | | | | (_| |  __/ |
"| |_|   \__,_/___/___|\__, | |_|/___|_|   |_|   |_|_| |_|\__,_|\___|_|
"|                     |___/
"==========================================================================
let $FZF_DEFAULT_COMMAND = "rg --files --no-ignore --hidden --follow --glob '!.git'"
let $FZF_DEFAULT_OPTS = "--layout=reverse --inline-info -m"
let g:todo_list_items = 'TODO\|DONE\|WAIT'

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)

let g:rg_derive_root='true'

if has('win32') " Disable preview on Windows since it doesn't really work
  let g:fzf_preview_window = []
else
    function! RipgrepTODO(query, fullscreen)
        let command_fmt = 'rg --column --no-ignore --line-number --no-heading --color=always --smart-case --glob "!tags" --glob "!.git/*"'
        let initial_command = command_fmt . ' ' . g:todo_list_items
        let spec = {'options': ['--query', a:query]}
        call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RgTODO call RipgrepTODO(<q-args>, <bang>0)

    function! s:get_visual_selection()
        if mode()=="v"
            let [line_start, column_start] = getpos("v")[1:2]
            let [line_end, column_end] = getpos(".")[1:2]
        else
            let [line_start, column_start] = getpos("'<")[1:2]
            let [line_end, column_end] = getpos("'>")[1:2]
        end
        if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
            let [line_start, column_start, line_end, column_end] =
            \   [line_end, column_end, line_start, column_start]
        end
        let lines = getline(line_start, line_end)
        if len(lines) == 0
                return ''
        endif
        let lines[-1] = lines[-1][: column_end - 1]
        let lines[0] = lines[0][column_start - 1:]
        return join(lines, "\n")
    endfunction

    function! RipgrepWordVis(query, fullscreen)
        let command_fmt = 'rg --column --no-ignore --line-number --no-heading --color=always --smart-case --glob "!tags" --glob "!.git/*"'
        let initial_command = command_fmt . ' ' . s:get_visual_selection()
        let spec = {'options': ['--query', a:query]}
        call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RgWordVis call RipgrepWordVis(<q-args>, <bang>0)

    function! RipgrepWord(query, fullscreen)
        let command_fmt = 'rg --column --no-ignore --line-number --no-heading --color=always --smart-case --glob "!tags" --glob "!.git/*"'
        let initial_command = command_fmt . ' ' . expand("<cword>")
        let spec = {'options': ['--query', a:query]}
        call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RgWord call RipgrepWord(<q-args>, <bang>0)

    function! RipgrepFzf(query, fullscreen)
        let command_fmt = 'rg --column --no-ignore --line-number
                    \ --no-heading --color=always --smart-case --glob "!tags"
                    \ --glob "!.git/*" -- %s || true'
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

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_checkout_use_current_buf_cwd = v:true
let g:fzf_checkout_merge_settings= v:false
let g:fzf_checkout_git_options = '--sort=-committerdate'
let g:fzf_branch_actions = {
      \ 'diff': {
           \   'prompt': 'Diff> ',
           \   'execute': 'Git diff {branch}',
           \   'multiple': v:false,
           \   'keymap': 'ctrl-f',
           \   'required': ['branch'],
           \   'confirm': v:false,
           \ },
        \ 'checkout': {
            \   'prompt': 'Checkout> ',
            \   'execute': 'echo system("{git} -C {cwd} checkout {branch}")',
            \   'multiple': v:false,
            \   'keymap': 'enter',
            \   'required': ['branch'],
            \   'confirm': v:false,
            \ },
        \ 'track': {
        \   'prompt': 'Track> ',
        \   'execute': 'echo system("{git} -C {cwd} checkout --track {branch}")',
        \   'multiple': v:false,
        \   'keymap': 'ctrl-t',
        \   'required': ['branch'],
        \   'confirm': v:false,
        \ },
        \ 'create': {
        \   'prompt': 'Create> ',
        \   'execute': 'echo system("{git} -C {cwd} checkout -b {input}")',
        \   'multiple': v:false,
        \   'keymap': 'ctrl-b',
        \   'required': ['input'],
        \   'confirm': v:false,
        \ },
        \ 'delete': {
        \   'prompt': 'Delete> ',
        \   'execute': 'echo system("{git} -C {cwd} branch -D {branch}")',
        \   'multiple': v:true,
        \   'keymap': 'ctrl-d',
        \   'required': ['branch'],
        \   'confirm': v:true,
        \ },
        \ 'merge':{
        \   'prompt': 'Merge> ',
        \   'execute': 'echo system("{git} -C {cwd} merge {branch}")',
        \   'multiple': v:false,
        \   'keymap': 'ctrl-e',
        \   'required': ['branch'],
        \   'confirm': v:true,
        \ },
        \ 'rebase':{
        \   'prompt': 'Rebase> ',
        \   'execute': 'echo system("{git} -C {cwd} rebase {branch}")',
        \   'multiple': v:false,
        \   'keymap': 'ctrl-r',
        \   'required': ['branch'],
        \   'confirm': v:true,
        \ },
      \}

let g:fzf_tag_actions = {
      \ 'checkout': {
      \   'prompt': 'Checkout> ',
      \   'execute': 'echo system("{git} -C {cwd} checkout {tag}")',
      \   'multiple': v:false,
      \   'keymap': 'enter',
      \   'required': ['tag'],
      \   'confirm': v:false,
      \ },
      \ 'create': {
      \   'prompt': 'Create> ',
      \   'execute': 'echo system("{git} -C {cwd} tag {input}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-b',
      \   'required': ['input'],
      \   'confirm': v:false,
      \ },
      \ 'delete': {
      \   'prompt': 'Delete> ',
      \   'execute': 'echo system("{git} -C {cwd} branch -D {tag}")',
      \   'multiple': v:true,
      \   'keymap': 'ctrl-d',
      \   'required': ['tag'],
      \   'confirm': v:true,
      \ },
      \}
