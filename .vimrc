execute pathogen#infect()
syntax on
filetype plugin indent on

" don't give unsaved file warning when switching buffers (only when exiting)
"set hidden

set background=dark
colorscheme solarized
set cursorline

set tabstop=4
set shiftwidth=4
set expandtab

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

set rtp+=~/.fzf
nmap ,t :Files<CR>
imap <c-x><c-l> <plug>(fzf-complete-line)

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

" Ack.vim

" Use ag instead of ack - much faster
let g:ackprg = 'ag'
" map Ctrl-/ to search
nmap <C-_> :Ack

" F4 key toggles comments on or off
nnoremap <F4> :call NERDComment(0,"toggle")<CR>
vnoremap <F4> :call NERDComment(0,"toggle")<CR>

" Map Ctrl-h,j,k,l to move around splits
" Need to do some annoying term mapping to get Ctrl-H to work on os x
"tnoremap <Esc><Esc> <C-\><C-n>
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
nnoremap <Up>     :resize -2<CR>
nnoremap <Down>   :resize +2<CR>
nnoremap <Left>   :vertical resize +2<CR>
nnoremap <Right>  :vertical resize -2<CR>

let mapleader=";"
nnoremap <silent> <leader><SPACE> :split<CR>:term<CR>
nnoremap <silent> <leader><CR> :vsplit<CR>:term<CR>

" open splits to the bottom and right, which feels more natural
set splitbelow
set splitright

" Enable the list of buffers
"let g:airline#extensions#tabline#enabled = 1

" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'

"let g:airline#extensions#tabline#enabled = 2
"let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#right_sep = ' '
"let g:airline#extensions#tabline#right_alt_sep = '|'
"let g:airline_left_sep = ' '
"let g:airline_left_alt_sep = '|'
"let g:airline_right_sep = ' '
"let g:airline_right_alt_sep = '|'
"let g:airline_theme= 'solarized'
let g:airline_solarized_bg='dark'

" air-line
"let g:airline_powerline_fonts = 1
"
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

" old vim-powerline symbols
"let g:airline_left_sep = '»'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '«'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
"let g:airline_symbols.linenr = '⭡'
