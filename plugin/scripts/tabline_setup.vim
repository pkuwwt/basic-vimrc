
if exists("&showtabline")
	set stal=1
endif
set tabline=%!MyTabLine()

if v:version>=700
	set switchbuf=usetab
endif

function! MyTabLine()
	let pagenr = tabpagenr('$')
	let curTab = tabpagenr()
	let startTab = 1
	let endTab = pagenr
	let len = 0
	if curTab <= pagenr / 2
		for i in range(curTab,pagenr)
			let len += (strlen(MyTabLabel(i)) + 1)
			if len > &columns - 5 
				let endTab = i - 1
				break
			endif
		endfor
		"echo "0startTab=".startTab.", endTab=".endTab.",len=".len
	elseif curTab > pagenr / 2
		for i in range(curTab, 1, -1)
			let len += (strlen(MyTabLabel(i))+1)
			if len > &columns - 5
				let startTab = i
				break
			endif
		endfor
		"echo "1startTab=".startTab.", endTab=".endTab.",len=".len
	endif

	let s = ''
	if startTab != 1
		let s .= "%#TabLine#<"
	endif
	for i in range(startTab,endTab)
		" select the highlighting
		if i == tabpagenr()
			let s .= '%#Visual#'
		else
			let s .= '%#TabLine#'
		endif

		" set the tab page number (for mouse clicks)
		let s .= '%' . (i) . 'T'

		" the label is made by MyTabLabel()
		let s .= '%{MyTabLabel(' . (i) . ')} '
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%#TabLine#%T'
	if endTab != pagenr
		let s .= '>'
	endif

	" right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let s .= '%=%#TabLine#%999XX'
	endif
	return s
endfunction

function! MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	return 
				\ strlen(bufname(buflist[winnr-1]))?
				\ GetBaseName(bufname(buflist[winnr-1])):'NoName'
endfunction

