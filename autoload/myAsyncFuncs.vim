
function! myAsyncFuncs#ToggleUltisnips() abort
  if !g:ultisnipsAsync
    echom "Snippets On"
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
    let g:ultisnipsAsync = 1
  else
    echom "Snippets Off"
    call asyncomplete#unregister_source('ultisnips')
    let g:ultisnipsAsync = 0
  endif
endfunction

function! myAsyncFuncs#ToggleALE() abort
  if !g:ALEAsync
    echom "ALE On"
    call asyncomplete#ale#register_source({
        \ 'name': 'reason',
        \ 'linter': 'flow',
        \ })
    let g:ALEAsync = 1
    call asyncomplete#force_refresh()
  else
    echom "ALE Off"
    call asyncomplete#unregister_source('reason')
    let g:ALEAsync = 0
  endif
endfunction

function! myAsyncFuncs#ToggleSpell() abort
    if !g:spellAsync
        echom "Spelling On"
        set spell! spelllang=en_ca
        call asyncomplete#register_source({
            \ 'name': 'look',
            \ 'allowlist': ['*'],
            \ 'completor': function('asyncomplete#sources#look#completor'),
            \ })
        call asyncomplete#register_source({
            \ 'name': 'look_good_words',
            \ 'allowlist': ['*'],
            \ 'completor': function('asyncomplete#sources#look#good_words'),
            \ })
        let g:spellAsync = 1
        call asyncomplete#force_refresh()
    else
        echom "Spelling Off"
        set spell! spelllang=en_ca
        call asyncomplete#unregister_source('look')
        call asyncomplete#unregister_source('look_good_words')
        let g:spellAsync = 0
    endif
endfunction
