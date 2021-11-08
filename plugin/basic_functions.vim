
function! GetFileTimeStamp()
	return strftime("%Y-%m-%d %a %H:%M %p %Z%z", getftime(expand("%")))
endfunc

function! GetDirName(path)
	return substitute(a:path, "\/[^/]*$","","g")
endfunc

function! GetBaseName(path)
	let str = matchstr(a:path,"[^/]*$")
	return strlen(str)==0 ? a:path : str
endfunc
function! GetCurBaseName()
	return GetBaseName(expand("%"))
endfunc

function! GetCurDirName()
	return GetDirName(expand("%:p"))
endfunc

function! GetOsType()
	if has("win32")
		return "win32"
	elseif has("unix")
		return "unix"
	else
		return "mac"
	endif
endfunc

function! ReOpen()
	e %
endfunc

function! RunShellCommand(cmdline)
	echo a:cmdline
	let expanded_cmd = a:cmdline
	for part in split(a:cmdline, ' ')
		if part[0] =~ '\v[%#<]'
			let expanded_part = fnameescape(expand(part))
			let expanded_cmd = substitute(expanded_cmd, part, expanded_part,'')
		endif
	endfor
	botright new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
	setlocal autoread
	call setline(1, 'You entered:    ' . a:cmdline)
	call setline(2, 'Expanded Form:  ' . expanded_cmd)
	call setline(3, substitute(getline(2), '.', '=', 'g'))
	execute '$read ! ' . expanded_cmd
	setlocal nomodifiable
	1
endfunc

function! SetupStatusLine()
	set laststatus=2
	set statusline=
	"%2* - 
	"%0* - restore normal highlight
	"%n -  buffer number, 
	set statusline+=%2*%-2.3n%0*\  
	set statusline+=%t\  "file name
	set statusline+=%h[%m%r%w "flags:[help][line][+][RO][Preview]
	"set statusline+=[
	if v:version >= 600
		set statusline+=%{strlen(&ft)?&ft:'none'},\ "filetype
		set statusline+=%{&encoding}, "encoding
	endif
	set statusline+=%{&fileformat}] "file format
	if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
		set statusline+=\ %{VimBuddy()} "vim buddy
	endif
	set statusline+=%= "right align
	set statusline+=%2*0x%-8B\  "current char
	set statusline+=%-14.(%l,%c%V%)\ %<%P  "offset

	"special statusbar for special windows
	if has("autocmd")
		au FileType qf
			\ if &buftype=="quickfix"|
			\ setlocal statusline=%2*%-3.3n%0*|
			\ setlocal statusline+=\ \[Compiler\ Messages\]|
			\ setlocal statusline+=%=%2*\ %<%P|
			\ endif
		fun! FixMiniBufExplorerTitle()
			if "-MiniBufExplorer-"==bufname("%")
				setlocal statusline=%2*%-3.3n%0*
				setlocal statusline+=\[Buffers\]
				setlocal statusline+=%=%2*\ %<%P
			endif
		endfun
		if v:version>=600
			au BufWinEnter *
						\ let oldwinnr=winnr()|
						\ windo call FixMiniBufExplorerTitle()|
						\ exec oldwinnr." wincmd w"
		endif
	endif

	"Nice window title
	if has('title') && (has('gui_running') || &title)
		set titlestring=
		set titlestring+=%f\  "filename
		set titlestring+=%h%m%r%w  "flags
		set titlestring+=\ -\ %{v:progname}  "program name
	endif
endfunction

function! SetupFileEncoding()
"Internationalization
" " encoding recognize
" set encoding=utf-8
" "set fileencodings=latin1,utf-8,chinese,gbk,ucs-bom,cp936,gb2312,gb18030,utf-16,big5
" "set fileencodings=latin1,utf-8,chinese,gbk,ucs-bom,cp936,gb2312,gb18030,big5
" set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" "set fileencodings=big5
" ecoding setting
if has("multi_byte")
    "set fileencoding priority
	if getfsize(expand("%")) > 0
		set fileencodings=ucs-bom,utf-8,chinese,gbk,gb2312,gb18030,cp936,big5,euc-jp,euc-kr,latin1
	else
		set fileencodings=cp936,big5,euc-jp,euc-kr,latin1
	endif
	" CJK environment detection and corresponding setting
	if v:lang =~ "^zh_CN"
		" Use cp936 to support BGK, euc-cn == gb2312
		set encoding=cp936
		set termencoding=cp936
		set fileencoding=cp936
	elseif v:lang =~ "^zh_TW"
		" cp950, big5 or euc-tw
		" are they equal to each other?
		set encoding=big5
		set termencoding=big5
		set fileencoding=big5
	elseif v:lang =~ "^ko"
		" copied from someone's dotfile, untested
		set encoding=euc-kr
		set termencoding=euc-kr
		set fileencoding=euc-kr
	elseif v:lang =~ "^jp_JP"
		" copied from someone's dotfile, untested
		set encoding=euc-jp
		set termencoding=euc-jp
		set fileencoding=euc-jp
	endif
	" Detect UTF-8 locale, and replace CJK setting if needed
	if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
		set encoding=utf-8
		set termencoding=utf-8
		set fileencoding=utf-8
	endif
else
	echoerr "Sorry, this version of (g)vim waw not compiled with multi_byte"
endif
endfunc

function! SecretFile()
	set noundofile
	noswapfile edit %
endfunction

function! ScrollBindAllWindow()
	set scrollbind
	exe "normal \<C-W>w"
	set scrollbind
	exe "normal \<C-W>w"
endfunction


function! ReloadWithUTF8()
    exec ':e! ++enc=utf-8 %'
endfunction

function! ReloadWithGBK()
    exec ':e! ++enc=gbk %'
endfunction

function! ReloadFileEncoding()
	if &encoding == 'utf-8' && &fileencoding == 'latin1'
		exec ':e! ++enc=utf-8 %'
	endif
endfunction


func! ExecuteFile(filename)
	:exec "call Execute_".&filetype."(\"".a:filename."\")"
	if expand("%")==""
		noremap <buffer> q :q<CR>
	endif
endfunc

func! ExecuteCurrentFile()
	call ExecuteFile(expand("%:p"))
endfunc

func! CompileFile(filename)
	:exec "call Compile_".&filetype."(\"".a:filename."\")"
	if expand("%")==""
		noremap <buffer> q :q<CR>
	endif
endfunc

func! CompileCurrentFile()
	call CompileFile(expand("%:p"))
endfunc

function! HighlightNonAscii()
	hi NonAscii ctermfg=blue
endfunction

func! IsNumber(text)
	return match(a:text, "^[0-9]\\+$")!=-1
endfunc

func! DeleteTillSlash()
	let g:cmd=getcmdline()
	if GetOsType()=="unix"||GetOsType=="mac"
		let g:cmd_edited = substitute(g:cmd,"(.*[/]).*","","")
		let g:cmd_edited=substitute(g:cmd,"(.*[\])","","")
	endif
	if g:cmd==g:cmd_edited
		if GetOsType()=="unix"||GetOsType()=="mac"
			let g:cmd_edited = substitute(g:cmd,"(.*[/]).*/","","")
		else
			let g:cmd_edited = substitute("(.*[\].*[\])","","")
		endif
	endif
	return g:cmd_edited
endfunc

func! GeCWD()
	let cwd=getcwd()
	return "e ".cwd
endfunc
