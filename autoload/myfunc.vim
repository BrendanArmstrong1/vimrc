
function! myfunc#SaveQuitout() abort
    w
    execute "%bd!\|q!"
endfunction

function! myfunc#Quitout() abort
    execute "%bd!\|q!"
endfunction

function! myfunc#ExecuteStuff(location) abort
    w
    let l:name=expand('%:p')
    let l:exte=expand('%:e')
    if !term_list()->len()
        if l:exte == 'tex' || l:exte == 'html' || l:exte == 'css'
            let s:myjob = job_start('bash -c "compiler "' .. myfunc#Quoterepl(l:name))
            return
        elseif l:exte == 'js'
            let l:path=expand('%:p:h')
            if glob(l:path . "/index.html") != ""
                let s:myjob = job_start('bash -c "compiler "' .. myfunc#Quoterepl(l:name))
                return
            else
                if a:location == 'right'
                    vert ter ++kill=hup
                    call feedkeys("\<C-w>h")
                else
                    ter ++kill=hup
                    call feedkeys("\<C-w>k")
                endif
            endif
        else
            if a:location == 'right'
                vert ter ++kill=hup
                call feedkeys("\<C-w>h")
            else
                ter ++kill=hup
                call feedkeys("\<C-w>k")
            endif
        endif
    endif
    call term_sendkeys(term_list()[0], "clear && compiler " . myfunc#Quoterepl(l:name) . "\<CR>")
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

function! myfunc#Bracket_check() abort
    let l:aft = searchpos('[<>{}()\[\]`''"]','cnz',line('.'))
    call cursor(l:aft[0], l:aft[1]+1)
    startinsert
endfunction
