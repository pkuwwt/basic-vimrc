"Enable syntax hl
if GetOsType()=="unix"
	if v:version<600
		if filereadable(expand("$VIM/syntax/syntax.vim"))
			syntax on
		endif
	else
		syntax on
	endif
else 
	syntax on 
endif
"syntax enable
syn keyword mynote NOTE: HELP: WARNING: TODO: ERROR:
highlight link mynote Todo

" emphasis words in txt file
if has("autocmd")
	au BufRead *.txt syn match EmphasisMarker contained "\*\*" conceal 
	au BufRead *.txt hi def link EmphasisMarker Ignore
	"au BufRead *.txt syn region Emphasis  start="\*\*" end="\*\*" 
	au BufRead *.txt syn match Emphasis  "\\\@<!\*\*[#-)!+-~]\+\*\*" contains=EmphasisMarker
	au BufRead *.txt hi def link Emphasis UnderLined
	au BufRead * syn match NonAscii "[^\x00-\x7F]"
endif


