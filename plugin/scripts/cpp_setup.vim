func! SwitchSourceHeader()
	let ext = expand("%:e")
	let basename = expand("%<")
	let src_exts = ["c","cpp","cxx"]
	let header_exts = ["h", "hpp", "hxx"]
	if ext=="h" || ext=="hpp" || ext=="hxx"
		let exts = src_exts
	elseif ext=="c" || ext=="cpp" || ext=="cxx"
		let exts = header_exts
    else
        let exts = []
	endif
	for e in exts 
		let file = basename . "." . e
		if filereadable(file)
			exec "e " . file
			break
		endif
	endfor
endfunc


func! GetIncludeDirs()
	let inc = " -I/usr/include "
	if search("vtk")
		let inc .= " -I/usr/include/vtk "
	endif
	if search("Python\.h")
		let inc .= " -I/usr/include/python2.7 "
	endif
	if search("<Q")
		let inc .= " -I/usr/include/qt4 -I/usr/include/QtCore -I/usr/include/QtGui -I/usr/include/Qt -I/usr/include/QtOpenGL "
	endif
	return inc
endfunc
func! GetCompileFlag()
	let compileflag = ""
	if search("QtGui") || search("QtCore")
		let compileflag .= " -lQtGui -lQtCore -lQtOpenGL "
	endif
	if search("execinfo\.h")
		let compileflag .= " -rdynamic "
	endif
	if search("glut\.h") != 0 || search("gl\.h")!=0
		let compileflag .= " -lglut -lGLU -lGL "
	endif
	if search("glfw") != 0 
		let compileflag .= " -lglfw -lGLU -lGL "
	endif
	if search("X11") || search("glx\.h") != 0 
		let compileflag .= " -lX11 -lXxf86vm "
	endif
	if search("cv\.h") != 0
		let compileflag .= " -lcv -lhighgui -lcvaux -lcxcore "
	endif
	if search("omp\.h") != 0
		let compileflag .= " -fopenmp "
	endif
	if search("libQccPack\.h") != 0
		let compileflag .= " -lQccPack -lpthread "
	endif
	if search("math\.h") != 0
		let compileflag .= " -lm "
	endif
	if search("vtk") != 0
		"let compileflag .= " -L/usr/local/lib -lvtkRendering -lvtkIO -lvtkGraphics -lvtkFiltering -lvtkCommon -lvtkVolumeRendering -lvtkImaging -lvtkWidgets -lvtkCharts -lvtksys "
		"let compileflag .= " -DvtkRenderingCore_AUTOINIT=\"2(vtkInteractionStyle,vtkRenderingOpenGL)\" -L/usr/lib64/vtk -lvtkRenderingCore -lvtkFiltersCore -lvtkRenderingVolume -lvtkChartsCore -lvtkCommonExecutionModel -lvtkCommonTransforms -lvtkFiltersSources -lvtkFiltersGeneral -lvtkCommonDataModel -lvtkCommonCore -lvtkIOImage -lvtkInteractionStyle -lvtkRenderingOpenGL "
	endif
	if search("osg") != 0
		let compileflag .= " -losgDB -losgGA -losgViewer -losg -losgUtil -losgText -losgSim -losgFX -lOpenThreads  -losgAnimation -losgWidget -losgManipulator -losgTerrain "
	endif
	if search("osgEarth") != 0
		let compileflag .= " -losgEarth -losgEarthUtil -losgEarthFeatures -losgEarthSymbology "
	endif
	if search("CGAL") 
		let compileflag .= " -lCGAL -lCGAL_Core -lCGAL_ImageIO -lCGAL_PDB -lgmp "
	endif
	if search("Fl\\.") != 0
		let compileflag .= " -lfltk -lfltk_gl "
	endif
	if search("gdal") != 0
		let compileflag .= " -lgdal "
	endif
	if search("<boost")
		let compileflag .= " -lboost_graph-mt "
	endif

	return compileflag 
endfunc

