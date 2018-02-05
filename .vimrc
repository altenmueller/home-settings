" To disable a plugin, add its bundle name to the following list
let g:pathogen_disabled = []

execute pathogen#infect()
syntax on
filetype plugin indent on

" don't autoindent yaml when hitting the '#' key
" (i like to comment out blocks of yaml)
autocmd FileType yaml setl indentkeys-=<#>
autocmd FileType yaml setl indentkeys-=0#

" make public: and private: blocks in c++ indent back
set cinoptions+=g0
set cinoptions+=N-s

" don't give unsaved file warning when switching buffers (only when exiting)
"set hidden

set background=dark
colorscheme solarized
set cursorline

set autoread " automatically check for changes in the file

set tabstop=2
set shiftwidth=2
set expandtab

" show tabs
set list
set listchars=tab:>.

" make backspace work over newlines and indentation
set backspace=indent,eol,start

" Create a vertical ruler at 80 characters
" set textwidth=80
" set colorcolumn=+1
set colorcolumn=80
set ruler

set nohlsearch      " disable search highlighting
set noincsearch     " don't jump around to the next match as we're typing

" Since I'm sloppy with my shift key, :Wq maps to :wq
command W w
command Wq wq

let mapleader=";"

set rtp+=~/.fzf
nmap ,t :call FuzzyFind()<CR>
imap <c-x><c-l> <plug>(fzf-complete-line)
let $FZF_DEFAULT_COMMAND = '(git ls-tree -r --name-only HEAD || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null'

function FuzzyFind()
  " Contains a null-byte that is stripped.
  let gitparent=system('git rev-parse --show-toplevel')[:-2]
  if empty(matchstr(gitparent, '^fatal:.*'))
    silent execute ':Files ' . gitparent
  else
    silent execute ':Files .'
  endif
endfunction

function AgFind()
  " Contains a null-byte that is stripped.
  let gitparent=system('git rev-parse --show-toplevel')[:-2]
  if empty(matchstr(gitparent, '^fatal:.*'))
    call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)
  else
    " WIP...
    silent execute ':Files .'
  endif
endfunction

" typing 'jj' is faster than hitting escape
imap jj <Esc>

set updatetime=1000

" Disables auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Rename tmux window to current file
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window $(basename " . expand("%"). ")")
augroup autocom
    autocmd!
    "executes the command on quit
     autocmd VimLeave * call system("tmux setw automatic-rename")
augroup END

" Uses filename regex for searching, not contents (seems to get better results)
"let g:ctrlp_regexp = 1
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.beam,*/.eunit/*,*.pyc

" Faster ctrlp indexing with ag
"let g:ctrlp_user_command = 'ag %s -i --nogroup --hidden --ignore .git --ignore .svn --ignore .hg --ignore "**/*.pyc" --ignore .DS_Store --ignore "**/*.ebin" --ignore "**/*.swp" --ignore "**/*.so" -g ""'

" F2 key opens Nerdtree
nmap <F2> :NERDTreeToggle<CR>

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
"unmap <C-t>
nmap <C-t> <C-o>

" F4 key toggles comments on or off
nnoremap <F4> :call NERDComment(0,"toggle")<CR>
vnoremap <F4> :call NERDComment(0,"toggle")<CR>

" Map Ctrl-h,j,k,l to move around splits
" Need to do some annoying term mapping to get Ctrl-H to work on os x
tnoremap <silent> <leader>; <C-\><C-N>
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
tnoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" Automatically enter terminal mode when switching to a terminal buffer.
autocmd BufWinEnter,WinEnter term://* startinsert

" Use arrow keys to resize panes
"nnoremap <Up>     :resize -2<CR>
"nnoremap <Down>   :resize +2<CR>
"nnoremap <Left>   :vertical resize +2<CR>
"nnoremap <Right>  :vertical resize -2<CR>

nnoremap <silent> <leader><SPACE> :split<CR>:term<CR>
nnoremap <silent> <leader><CR> :vsplit<CR>:term<CR>

" <leader>d closes current buffer without destroying split
nnoremap <silent> <leader>d :bp\|bd#<CR>
nnoremap <silent> <leader>D :bp\|bd!#<CR>

nnoremap <silent> <leader>b :Buffers<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap !w w !sudo tee > /dev/null %

" open splits to the bottom and right, which feels more natural
set splitbelow
set splitright

" support the mouse scroll wheel
set mouse=a

let g:airline_solarized_bg='dark'
