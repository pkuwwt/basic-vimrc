
func! SetupCscope()

if has("cscope")
	if GetOsType()=="unix"
		set csprg=/usr/bin/cscope
	elseif GetOsType()=="win32"
		set csprg=cscope
	endif
	set csto=0  "cscope tag order(db,tags)
	set cst  "cscope tag
	set nocsverb  "reset cscope verbose
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
		" else and database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb  "show errors when adding DB
endif

" s->symbol, g->definition, d->funcs called by this func
" c->funcs calling this func
" t->string, e->egrep pattern, f->this file
" i->files including this file
nmap <C-@>s :cs find s  <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g  <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c  <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t  <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e  <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f  <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d  <C-R>=expand("<cword>")<CR><CR>

endfunc
