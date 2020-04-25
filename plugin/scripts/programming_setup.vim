func! Compile_javascript(filename)
	exec "! node %"
endfunc

func! Execute_javascript(filename)
	exec "! node %"
endfunc

func! Compile_go(filename)
	exec "!go build %"
endfunc

func! Execute_go(filename)
	exec "!go run %"
endfunc

func! Compile_haskell(filename)
	exec "!/usr/local/bin/runhaskell %"
endfunc

func! Execute_haskell(filename)
	exec "!/usr/local/bin/runhaskell %"
endfunc

func! Compile_java(filename)
	exec "!javac %"
endfunc

func! Execute_java(filename)
	exec "!java %<"
endfunc

func! Compile_r(filename)
	exec "!Rscript  %"
endfunc

func! Execute_r(filename)
	exec "!Rscript  %"
endfunc

func! Compile_fortran(filename)
	exec "!gfortran % -o %<"
endfunc

func! Execute_fortran(filename)
	exec "! ./%<"
endfunc

func! Compile_cs(filename)
	exec "! mcs %"
endfunc

func! Execute_cs(filename)
	exec "! mono %<.exe"
endfunc

func! Compile_sh(filename)
	exec "! bash %"
endfunc

func! Execute_sh(filename)
	exec "! bash %"
endfunc
