let g:git_messenger_always_into_popup=v:true
let g:git_messenger_include_diff = "current"
let g:git_messenger_close_on_cursor_moved = v:false
function! s:setup_git_messenger_popup() abort
    " Your favorite configuration here

    " For example, set go back/forward history to <C-o>/<C-i>
    nmap <buffer><C-o> o
    nmap <buffer><C-i> O
endfunction
autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()
