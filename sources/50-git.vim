let g:git_messenger_no_default_mappings=v:true
" nmap <silent> <Leader>gm :call setbufvar(winbufnr(popup_atcursor(split(system("git log -n 1 -L '/" . getline('.') . "/',+1:" . expand("%:p")), "\n"), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })), "&filetype", "git")<CR>
nmap <silent> <leader>gm <CMD>call <SID>git_messenger_emulator()<CR>
nmap <silent> <leader>gM <plug>(git-messenger)
let g:git_messenger_always_into_popup=v:true
let g:git_messenger_include_diff = "current"
let g:git_messenger_close_on_cursor_moved = v:false

function! s:git_messenger_emulator() abort
    let l:line = shellescape(getline('.')->substitute("\\", "\\\\\\", 'g')->substitute("/", "\\\\/", 'g'))
    let l:len = len(l:line)
    let l:line = l:line[0] .. '/' .. strpart(l:line, 1, l:len-2) .. '/' .. l:line[l:len-1]
    let l:cmd = "git log -n 1 -L "
    call setbufvar(winbufnr(popup_atcursor(split(system(l:cmd .. l:line .. ",+1:" .. expand("%:p")), "\n"), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })), "&filetype", "git")
    " for ch in l:line
    "     echon ch
    " endfor
endfunction

function! s:setup_git_messenger_popup() abort
    " Your favorite configuration here

    " For example, set go back/forward history to <C-o>/<C-i>
    nmap <buffer><C-o> o
    nmap <buffer><C-i> O
endfunction
autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()
