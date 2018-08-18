set nocompatible | filetype indent plugin on | syn off

call plug#begin()
"ui stuff
Plug 'megaannum/self'
Plug 'megaannum/forms'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'roxma/nvim-completion-manager'
Plug 'semanticart/simple-menu.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'Shougo/denite.nvim'

"colors
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim', { 'as': 'dracula' }

"general text productivity 
Plug 'ervandew/supertab'
Plug 'rking/ag.vim'
Plug 'wellle/targets.vim'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/SyntaxRange'
Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim'
Plug 'vim-scripts/LargeFile'

Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'

Plug 'neomake/neomake'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'kien/rainbow_parentheses.vim'

Plug 'gabrielelana/vim-markdown'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'elzr/vim-json'
Plug 'posva/vim-vue', { 'for': 'javascript'}
"Plug 'alx741/vim-hindent'
Plug 'mpickering/hlint-refactor-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'elmcast/elm-vim', { 'for': 'json' }
Plug 'mattn/emmet-vim'
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'tpope/vim-classpath', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'raichoo/purescript-vim', { 'for': 'purescript'}
Plug 'frigoeu/psc-ide-vim', { 'for': 'purescript'}

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

"Plug 'jlanzarotta/bufexplorer'
"Plug 'Shougo/vimproc', { 'do': 'make' }
"Plug 'Shougo/vimshell'
"Plug 'shime/vim-livedown'
"Plug 'scrooloose/syntastic'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"Plug 'ensime/ensime-vim', { 'for': 'scala1' }
"Plug 'jeffkreeftmeijer/vim-numbertoggle'
"Plug 'easymotion/vim-easymotion'
"Plug 'parsonsmatt/intero-neovim'
"Plug 'eagletmt/neco-ghc'
"Plug 'dan-t/vim-hsimport' "needs stack install hsimport hdevtools
"Plug 'chrisbra/csv.vim'
call plug#end()

" Automatically reload on save
"au BufWritePost *.hs InteroReload

"function! IGenericType()
  "call intero#repl#type(1)
"endfunction

"function! IType()
  "call intero#repl#type(0)
"endfunction

"function! IStartAndLoad()
  "call intero#process#start()
  "call intero#repl#load_current_file()
"endfunction


"au FileType haskell nnoremap <silent> <leader>it :call SimpleMenu([ 
  "\ ['1','Start and load current file', 'IStartAndLoad'], 
  "\ ['2','Type', 'IType'],
  "\ ['3','Generic Type', 'IGenericType'],
  "\ ['4','Insert type', 'intero#repl#insert_type'], 
  "\ ['5','Load current module', 'intero#repl#load_current_module'], 
  "\ ['6','Load current file', 'intero#repl#load_current_file'], 
  "\ ['7','Open', 'intero#process#open'], 
  "\ ['8','Hide', 'intero#process#hide'], 
  "\ ['9','Restart', 'intero#process#restart'], 
  "\ ['0','Reload', 'intero#repl#reload'], 
  "\ ])<CR>

"" Lookup the type of expression under the cursor
"au FileType haskell nmap <silent> <leader>t <Plug>InteroGenericType
"au FileType haskell nmap <silent> <leader>T <Plug>InteroType
"" Insert type declaration
"au FileType haskell nnoremap <silent> <leader>s :InteroTypeInsert<CR>
"" Show info about expression or type under the cursor
"au FileType haskell nnoremap <silent> <leader>i :InteroInfo<CR>

"" Open/Close the Intero terminal window
"au FileType haskell nnoremap <silent> <leader>o :InteroOpen<CR>
"au FileType haskell nnoremap <silent> <leader>h :InteroHide<CR>

"" Reload the current file into REPL
"au FileType haskell nnoremap <silent> <leader>l :InteroLoadCurrentFile<CR>
"" Jump to the definition of an identifier
"au FileType haskell nnoremap <silent> gd :InteroGoToDef<CR>
"" Evaluate an expression in REPL
"au FileType haskell map <silent> <leader>e :InteroEval<CR>
"au FileType haskell nmap <silent> <leader>u :InteroUses<CR>

