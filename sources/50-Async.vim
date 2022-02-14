call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
    \ 'name': 'ultisnips',
    \ 'allowlist': ['*'],
    \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
    \ }))

let g:lspAsync = 0
let g:ultisnipsAsync = 1
let g:tabnineAsync = 0
let g:spellAsync = 0
let g:asc_look_good_words_file = '~/.vim/spell/en.utf-8.add'

