function! Terminal#CloseTerm() abort
    w
    let l:list = getbufinfo({'buflisted': 1, 'bufloaded': 1})
    for item in l:list
      if item.name =~? "\!\/usr\/bin\/zsh"
        if (getbufvar(item.name, "&buftype") == "terminal")
            silent exe "bwipeout! zsh"
        endif
      endif
    endfor
endfunction
