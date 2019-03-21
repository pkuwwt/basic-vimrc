
let mapleader = ","
set nocompatible

set fileencodings=utf-8,ucs-bom,cp936,latin1

set backspace=indent,eol,start

set nu
nmap j gj
nmap k gk
nmap <Leader>tn :tabnew<CR>
nmap <Tab>      :tabn<CR>
nmap <S-Tab>      :tabp<CR>

nmap <Leader>bn :bnext<CR>
nmap <Leader>bp :bprevious<CR>

nmap <F5> :call RunCode()<CR>

set hlsearch
set incsearch
set ignorecase
set smartcase

set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent

colorscheme desert

augroup mypython
	au!
	au BufNewFile,BufRead *.py,*.pyw call PythonSetup()
augroup END

nmap <Leader>e :e $MYVIMRC<CR>
augroup myvimrc
	au!
        au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

func! PythonSetup ()
	setf python
	set filetype=python
	set expandtab
endfunc

func! RunCode ()
	if &filetype=='python'
		if exists(':term')
			exec ':term python %'
		else
			exec ':!python %'
		endif
	endif
endfunc

