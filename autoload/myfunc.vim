function! myfunc#CloseTerm() abort
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

function! myfunc#SaveQuitout() abort
    w
    execute "%bd!\|q!"
endfunction

function! myfunc#Quitout() abort
    execute "%bd!\|q!"
endfunction

function! myfunc#ExecuteScript(location) abort
    w
    let l:name=expand('%:p')
    let l:exte=expand('%:e')
    if l:exte == 'md'
        if g:markdown_preview == 1
            return
        else
            call SetMarkdown(a:location)
            if a:location == 'right'
                call feedkeys("\<C-w>h")
            else
                call feedkeys("\<C-w>k")
            endif
            return
        endif
    endif
    if !term_list()->len()
        if l:exte == 'tex' || l:exte == 'html' || l:exte == 'css'
            ter ++hidden
        elseif l:exte == 'js'
            let l:path=expand('%:p:h')
            if glob(l:path . "/index.html") != ""
                ter ++hidden
            else
                if a:location == 'right'
                    vert ter
                else
                    ter
                endif
                call feedkeys("\<C-w>h")
            endif
        else
            if a:location == 'right'
                vert ter
            else
                ter
            endif
            call feedkeys("\<C-w>h")
        endif
    endif
    call term_sendkeys(term_list()[0], "clear && compiler " . Quoterepl(l:name) . "\<CR>")
endfunction

function! myfunc#Quoterepl(name) abort
    let l:len=len(a:name)
    for i in range(l:len)
        if a:name[i] == "\'"
            return strpart(a:name,0,i) . "\\" . strpart(a:name, i,l:len)
        endif
    endfor
    return a:name
endfunction

function! myfunc#Resize_Execution_Term(amount) abort
    if term_list()->len()
        let l:size=term_getsize(term_list()[0])
        call term_setsize(term_list()[0],l:size[0],l:size[1] + a:amount)
    endif
endfunction

let g:NetrwIsOpen=0
function! myfunc#ToggleNetrw() abort
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

function! myfunc#Bracket_check() abort
    let l:aft = searchpos('[<>{}()\[\]`''"]','cnz',line('.'))
    call cursor(l:aft[0], l:aft[1]+1)
    startinsert
endfunction

