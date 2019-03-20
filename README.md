
# Basic vimrc as a plugin

## Install


Use it with vim-plug, `.vimrc` looks like

```

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'pkuwwt/basic-vimrc'
call plug#end()
```

And then execute `:PlugInstall`.

