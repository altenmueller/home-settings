execute pathogen#infect()
syntax on
filetype plugin indent on

set background=dark
colorscheme solarized
set cursorline

set tabstop=4
set shiftwidth=4
set expandtab

" Create a vertical ruler at 80 characters
" set textwidth=80
" set colorcolumn=+1  
set colorcolumn=80
set ruler

" Since I'm sloppy with my shift key, :Wq maps to :wq
command W w
command Wq wq

" maps ,t to open CtrlP
nmap ,t :CtrlP<CR>
nmap <C-l> <C-t>

" typing 'jj' is faster than hitting escape
imap jj <Esc>

let Tlist_Use_Right_Window=1
let Tlist_Enable_Fold_Column=0
let Tlist_Show_One_File=1 " especially with this one
let Tlist_Compact_Format=1
"let Tlist_Ctags_Cmd='/opt/local/bin/ctags'
set updatetime=1000

" Add the following below if you want to generate ctags upon saving a file
" Auto-generate ctags upon making changes to a file
"autocmd BufWritePost *.erl :silent !(cd %:p:h;ctags *)&

" If you want to auto compile (erlc) upon saving a file, then add that one as well
" Run erlc on the file being saved
"autocmd BufWritePost *.erl :!erlc <afile>

" Disables auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Rename tmux window to current file
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window $(basename " . expand("%"). ")")
augroup autocom
    autocmd!
    "executes the command on quit
     autocmd VimLeave * call system("tmux rename-window zsh")
augroup END

" Uses filename regex for searching, not contents (seems to get better results)
let g:ctrlp_regexp = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.beam,*/.eunit/*,*.pyc

" Faster ctrlp indexing with ag
let g:ctrlp_user_command = 'ag %s -i --nogroup --hidden --ignore .git --ignore .svn --ignore .hg --ignore "**/*.pyc" --ignore .DS_Store --ignore "**/*.ebin" --ignore "**/*.swp" --ignore "**/*.so" -g ""'

" F2 key opens Nerdtree
nmap <F2> :NERDTree<CR>

" Use the system clipboard as the default register. This lets vim share text
" with other programs easily.
set clipboard=unnamedplus

" Function to pipe text to an external command. Unused for now.
function Syscopy() range
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| ssh host ~/xclip.sh')
endfunction

" YouCompleteMe

" Auto load our custom .ycm_extra_conf.py
let g:ycm_extra_conf_globlist = ['~/foghorn-edgestack/*']
" Use this dummy file to suppress warnings about missing ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" Don't show the autocomplete by default.
let g:ycm_auto_trigger = 0
" Only run for C/C++ files
let g:ycm_filetype_whitelist = { 'cpp': 1, 'c': 1 }
" Ctrl-backslash invokes auto complete dialog
let g:ycm_key_invoke_completion = '<C-\>'
" Disable the dialog that pops up at the top after you select from the autocomplete
"set completeopt-=preview
" Jump to new tab when we use the 'Go To' command
"let g:ycm_goto_buffer_command = 'new-tab'

" Ctrl-] jumps to the defn of a symbol - just like in ctags
nmap <C-]> :YcmCompleter GoTo<CR>
" Ctrl-t goes back
unmap <C-t>
nmap <C-t> <C-o>

" Ack.vim

" Use ag instead of ack - much faster
let g:ackprg = 'ag'
" map Ctrl-/ to search
nmap <C-_> :Ack 
