if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif

set nu
set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=100		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

set statusline=\ [PWD]\ %r%{CurrectDir()}%h\ \ [File]\ %f%m%r%h\ %w\ %=[Line\ %l,Row\ %c,Total\ %L]\ %=\ %P

function! CurrectDir()
    let curdir = substitute(getcwd(), "", "", "g")
	    return curdir
		endfunction

set laststatus=2

set ignorecase
set hlsearch
let g:winManagerWindowLayout = "FileExplorer"
let g:winManagerWidth = 30
nmap <silent> <F8> :WMToggle<cr>
let g:AutoOpenWinManager = 0 
nnoremap <silent> <F10> :tabc<CR>
nnoremap <silent> <F11> :tabp<CR>
nnoremap <silent> <F12> :tabn<CR>
colorscheme peachpuff
set autoindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smarttab
filetype on
filetype plugin on

fun SetupVAM()
set runtimepath+=~/vim-addons/vim-addon-manager
" commenting try .. endtry because trace is lost if you use it.
" There should be no exception anyway
" try
call vam#ActivateAddons(['taglist', 'OmniCppComplete', 'neocomplcache', 'Emmet'], {'auto_install' : 0})
" pluginA could be github:YourName see vam#install#RewriteName()
" catch /.*/
"  echoe v:exception
" endtry
endf
call SetupVAM()
" experimental: run after gui has been started (gvim) [3]
" option1:  au VimEnter * call SetupVAM()
" option2:  au GUIEnter * call SetupVAM()
" See BUGS sections below [*]

"-----------------------------------------------------------------
"
"" plugin - NeoComplCache.vim    自动补全插件

"-----------------------------------------------------------------
let g:AutoComplPop_NotEnableAtStartup = 1
let g:NeoComplCache_SmartCase = 1
let g:NeoComplCache_TagsAutoUpdate = 1
let g:NeoComplCache_EnableInfo = 1
let g:NeoComplCache_EnableCamelCaseCompletion = 1
let g:NeoComplCache_MinSyntaxLength = 3
let g:NeoComplCache_EnableSkipCompletion = 1
let g:NeoComplCache_SkipInputTime = '0.5'
let g:NeoComplCache_SnippetsDir = $VIMFILES.'/snippets'
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
imap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)
smap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
let g:neocomplcache_enable_at_startup = 1
