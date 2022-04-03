
" unmap dirvish default
unmap <buffer> p

" Your preferred mappings
nmap <silent><buffer> o <Plug>(dovish_create_file)
nmap <silent><buffer> O <Plug>(dovish_create_directory)
nmap <silent><buffer> dk <Plug>(dovish_delete)
nmap <silent><buffer> r <Plug>(dovish_rename)
nmap <silent><buffer> y <Plug>(dovish_yank)
nmap <silent><buffer> p <Plug>(dovish_copy)
nmap <silent><buffer> P <Plug>(dovish_move)
