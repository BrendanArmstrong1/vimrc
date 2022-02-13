let g:AutoPairsMapCh = 0

function! s:tabout(dir) abort
    let l:pair = '"[{(<>)}]' . "'"
    let l:pos = col('.')-1
    if a:dir
        let l:lfor = getline('.')[l:pos:]
        for i in l:lfor
            let l:pos += 1
            if stridx(l:pair, i) != -1
                call cursor(0, l:pos+1)
                return ""
            endif
        endfor
    else
        let l:lbac = getline('.')[:l:pos]
        while l:pos > 0
            let l:pos -= 1
            if stridx(l:pair, l:lbac[l:pos]) != -1
                call cursor(0, l:pos+1)
                return ""
            endif
        endwhile
    endif
    return ""
endfunction

imap <silent> <C-l> <c-r>=<SID>tabout(1)<CR>
imap <silent> <C-h> <C-r>=<SID>tabout(0)<CR>

