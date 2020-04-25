""""""""""""""""""""""
"==> Tag list(ctags) - not used
""""""""""""""""""""""
function! AddTags()
"	let cwd = getcwd()
"	let curDir = substitute(expand("%:p:h")," ", "\\\ ","g")
"	exec "cd ".curDir
	exec "!ctags -R --language-force=c++ --c++-kinds=+p --fields=+iaS --extra=+q ."
"	exec "cd ".cwd
	exec "let &tags='./tags,'.&tags"
endfunc

map <silent> <F3> :TlistToggle<CR>
map <silent> <leader>t :TlistToggle<CR>
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
	\ :set tags+=tags<CR>
" tags
let Tlist_WinWidth=20
if GetOsType()=="win32"
	let Tlist_Ctags_Cmd="ctags"
elseif GetOsType()=="unix"
	let Tlist_Ctags_Cmd="/usr/bin/ctags"
endif
"let Tlist_Show_One_File=1 "show current file's tag only
"When displaying multifile-tags, only current file's tags show
"let Tlist_File_Fold_Auto_Close=1 
let Tlist_Exit_OnlyWindow=1  "if taglist window is the last window, exit
"let Tlist_Use_Right_Window=1 "right side
let Tlist_Sort_Type="name"
"let Tlist_GainFocus_On_ToggleOpen=1  "taglist window open with being focused
"let Tlist_Auto_Open=1
"let Tlist_Close_On_Select=1
if has("gui_running")
	let Tlist_Show_Menu=1
endif

set tags=tags
"set tags+=$VIM/../Mingw-gcc/tags
set tags+=~/.vim/ctags/c.tags
set tags+=~/.vim/ctags/cpp.tags
"set tags+=$HOME/.vim/ctags/mpich2.tags
"set tags+=$HOME/.vim/ctags/qt.tags
set tags+=$HOME/.vim/ctags/opengl.tags
set tags+=$HOME/.vim/ctags/opencv.tags
set tags+=$HOME/.vim/ctags/x11.tags
set tags+=$HOME/.vim/ctags/cv.tags
"set tags+=$HOME/.vim/ctags/kernel.tags
"set tags+=$HOME/Documents/Src/jasper/src/tags
set tags+=$HOME/.vim/ctags/vim.tags
"set tags+=~/Programs/QccPack/ctags
"set tags+=$HOME/.vim/ctags/osgearth.tags
set tags+=$HOME/.vim/ctags/osg.tags
set tags+=$HOME/.vim/ctags/qt.tags
set tags+=$HOME/.vim/ctags/vtk.tags
au! FileType java set tags+=$HOME/.vim/ctags/java.tags