"" Start/Stop Intero
"au FileType haskell nnoremap <silent> <leader>st :InteroStart<CR>
"au FileType haskell nnoremap <silent> <leader>k :InteroKill<CR>

"" Reboot Intero, for when dependencies are added
"au FileType haskell nnoremap <silent> <leader>re :InteroKill<CR> :InteroOpen<CR>

"" Managing targets
"" Prompts you to enter targets (no silent):
"au FileType haskell nnoremap <leader>st :InteroSetTargets<CR>

au FileType haskell nnoremap <silent> <leader>his :HsimportSymbol<CR>
au FileType haskell nnoremap <silent> <leader>him :HsimportModule<CR>
"
" Disable haskell-vim omnifunc
"let g:haskellmode_completion_ghc = 0

" neco-ghc
"autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc 
"let g:necoghc_enable_detailed_browse = 1
let g:ale_linters ={
      \   'haskell': ['hlint', 'hdevtools', 'brittany'],
      \}

"let g:necoghc_enable_detailed_browse = 1
let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2

let g:neomake_open_list = 2
let g:neomake_haskell_enabled_makers = []


let g:deoplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
let g:SuperTabClosePreviewOnPopupClose = 1

let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie-wrapper'],
    \ }


nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> <leader>t :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <A-=> :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader><F2> :call LanguageClient#textDocument_rename()<CR>

function! MakeSession()
        let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
        if (filewritable(b:sessiondir) != 2)
                exe 'silent !mkdir -p ' b:sessiondir
                redraw!
        endif
        let b:filename = b:sessiondir . '/session.vim'
        exe "mksession! " . b:filename
endfunction

function! LoadSession()
        let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
        let b:sessionfile = b:sessiondir . "/session.vim"
        if (filereadable(b:sessionfile))
                exe 'source ' b:sessionfile
        else
                echo "No session loaded."
        endif
endfunction
" au VimEnter * nested :call LoadSession()
au VimLeave * :call MakeSession()

nmap <silent> <F3> :NERDTreeToggle<CR>

let mapleader = " "
inoremap <C-space> <C-x><C-o>
:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q
:command! R Require!

let g:acp_enableAtStartup = 0

"scala

"autocmd BufWritePost *.scala :EnTypeCheck

let g:syntastic_scala_checkers=['scalastyle']
let g:loaded_syntastic_scala_scalastyle_checker = 1
"let g:syntastic_scala_scalastyle_jar = '~/Apps/scalastyle_2.10-0.7.0-batch.jar'

function! SaveAndRunVimdeck()
   :write
   :!vimdeck generate %:t
 endfunction


nmap <silent> <F7> :call SaveAndRunVimdeck()<CR><CR>

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

nmap <silent> <leader><TAB> :Denite buffer<CR>

au FileType clojure nmap <silent> cpR :Require!<CR>
au FileType clojure nmap <silent> <leader>R :Require!<CR>
au FileType clojure nmap <silent> <leader><f9> :!lein run<CR>
au FileType clojure nmap <silent> <Leader>q :ccl<CR>

au FileType scala nmap gd :EnDeclaration<CR>
au FileType scala nmap <Esc>= :EnInspectType<CR>
au FileType scala nmap <Esc><CR> :EnSuggestImport<CR>
au FileType scala nmap <Leader>m :EnFormatSource<CR>

"nmap <Leader>, :set filetype=scala<CR>

"au filetype scala nmap <Leader>m :%!java -jar /home/octav/cli-assembly-0.1.7.jar -f -q +compactControlReadability +alignParameters +alignSingleLineCaseStatements +doubleIndentClassDeclaration +preserveDanglingCloseParenthesis +rewriteArrowSymbols +preserveSpaceBeforeArguments --stdin --stdout <CR>
nmap <silent> <Leader><Space> :CtrlP<CR>
nmap <silent> <Leader>n :CtrlP<CR>


if !exists('g:neocomplcache_force_omni_patterns')
        let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.java = '\k\.\k*'

"end scala

"haskell
"let g:ycm_semantic_triggers = {'haskell' : ['.'], 'elm':['.']}


