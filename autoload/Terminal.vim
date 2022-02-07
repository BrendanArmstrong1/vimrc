function! Terminal#CloseTerm() abort
    w
    let i = bufnr("$")
    while (i >= 1)
        if (bufexists(i))
            if (getbufvar(i, "&buftype") == "terminal")
                silent exe "bwipeout! " . i
            endif
        endif
        let i-=1
    endwhile
    let g:markdown_preview = 0
endfunction

