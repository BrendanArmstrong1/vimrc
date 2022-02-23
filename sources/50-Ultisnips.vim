"=============================================================================
"====================  _   _ _ _   _      ____        _            ===========
"==================== | | | | | |_(_)    / ___| _ __ (_)_ __  ___  ===========
"==================== | | | | | __| |____\___ \| '_ \| | '_ \/ __| ===========
"==================== | |_| | | |_| |_____|__) | | | | | |_) \__ \ ===========
"====================  \___/|_|\__|_|    |____/|_| |_|_| .__/|___/ ===========
"====================                                |_|           ===========
"=============================================================================

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipesRemoveSelectModeMappings = 0
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

let g:ulti_expand_or_jump_res = 0
function! Ulti_ExpandOrJump_Res() abort
    if pumvisible()
        return 0 "Sloppy Workaround for out of order operations
    endif
    call UltiSnips#ExpandSnippetOrJump()
    return g:ulti_expand_or_jump_res
endfunction

function! Check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[:col - 1]  =~# "^\\s*$"
endfunction
