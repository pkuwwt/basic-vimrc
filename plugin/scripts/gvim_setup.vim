
if has("gui_running")
	"set guioptions-=m  "menu
	set guioptions-=T  "toolbar
	set guioptions-=l  "left-hand scrollbar(always present)
	set guioptions-=L  "left-hand scrollbar(when there is a vert-split win)
	set guioptions-=r  "right-hand scrollbar
	set guioptions-=R  "right-hand scrollbar

    " windows size
    set lines=30
    set columns=90


	if has("transparency")
		set transparency=40
	endif
	set guifont=Anonymous\ Pro:h24
	"set guifont=Andale\ Mono\ 18
	"set guifont=Bitstream\ Vera\ Sans\ Mono\ 18,Fixed\ 18
	"set guifontwide=Microsoft\ Yahei\ 18,WenQuanYi\ Zen\ Hei\ 18
	"set guifontwide=Microsoft\ Yahei\ 18

	if GetOsType()=="win32"
		"start gvim maximized
		if has("autocmd")
			au GUIEnter * simalt ~x
		endif
	endif
	"let psc_style='cool'
	if v:version>601
		"colorscheme ps_color
		"colorscheme default
		colorscheme elflord
		"colorscheme molokai
		"colorscheme evening 
		"colorscheme ir_black 
		"colorscheme murphy
		"colorscheme torte
	endif
	nmap <C-Tab> <ESC>:tabn<CR>
	nmap <S-Tab> <ESC>:tabp<CR>
""""""""""""""""""""""""""""
"==> term VIM setting
""""""""""""""""""""""""""""
else
	if v:version>601
		"colorscheme default
		colorscheme elflord
		"colorscheme molokai
		"colorscheme desert
		"colorscheme ir_black 
	endif
endif
set background=dark
"set background=black

"Some nice mapping to switch syntax(useful if one mixes different languages in
"one file)
"map <leader>1 :set syntax=cheetah<CR>
"map <leader>2 :set syntax=xhtml<CR>
"map <leader>3 :set syntax=python<CR>
"map <leader>4 :set ft=javascript<CR>
"map <leader>$ :syntax sync fromstart<CR>

"Highlight current
if has("gui_running")
	if exists("&cursorline")
		set cursorline
	endif
endif

