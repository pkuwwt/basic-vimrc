
"clipboard with xclip
 if GetOsType()=="unix"
 	vmap <F6> :!xclip -sel c<CR>
 	map <F7> :-lr!xclip -o seln c<CR>'z
 endif


