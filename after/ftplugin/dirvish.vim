" unmap all default mappings
let g:dirvish_dovish_map_keys = 0

" unmap dirvish default
unmap <buffer> p

" Your preferred mappings
nmap <silent><buffer> i <Plug>(dovish_create_file)
nmap <silent><buffer> I <Plug>(dovish_create_directory)
nmap <silent><buffer> dk <Plug>(dovish_delete)
nmap <silent><buffer> r <Plug>(dovish_rename)
nmap <silent><buffer> y <Plug>(dovish_yank)
xmap <silent><buffer> y <Plug>(dovish_yank)
nmap <silent><buffer> p <Plug>(dovish_copy)
nmap <silent><buffer> P <Plug>(dovish_move)
