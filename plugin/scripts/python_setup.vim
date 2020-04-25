
augroup mypython
	au!
	au BufNewFile,BufRead *.py,*.pyw call PythonSetup()
augroup END

func! PythonSetup()
	setf python
	set filetype=python
	set expandtab
endfunc

func! Execute_python(filename)
	if &filetype=='python'
		if exists(':term')
			exec ':term python '.a:filename
		else
			exec ':!python '.a:filename
		endif
	endif
endfunc

func! Compile_python(filename)
	call Execute_python(a:filename)
endfunc
