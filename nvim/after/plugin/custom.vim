fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup TRIMTRIMTRIM
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

