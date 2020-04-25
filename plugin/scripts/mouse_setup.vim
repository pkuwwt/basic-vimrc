
au BufEnter * call SetupMouseAction()
"
" Double-Click action
" For source code(c/cpp/java): tag keyword
" For vim/help: help keyword
function! SetupMouseAction()
	if &filetype=="c" || &filetype=="cpp" || &filetype=="java"
		map <2-LeftMouse> :exe "tag ".expand("<cword>")<CR>
	elseif &filetype=="vim" || &filetype=="help"
		map <2-LeftMouse> :exe "h " . expand("<cword>")<CR>
	endif
endfunc

