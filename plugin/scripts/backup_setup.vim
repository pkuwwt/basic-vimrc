
if GetOsType()=="unix"
	if !isdirectory(expand("$HOME/.backup"))
		call mkdir(expand("$HOME/.backup"))
	endif
	set backup
	set writebackup
	set backupdir=~/.backup
	let &bex="-".strftime("%Y%m%d-%H%M")."~"
elseif GetOsType()=="win32"
elseif GetOsType()=="mac"
endif

