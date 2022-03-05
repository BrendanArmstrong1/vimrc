" unmap dirvish default
unmap <buffer> p
" Your preferred mappings
nmap <silent><buffer> i <Plug>(dovish_create_file)
nmap <silent><buffer> I <Plug>(dovish_create_directory)
nmap <silent><buffer> dk <Plug>(dovish_delete)
nmap <silent><buffer> r <Plug>(dovish_rename)
nmap <silent><buffer> yy <Plug>(dovish_yank)
xmap <silent><buffer> yy <Plug>(dovish_yank)
nmap <silent><buffer> p <Plug>(dovish_copy)
nmap <silent><buffer> P <Plug>(dovish_move)
nmap <silent><buffer> <C-n> <Plug>(dirvish_git_next_file)
nmap <silent><buffer> <C-p> <Plug>(dirvish_git_prev_file)
