
function! SaveSession()
	if !has("mksession")
		return
	endif
	if v:this_session == ""
		echo "no session saved"
	else
		exec "mksession! " . v:this_session
		echo "session saved"
	endif
endfunc

"Fast saving
nmap <leader>x :call SaveSession()<CR>:xa!<CR>
nmap <leader>s :call SaveSession()<CR>:w!<CR>

"""""""""""""""""""""""""""""""""
"==>emacs habit
"""""""""""""""""""""""""""""""""
nmap <C-x><C-c> :call SaveSession()<CR>:wqa<CR>
"""""""""""""""""""""""""""""""""
"==>windows habit
"""""""""""""""""""""""""""""""""
"nmap <C-s> :call SaveSession()<CR>:w!<CR>
"imap <C-s> <ESC>:call SaveSession()<CR>a