func! GetCompileCMDForC()
	let compilecmd="gcc  % -fdiagnostics-color=auto "
	let incDirs = GetIncludeDirs()
	let flag = GetCompileFlag() . incDirs
	let basename = expand("%<")
	if expand("%:e")=="h"
		return compilecmd . flag . " && rm -f " . basename . ".h.gch"
	endif
	if !search("main.*(.*int.*char.*)") && !search("main *()") 
		return compilecmd ." -c -g -Wall -O0 -lm "
	endif

	let compileflag=" -o " . basename . ".out -DCOMPILE_DEBUG -g -Wall -O0 -lm ".  flag
	if search("mpi\.h") != 0
		let compilecmd = "mpicc -fdiagnostics-color=auto "
	endif
	if search("COMPILE_DEPENDS")
		let _line = getline(line('.'))
		let _cs = substitute(_line, "^.*COMPILE_DEPENDS: ", "", "g")
		let _objs = substitute(_cs, "\\\.c", ".o", "g")
		if _cs==_objs
			return compilecmd._objs.compileflag
		else
			return compilecmd." "._cs." -c -Wall -O0 -g ".flag." && ".compilecmd._objs.compileflag
		endif

	endif
	return compilecmd.compileflag
endfunc

func! GetCompileCMDForCPP()
	let compilecmd="g++ % -fdiagnostics-color=auto -Wall -O0 "
	let incDir=GetIncludeDirs()
	let flag=incDir.GetCompileFlag()
	let ext = expand("%:e")
	let basename = expand("%<")
	let curfile = expand("%")
	if search("Q_OBJECT") && ext=="h"
		let mocfile = "moc_" . basename . ".cpp"
		return "moc-qt4 % > " . mocfile . " && ". compilecmd . flag . " -c -Wall " .  mocfile
	endif
	if ext=="h"
		return compilecmd . incDir. " && rm -f " . curfile . ".gch"
	endif
	if !search("main.*(.*int.*char.*)") 
		return compilecmd.flag." -c -g -Wall -O0 -lm " 
	endif
	let compileflag=flag." -o ".basename.".out -DCOMPILE_DEBUG -g -Wall -O0 -lm "
	if search("mpi\.h") != 0
		let compilecmd = "mpic++ -fdiagnostics-color=auto "
	endif
	if search("COMPILE_DEPENDS")!=0
		let _line = getline(line('.'))
		let _cs = substitute(_line, "^.*COMPILE_DEPENDS: ", "", "g")
		let _objs = substitute(_cs, "\\\.cpp", ".o", "g")
		if _objs==_cs
			return compilecmd._objs.compileflag
		else
			return compilecmd." "._cs." -c -Wall -O0 -g ".flag." && ".compilecmd._objs.compileflag
		endif
	endif
	return compilecmd.compileflag
endfunc

func! CompileGcc()
	call RunShellCommand(GetCompileCMDForC())
endfunc
func! CompileGpp()
	call RunShellCommand(GetCompileCMDForCPP())
endfunc

func! GotoNextKeyword(keyword) 
	let lineno = search(a:keyword)
	if lineno==0
		echo "No " . a:keyword . " found"
	else 
		call cursor(lineno)
	endif
endfunc

func! JumpFromDebugWinToFile()
	let curlineno = line(".")
	for ind in [0,1,2]
		let lineno = curlineno-ind
		let line = getline(lineno)
		let words = split(line, ':')
		if len(words)>=2 && buffer_exists(words[0]) && IsNumber(words[1]) 
			let lineno2 = str2nr(words[1])
			let col = 0
			if len(words)>=3 && IsNumber(words[2])
				let col = str2nr(words[2])
			endif
			wincmd w
			call cursor(lineno2, col)
			return
		endif
	endfor
endfunc

func! Compile_cpp(filename)
	call CompileGpp()
	if expand("%")==""
		noremap <buffer> <Enter> :call JumpFromDebugWinToFile()<CR>
		noremap <buffer> e :call GotoNextKeyword("error")<CR>
		noremap <buffer> w :call GotoNextKeyword("warning")<CR>
		noremap <buffer> q :q<CR>
		syn keyword WarningError warning error
		highlight link WarningError Todo
	endif
endfunc

func! Compile_c(filename)
	call CompileGcc()
	if expand("%")==""
		noremap <buffer> <Enter> :call JumpFromDebugWinToFile()<CR>
		noremap <buffer> e :call GotoNextKeyword("error")<CR>
		noremap <buffer> w :call GotoNextKeyword("warning")<CR>
		noremap <buffer> q :q<CR>
		syn keyword WarningError warning error
		highlight link WarningError Todo
	endif
endfunc

func! Execute_cpp(filename)
	exec "only"
	if search("mpi\.h") != 0
		exec "!mpirun -np 4 %<.out"
	elseif &filetype == "cpp" || &filetype=="c"
        if expand("%<")[0]=="/"
		    call RunShellCommand("" . expand("%<") . ".out")
        else
		    call RunShellCommand("./" . expand("%<") . ".out")
        endif
	endif
endfunc

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

map <F9> :call SwitchSourceHeader()<CR>

