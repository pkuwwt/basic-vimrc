
let mapleader = ","
nmap j gj
nmap k gk
map <HOME> gg
map <END> G

nmap <Leader>tn            :tabnew %<CR>
map <leader>tc :tabclose<CR>
map <leader>w :tabclose<CR>
map <leader>tm :tabmove 
map <leader>te :tabe 
nmap <silent> <Tab>        :tabn<CR>
nmap <silent> <S-Tab>      :tabp<CR>

nmap <Leader>bn :bnext<CR>
nmap <Leader>bp :bprevious<CR>

nmap <silent> <leader>e :tabe $HOME/.vimrc<CR>
nmap <silent> <leader>ss :call ReOpen()<CR>
nmap <silent> <leader>ss :source $HOME/.vimrc<CR>

nmap <F5> :call CompileCurrentFile()<CR>
nmap <F6> :call ExecuteCurrentFile()<CR>

" go to head of current line
map 0 ^

"Show matching bracet
set showmatch

"Smart way to move btw.window
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Moving fast to front,back and 2 sides
imap <M-$> <ESC>$a
imap <M-0> <ESC>0i
imap <D-$> <ESC>$a
imap <D-0> <ESC>0i

" Switch to current dir
map <leader>cd :cd %:p:h<CR>:echo "switch to current dir"<CR>

"set keywordprg=search(){\ espeak\ $*;sdcv\ $*;};search
set keywordprg=search(){\ espeak\ $*;sdcv\ $*;};search
set grepprg=grep\ -nH\ $*
set shellpipe=2>&1\|\ tee
" treat selected text as a filename and open it 
map <leader>k :<Del><Del><Del><Del><Del>!xdg-open "<C-R>*<Del>"<CR>

