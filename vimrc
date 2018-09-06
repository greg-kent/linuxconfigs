" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd    " Show (partial) command in status line.
set showmatch    " Show matching brackets.
set ignorecase    " Do case insensitive matching
set smartcase    " Do smart case matching
set incsearch    " Incremental search
set hlsearch    " Switch on search pattern highlighting.
set autowrite    " Automatically save before commands like :next and :make
set hidden              " Hide buffers when they are abandoned
set mouse=a    " Enable mouse usage (all modes)
set nomousehide    " Don't hide the mouse

" My sets
set nocompatible      " We're running Vim, not Vi!
set ttyfast                     " Indicate fast terminal conn for faster
redraw
set noerrorbells                " No beeps
set number                      " Show line numbers
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowrite                   " Automatically save before :next, :make etc.
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set noshowmode                  " We show the mode with airline or lightline
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=10                " Completion window max size
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set nocursorline                " Do not highlight cursor (speeds up highlighting)
set lazyredraw                  " Wait to redraw

if filereadable("~/.vim/syntax/less.vim")
  source ~/.vim/syntax/less.vim
endif

set fileencodings=latin1

call plug#begin()
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

  " Split or join structs from multiline to singleline
  Plug 'AndrewRadev/splitjoin.vim'

  " Code snippets
  Plug 'SirVer/ultisnips'

  " Fuzzy finder for tags, files etc
  Plug 'ctrlpvim/ctrlp.vim'

  Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

  " Vim status line
  Plug 'itchyny/lightline.vim'

  " Different status line
  Plug 'vim-airline/vim-airline'

  " Colorscheme gruvbox
  Plug 'morhetz/gruvbox'

  " Mundo. Graphical undo
  Plug 'simnalamburt/vim-mundo'
  "Plug '~/.vim/plugged/vim-mundo'
 
  " Less syntax
  Plug 'lunaru/vim-less' 
call plug#end()

""""""""""""""""""
" Syntax/colours " 
""""""""""""""""""
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Whitespace rules
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set backspace=indent,eol,start  " Makes backspace key more powerful.
"set backspace=2

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.rb setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 backspace=2
autocmd BufNewFile,BufRead *.cc setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.h setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.p setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Whitespace and tab matching
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

syntax on             " Enable syntax highlighting
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'
"font size
if has('gui_running')
  set guifont=FantasqueSansMono\ Nerd\ Font\ 10
endif

" set the default plugin accessor
let g:mapleader = '\'

set nu

""""""""""""
" Mappings "
""""""""""""

nnoremap <CR> :set hlsearch! hlsearch?<CR>

vnoremap  g*  y/<C-R>"<CR>
nnoremap   g*  y/<C-R><C-W><CR>

" Quickfix
" Jump to next error with Ctrl-n and previous error with Ctrl-m. Close the
" quickfix window with <leader>a
map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <C-c> :cclose<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"nmap  <F5>  :TlistToggle<CR>
nmap  <F6>  <C-\>f
nmap  <F7>  <C-T>
nmap  gc  <C-T>
nmap  <F8>  <C-\>g
nmap  gd  <C-\>g
nmap  <F9>  <C-\>c
nmap  <F10> <C-\>s
nmap  <F12> <C-\>e

nmap  <S-F6>  :cs find f 
nmap  <S-F8>  :cs find g 
nmap  <S-F9>  :cs find c 
nmap  <S-F10> :cs find s 
nmap  <S-F12> :cs find e 

vmap  <F6>  y :cs find f <C-R>"<CR>
vmap  <F8>  y :cs find g <C-R>"<CR>
vmap  <F9>  y :cs find c <C-R>"<CR>
vmap  <F10>  y :cs find s <C-R>"<CR>
vmap  <F12>  y :cs find e <C-R>"<CR>

vmap  <F4> <Esc>`<O<Esc>0<Esc>i#if 0<Esc>`>o#endif /* 0 */<Esc>

imap <F2> OSL_Printf("%s(%d): %s\n", __FUNCTION__, __LINE__, );

" Set cscope to use global
set csprg=gtags-cscope
:cs add GTAGS 

" Global maps
"nmap gd :Gtags <C-R><C-W><CR>
nmap gr :Gtags -r <C-R><C-W><CR>
nmap gs :Gtags -s <C-R><C-W><CR>
nmap gf :Gtags -g <C-R><C-W><CR>
nmap gi :Gtags -gi <C-R><C-W><CR>
nmap gn :cn <CR>
nmap gp :cp <CR>
nmap gt :cc
nmap gl :cl <CR>
"nmap gc :ccl <CR>

" Enable mouse mode in tmux
set mouse=a

"let Tlist_File_Fold_Auto_Close = 1

" From Angus
" set tag search options
"set complete=.,w,b,d,],i,k
"set tags=~/.vim/tags
"set dictionary=~/.vim/wordlists/c-keywords.list
"set showfulltag   " when completng a word in ins mode 



" change strange menu popup defaults
":hi Pmenu     ctermfg=black  ctermbg=yellow guifg=black  guibg=yellow
":hi PmenuSel  ctermfg=yellow ctermbg=blue   guifg=yellow guibg=blue

" Life saving backup mechanism
" ==============================
"set backup
"let nowdate =  strftime("%d-%m-%Y")
"call system("mkdir -p ~/tmp/vim-backup/" . nowdate)
"call system("mkdir -p ~/tmp/vim-swap/" . nowdate)
"execute "set backupdir=~/tmp/vim-backup/".nowdate.",~/tmp,/tmp"
"execute "set directory=~/tmp/vim-swap/".nowdate.",~/tmp,/tmp"
"let nowtime =  strftime("%T")
"execute "set backupext=_" . nowtime 

" doxygen
" =======
"au BufNewFile,BufRead *.dox setfiletype doxygen
"let g:doxygen_enhanced_color=1


"""""""""""""""""""""
"      Plugins      "
"""""""""""""""""""""

" ctrl-p
" Change ctrl-p mapping, because want ctrl-p for previous quickfix
let g:ctrlp_map = '<C-o>'

" vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
" doesn't like vim 8
let g:go_version_warning = 0

" Increase the timeout of go test
let g:go_test_timeout='60s'

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>T  <Plug>(go-test)

  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test-func)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction


" Tag menu (Tlist)
" ================
let g:Tlist_WinWidth=20
"let g:Tlist_Use_SingleClick = 1
let g:Tlist_Show_One_File = 1
let g:Tlist_Auto_Highlight_Tag = 1
let g:Tlist_Highlight_Tag_On_BufEnter = 1

" WManager plugin
"================
let g:winManagerWindowLayout = "TagList,FileExplorer|BufExplorer"
let g:winManagerWidth = 35
let g:defaultExplorer = 1
let treeExplVertical = 1

" mapping commands
" ================

" Find references using (http://www.gnu.org/software/idutils/)
"nnoremap <silent> <F4> :Lid <C-R><C-W><CR>
"nnoremap <silent> \r :Lid <C-R><C-W><CR>

" Toggle the tags menu (winmanager)
"nnoremap <silent> <F5> :WMToggle<CR>
"nnoremap <silent> \w :WMToggle<CR>

" Toggle the NERD tree
"nnoremap <silent> \n :NERDTreeToggle<CR>

" FuzzyFinder (http://www.vim.org/scripts/script.php?script_id=1984)
" ==========
nnoremap <silent> <leader>F :FufBuffer<CR>
nnoremap <silent> <leader>f :FufFile<CR>
"nnoremap <silent> \t :FufTag<CR>


set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files

