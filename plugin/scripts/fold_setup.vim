"""""""""""""""""""""""""""""""""""""""""""
"==> Folding
"""""""""""""""""""""""""""""""""""""""""""
"Enable folding
if exists("&foldenable")
	set fen
endif
if exists("&foldlevel")
	set fdl=0
endif
set foldmethod=manual
au! FileType c,cpp set foldmethod=syntax
"nmap <SPACE> zc

function! LatexFoldFunction()
  set foldmethod=expr
  set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
endfunc
au! FileType tex :call LatexFoldFunction()


