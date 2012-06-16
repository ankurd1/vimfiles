" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backup		" keep a backup file
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin indent on
set autoindent		" always set autoindenting on

" Tell vim to remember certain things when we exit
"  '10  :	marks will be remembered for up to 10 previously edited files
"  "100 :	will save up to 100 lines for each register
"  :20  :	up to 20 lines of command-line history will be remembered
"  %    : 	saves and restores the buffer list
"  n... : 	where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" Custom stuff starts here

"initialize pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

"behave like win
source ~/.vim/mswin.vim

"statusline
set laststatus=2

set statusline=%-1.2n\   " buffer number
set statusline+=%-40F\                    " path
"set statusline+=%t       "tail of the filename
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
"set statusline+=%{fugitive#statusline()}
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

"variables
let g:netrw_ftp_cmd="ftp -p"

let NERDTreeIgnore = ['\.pyc$', '\~$', '\.o']

let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = '\/\.git\/\|\~$\|\.swo$\|\.swp$'

let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'

let g:pep8_map='<leader>pp'

let g:ctrlp_max_files = 1000
" set options
set number
set hidden

set autochdir
set wildmenu
set wildmode=list:longest
set ignorecase
set smartcase
set title
set scrolloff=3
set guioptions=agimLtr

set completeopt=longest,menu,menuone,preview

set ts=4
set sw=4
set sts=4
set tw=80
set cc=+1

"Hotkeys
let nt=0
nnoremap <F2> :let nt=!nt<Bar>:if nt<Bar>:NERDTree<Bar>:else<Bar>:NERDTreeToggle<Bar>:endif<CR>

nnoremap <leader>' :nohl<CR>
inoremap <leader>' <C-o>:nohl<CR>
nnoremap <F6> :BufExplorer<CR>
map <leader><space> <leader>c<space>
"imap <leader><space> <C-o><leader>c<space>
imap <C-space> <C-x><C-o>
imap <Nul> <C-x><C-o>
nnoremap <F3> :Tlist<CR>
nnoremap <leader>n ^i<CR><Esc>
nnoremap <F7> :ConqueTermSplit bash<CR>
"nmap <F5> :w<CR>:make<CR>
map <silent> <Home> :SmartHomeKey <CR>
imap <silent> <Home> <C-O>:SmartHomeKey<CR>

nnoremap <space> za

"nnoremap <leader>f :FufFile<CR>
"nnoremap <leader>cf :FufCoverageFile<CR>
"nnoremap <leader>m :FufMruFile<CR>
"nnoremap <leader>mc :FufMruCmd<CR>
"
imap <C-V> <Esc>"+]p
nmap <C-V> <Esc>"+]p
vmap <C-C> "+y
vmap <C-x> "+d

nmap <leader>m :Mru<CR>

nmap <C-Left> <C-W><Left>
nmap <C-Right> <C-W><Right>
nmap <C-Down> <C-W><Down>
nmap <C-Up> <C-W><Up>

cmap w!! %!sudo tee > /dev/null %

"functions
fun! <SID>DetectHTMLDjango()
	let n = 1
	while n < 50 && n < line("$")
		if getline(n) =~ '{%\s*\(extends\|block\|comment\|ssi\|if\|for\| blocktrans\)\>'
			set ft=htmldjango
			return
		endif
		let n = n + 1
	endwhile
endfun

"autocmds
autocmd BufNewFile,BufRead *.html,*.htm call <SID>DetectHTMLDjango()
"autocmd BufNewFile,BufRead *.py set foldmethod=indent
"autocmd FileType python compiler pylint