let g:syntastic_auto_loc_list=1
nmap <F12> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

"end haskell

color dracula
color solarized
if has("gui_running") 
  set background=dark
  set guifont=Monaco\ 10
else 
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif 

let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
let g:fuf_ignoreCase = 1

let g:ctrlp_map = '<c-N>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = {
                        \ 'types': {
                        \ 1: ['.git', 'cd %s && git ls-files'],
                        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                        \ },
                        \ 'fallback': 'find %s/.. -type f'
                        \ }
let g:ctrlp_custom_ignore = {
                        \ 'dir': '\.git$\|\.dist-buildwrapper$\|\.settings$',
                        \ 'file': '\.o$\|\.so$\|\.class|\.hi$' }
let g:NERDTreeChDirMode=2

noremap <Leader>f :Ag <C-R><C-W><CR>

"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
let g:rbpt_colorpairs = [
    \ ['magenta',     'purple1'],
    \ ['cyan',        'magenta1'],
    \ ['green',       'slateblue1'],
    \ ['yellow',      'cyan1'],
    \ ['red',         'springgreen1'],
    \ ['magenta',     'green1'],
    \ ['cyan',        'greenyellow'],
    \ ['green',       'yellow1'],
    \ ['yellow',      'orange1'],
    \ ]
let g:rbpt_max = 9

if has("gui_running")
  set lines=80 columns=99
else
  " This is console Vim.
  "if exists("+lines")
    "set lines=50
  "endif
  "if exists("+columns")
    "set columns=100
  "endif
endif

let g:jsx_ext_required = 0

autocmd BufLeave,FocusLost * silent! wall

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:elm_syntastic_show_warnings = 1
"let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0
nmap <silent> <Leader>q :lclose<CR>:pclose<CR>

au FileType elm nmap <silent> <Leader>t :ElmShowDocs<CR>
au FileType elm nmap <silent> <Leader>c :ElmMake<CR>
au FileType elm nmap <silent> <Leader>l :ElmMakeMain<CR>
au FileType elm nmap <silent> <Leader>e :ElmErrorDetail<CR>
au FileType elm nmap <silent> <Leader>d :ElmBrowseDocs<CR>
au FileType elm nmap <silent> <Leader>re :ElmRepl<CR>
au FileType elm nmap <silent> <C-A-l> :ElmFormat<CR>

au FileType purescript nmap <leader>t :PSCIDEtype<CR>
au FileType purescript nmap <leader>s :PSCIDEapplySuggestion<CR>
au FileType purescript nmap <leader>a :PSCIDEaddTypeAnnotation<CR>
au FileType purescript nmap <leader>im :PSCIDEimportIdentifier<CR>
au FileType purescript nmap <leader>r :PSCIDEload<CR>
au FileType purescript nmap <leader>p :PSCIDEpursuit<CR>
au FileType purescript nmap <leader>c :PSCIDEcaseSplit<CR>
au FileType purescript nmap <leader>qd :PSCIDEremoveImportQualifications<CR>
au FileType purescript nmap <leader>qa :PSCIDEaddImportQualifications<CR>
au FileType purescript nmap gd :PSCIDEgoToDefinition<CR>

let g:netrw_liststyle=3
let g:netrw_winsize=20

let g:psc_ide_syntastic_mode = 1
let g:LargeFile = 2
let ensime_server_v2=1

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
set timeoutlen=500
set number
set ruler
set magic
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set ma
set mouse=a
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
"set smartcase
set ignorecase
set smarttab
set smartindent
set autoindent
set t_Co=256
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*.hi,*.o
set autowrite
set undodir=/tmp/undo//
set backupdir=~/tmp/.backup//
set directory=~/tmp/.swp//
"set nobackup
"set noswapfile

set guioptions-=T
set guioptions-=r
set guioptions-=L
set statusline=%n\ %F\ %m%r\%=%c-%l/%L
set iskeyword-=!-~][)(
set iskeyword-=.
set iskeyword-='
set iskeyword-="
set iskeyword-=,
set iskeyword-=|
set termguicolors
