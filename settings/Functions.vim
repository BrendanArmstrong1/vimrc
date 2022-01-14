function! CloseTerm() abort
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

function! SaveQuitout() abort
    w
    execute "%bd!\|q!"
endfunction

function! Quitout() abort
    execute "%bd!\|q!"
endfunction

function! ExecuteScript(location) abort
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

let g:markdown_preview = 0
function! SetMarkdown(loc) abort
    let g:markdown_preview = 1
    if a:loc == 'right'
        PreviewMarkdown right
    else
        PreviewMarkdown bottom
    endif
endfunction

function! Quoterepl(name) abort
    let l:len=len(a:name)
    for i in range(l:len)
        if a:name[i] == "\'"
            return strpart(a:name,0,i) . "\\" . strpart(a:name, i,l:len)
        endif
    endfor
    return a:name
endfunction

function! Resize_Execution_Term(amount) abort
    if term_list()->len()
        let l:size=term_getsize(term_list()[0])
        call term_setsize(term_list()[0],l:size[0],l:size[1] + a:amount)
    endif
endfunction

function! ToggleNetrw() abort
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

function! Bracket_check() abort
    let l:aft = searchpos('[<>{}()\[\]`''"]','cnz',line('.'))
    call cursor(l:aft[0], l:aft[1]+1)
    startinsert
endfunction

"Auto Pair stuff
function! s:bracket_pairing(name) abort
    let l:line = getline('.')
    let l:len = l:line->len()
    let l:count = 0
    if a:name == "("
        let l:pair = ")"
    elseif a:name == "["
        let l:pair = "]"
    elseif a:name == "{"
        let l:pair = "}"
    elseif a:name == "\""
        let l:pair = "\""
    elseif a:name == "'"
        let l:pair = "'"
    endif
    for i in range(l:len)
        if a:name == "\""
            if l:line[i] == a:name && l:line[i-1] !~ '[\\]'
                if l:count
                    let l:count = 0
                else
                    let l:count += 1
                endif
            endif
        elseif a:name == "'"
            if l:line[col('.')-2] =~ '[A-Z]'
                return a:name
                echon l:line[col('.')-1]
            endif
            if l:line[i] == a:name && l:line[i-1] !~ '[A-Z\\]'
                if l:count
                    let l:count = 0
                else
                    let l:count += 1
                endif
            endif
        else
            if l:line[i] == a:name && l:line[i-1] != "\\"
                let l:count += 1
            elseif l:line[i] == l:pair && l:line[i-1] != "\\"
                let l:count -= 1
            endif
        endif
    endfor
    if l:count
        return a:name
    else
        return a:name . l:pair . "\<left>"
    endif
endfunction
inoremap <expr><silent> ( <SID>bracket_pairing("(")
inoremap <expr><silent> [ <SID>bracket_pairing("[")
inoremap <expr><silent> { <SID>bracket_pairing("{")
inoremap <expr><silent> " <SID>bracket_pairing("\"")
inoremap <expr><silent> ' <SID>bracket_pairing("'")


"Auto backspace after an autopair
function! s:bs_delete() abort
    let l:line = getline('.')
    let l:before = l:line[col(".")-2]
    let l:after = l:line[col(".")-1]
    if l:before == "("
        if l:after == ")"
            return "\<right>\<BS>\<BS>"
        endif
    elseif l:before == "["
        if l:after == "]"
            return "\<right>\<BS>\<BS>"
        endif
    elseif l:before == "{"
        if l:after == "}"
            return "\<right>\<BS>\<BS>"
        endif
    elseif l:before == "\""
        if l:after == "\""
            return "\<right>\<BS>\<BS>"
        endif
    elseif l:before == "'"
        if l:after == "'"
            return "\<right>\<BS>\<BS>"
        endif
    endif
    return "\<BS>"
endfunction
inoremap <expr><silent> <BS> <SID>bs_delete()

function! s:prefix_zero(num) abort
  if a:num < 10
    return '0'.a:num
  endif
  return a:num
endfunction

" Callback function for Calendar.vim
function! DiaryDay(day, month, year, week, dir, wnum) abort
  let day = s:prefix_zero(a:day)
  let month = s:prefix_zero(a:month)

  let link = a:year.'-'.month.'-'.day
  if winnr('$') == 1
    if a:dir ==? 'V'
      vsplit
    else
      split
    endif
  else
    wincmd p
    if !&hidden && &modified
      new
    endif
  endif

  call vimwiki#diary#make_note(a:wnum, 0, link)
endfunction

autocmd FileType calendar nmap <buffer> <CR>
    \ :call DiaryDay(b:calendar.day().get_day(), b:calendar.day().get_month(),
    \ b:calendar.day().get_year(), b:calendar.day().week(), "V", v:count1)<CR>
