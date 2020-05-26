
runtime plugin/scripts/python_setup
runtime plugin/scripts/cpp_setup
runtime plugin/scripts/gvim_setup
runtime plugin/scripts/shortcut_setup
runtime plugin/scripts/mouse_setup
runtime plugin/scripts/session_setup
runtime plugin/scripts/tabline_setup
runtime plugin/scripts/highlight_setup
runtime plugin/scripts/backup_setup

set nocompatible

set backspace=indent,eol,start
set history=400

autocmd! bufwritepost .vimrc :source $HOME/.vimrc

set nu
set hlsearch
set incsearch
set ignorecase
set smartcase

"backspace and cursor keys wrap to last/next line
set whichwrap+=<,>,h,l

"Set magic on(default is on)
set magic

set lbr
"set tw=500


set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent

if has("cindent")
	set cindent
	set cinoptions=g-1
endif

colorscheme desert

" Usage: 
"      :Shell ls -la
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
" Usage:
"    :Git add %
command! -complete=file -nargs=* Git  call s:RunShellCommand('git '.<q-args>)
command! -complete=file -nargs=* Svn  call s:RunShellCommand('svn '.<q-args>)
command! -complete=file -nargs=* Make call s:RunShellCommand('make '.<q-args>)

call SetupStatusLine()

set modeline
set modelines=1

" Copy to register *. In windows and Mac, it is the system clipboard
" For Linux, we should use vim-gtk
vmap Y "*y
nmap <Leader>e :e $MYVIMRC<CR>
augroup myvimrc
	au!
        au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

set path=.,**

if GetOsType()=="unix" || GetOsType()=="mac"
	set shell=bash
else
	"I have to run win32 python without cygwin
	"set shell=E:cygwininsh
endif

call SetupFileEncoding()


"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

