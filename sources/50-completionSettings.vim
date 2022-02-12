
set completeopt=menuone,noinsert,popup
set pumheight=15
set pumwidth=10
set complete+=kspell
set complete-=i
set completepopup=height:15,width:60,align:menu
set showfulltag

func Thesaur(findstart, base)
  if a:findstart
	return searchpos('\<', 'bnW', line('.'))[1] - 1
  endif
  let res = []
  let h = ''
  for l in systemlist('aiksaurus '.shellescape(a:base))
if l[:3] == '=== '
  let h = '('.substitute(l[4:], ' =*$', ')', '')
elseif l ==# 'Alphabetically similar known words are: '
  let h = "\U0001f52e"
elseif l[0] =~ '\a' || (h ==# "\U0001f52e" && l[0] ==# "\t")
  call extend(res, map(split(substitute(l, '^\t', '', ''), ', '), {_, val -> {'word': val, 'menu': h}}))
endif
  endfor
  return res
endfunc

if exists('+thesaurusfunc')
  set thesaurusfunc=Thesaur
endif
set thesaurus=~/.vim/thesaurus/english.txt


