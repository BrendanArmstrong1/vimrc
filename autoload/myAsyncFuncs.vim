
function! myAsyncFuncs#ToggleUltisnips() abort
  if !g:ultisnipsAsync
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
    let g:ultisnipsAsync = 1
  else
    call asyncomplete#unregister_source('ultisnips')
    let g:ultisnipsAsync = 0
  endif
endfunction

function! myAsyncFuncs#ToggleTabnine() abort
  if !g:tabnineAsync
    call asyncomplete#register_source(asyncomplete#sources#tabnine#get_source_options({
      \ 'name': 'tabnine',
      \ 'allowlist': ['*'],
      \ 'completor': function('asyncomplete#sources#tabnine#completor'),
      \ 'config': {
      \   'line_limit': 1000,
      \   'max_num_result': 10,
      \  },
      \ }))
    let g:tabnineAsync = 1
    call asyncomplete#force_refresh()
  else
    call asyncomplete#unregister_source('tabnine')
    let g:tabnineAsync = 0
  endif
endfunction

function! myAsyncFuncs#ToggleSpell() abort
    if !g:spellAsync
        if g:tabnineAsync
            call myAsyncFuncs#ToggleTabnine()
        endif
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
        set spell! spelllang=en_ca
        if !g:tabnineAsync
            call myAsyncFuncs#ToggleTabnine()
        endif
        call asyncomplete#unregister_source('look')
        call asyncomplete#unregister_source('look_good_words')
        let g:spellAsync = 0
    endif
endfunction
