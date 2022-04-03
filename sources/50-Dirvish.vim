let g:loaded_netrwPlugin = 1
let g:dirvish_relative_paths = 0
let g:dirvish_mode = ':sort ,^.*[\/],'
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>


augroup dirvish_config
  autocmd!

    " Map `gh` to hide dot-prefixed files.  Press `R` to "toggle" (reload).
    autocmd FileType dirvish nnoremap <silent><buffer> <c-s> :silent keeppatterns g@\v/\.[^\/]+/?$@d _<cr>:setl cole=3<cr>

    autocmd FileType dirvish nnoremap <silent><buffer> t ddO<Esc>:let @"=substitute(@", '\n', '', 'g')<CR>
          \ :r ! find "<C-R>"" -maxdepth 1 -print0 \| xargs -0 ls -Fd<CR>
          \ :silent! keeppatterns %s/\/\//\//g<CR>
          \ :silent! keeppatterns %s/[^a-zA-Z0-9\/]$//g<CR>
          \ :silent! keeppatterns g/^$/d<CR>
          \ :noh<CR>

augroup END
