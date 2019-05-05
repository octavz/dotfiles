au BufRead,BufNewFile *.sbt set filetype=scala

set nocompatible | filetype indent plugin on | syn off

call plug#begin()
"ui stuff
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'semanticart/simple-menu.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'pseewald/nerdtree-tagbar-combined'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'equalsraf/neovim-gui-shim'

"autocomplete
Plug 'ncm2/ncm2' | Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-vim' | Plug 'Shougo/neco-vim'
Plug 'ncm2/ncm2-neoinclude' | Plug 'Shougo/neoinclude.vim'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tagprefix'
Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'

"colors
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/vim-solarized8'

"general text productivity 
Plug 'ervandew/supertab'
Plug 'vim-scripts/SyntaxRange'
Plug 'vim-scripts/LargeFile'
Plug 'justinmk/vim-sneak'
Plug 'rking/ag.vim'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'

"programming productivity
"Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', 'for': ['fhsarp','javascript','python','reason', 'haskell' ] }
"Plug 'natebosch/vim-lsc', { 'for': ['scala'] }
Plug 'scrooloose/nerdcommenter'
"Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'kien/rainbow_parentheses.vim'
Plug 'mattn/emmet-vim'
Plug 'vim-latex/vim-latex'
Plug 'liuchengxu/vista.vim'

"languages
"scala
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
"Plug 'scrooloose/syntastic', { 'for': ['scala'] }
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
au BufRead,BufNewFile *.sbt set filetype=scala

"elixir
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
"javascript
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
"elm
Plug 'elmcast/elm-vim'
"purescript
Plug 'frigoeu/psc-ide-vim', { 'for': 'purescript'}
Plug 'raichoo/purescript-vim', { 'for': 'purescript'}

"haskell
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'ndmitchell/ghcid', { 'for' : 'haskell', 'rtp': 'plugins/nvim' }

"clojure
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'tpope/vim-classpath', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"fsharp
Plug 'fsharp/vim-fsharp', {
      \ 'for': 'fsharp',
      \ 'do':  'make fsautocomplete',
      \}
"reasonml
Plug 'reasonml-editor/vim-reason-plus'
"others
Plug 'gabrielelana/vim-markdown'

call plug#end()

autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd BufLeave,FocusLost * silent! wall
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

set completeopt=noinsert,menuone,noselect

let g:sneak#label = 1
let g:ale_linters ={
      \   'haskell': ['hie','hlint', 'brittany'],
      \}
let g:ale_fixers = {'haskell': ['brittany']}
let g:ale_haskell_hie_executable='hie-wrapper'
let g:ale_reason_ols_executable='reason-language-server.exe'
let g:ale_fix_on_save = 1

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

"let g:LanguageClient_loggingLevel = 'INFO'
"let g:LanguageClient_loadSettings = 0
let g:LanguageClient_loggingFile =  expand('/tmp/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('/tmp/LanguageServer.log')

"let g:deoplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
let g:SuperTabClosePreviewOnPopupClose = 1

let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie-wrapper', '-l', '/tmp/hie.log'],
    \ 'reason': ['/home/ozaharia/bin/reason-language-server.exe'],
    \ 'javascript': ['/home/ozaharia/node_modules/.bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/home/ozaharia/.local/bin/pyls'],
    \ 'clojure': ['/home/ozaharia/bin/clojure-lsp'],
    \ 'fsharp': ['dotnet', '/home/ozaharia/tmp/fsharp-language-server/src/FSharpLanguageServer/bin/Release/netcoreapp2.0/target/FSharpLanguageServer.dll'],
    \ }


:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q
:command! R Require!
:command! C e $MYVIMRC
:command! S source %

let g:acp_enableAtStartup = 0

"scala
let g:syntastic_scala_checkers=['scalastyle']
let g:loaded_syntastic_scala_scalastyle_checker = 1
let g:syntastic_auto_loc_list=1
"let g:syntastic_scala_scalastyle_jar = '~/Apps/scalastyle_2.10-0.7.0-batch.jar'
"end scala

let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'ctagsbin'    : 'stags',
    \ 'sro'       : '.',
    \ 'kinds'     : [
      \ 'p:packages',
      \ 'T:types:1',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:case objects',
      \ 'c:classes',
      \ 'C:case classes',
      \ 'm:methods',
      \ 'V:values:1',
      \ 'v:variables:1'
    \ ]
\ }

"haskell
let g:tagbar_type_haskell = {
    \ 'ctagsbin'    : 'hasktags',
    \ 'ctagsargs'   : '-x -c -o-',
    \ 'kinds'       : [
        \  'm:modules:0:1',
        \  'd:data:0:1',
        \  'd_gadt:data gadt:0:1',
        \  'nt:newtype:0:1',
        \  'c:classes:0:1',
        \  'i:instances:0:1',
        \  'cons:constructors:0:1',
        \  'c_gadt:constructor gadt:0:1',
        \  'c_a:constructor accessors:1:1',
        \  't:type names:0:1',
        \  'pt:pattern types:0:1',
        \  'pi:pattern implementations:0:1',
        \  'ft:function types:0:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'          : '.',
    \ 'kind2scope'   : {
        \ 'm'        : 'module',
        \ 'd'        : 'data',
        \ 'd_gadt'   : 'd_gadt',
        \ 'c_gadt'   : 'c_gadt',
        \ 'nt'       : 'newtype',
        \ 'cons'     : 'cons',
        \ 'c_a'      : 'accessor',
        \ 'c'        : 'class',
        \ 'i'        : 'instance'
    \ },
    \ 'scope2kind'   : {
        \ 'module'   : 'm',
        \ 'data'     : 'd',
        \ 'newtype'  : 'nt',
        \ 'cons'     : 'c_a',
        \ 'd_gadt'   : 'c_gadt',
        \ 'class'    : 'ft',
        \ 'instance' : 'ft'
    \ }
\ }

"end haskell

if exists("g:gnvim") 
  set guifont=Ubuntu\ Mono:h16
  "set guifont=Operator\ Mono\ Lig\ Semi-Light:h12
  set lines=999 columns=999
else 
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif 

let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
let g:fuf_ignoreCase = 1

let g:tagbar_autofocus = 1
let g:NERDTreeChDirMode=2

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

let g:jsx_ext_required = 0

let g:fzf_history_dir = '~/.local/share/fzf-history'
 "let g:fzf_layout = { 'window': 'enew' }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

let g:elm_syntastic_show_warnings = 1
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0
let g:netrw_liststyle=3
let g:netrw_winsize=20

"let g:psc_ide_syntastic_mode = 1
let g:LargeFile = 2

"airline settings
let g:airline_section_a = ''
let g:airline_section_y = ''
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1

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
set ignorecase
set smartcase
set smarttab
set smartindent
set autoindent
set t_Co=256
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*.hi,*.o
set autowrite

"set directory=~/tmp/.swp//
set nobackup
set noswapfile

set guioptions-=T
set guioptions-=r
set guioptions-=L
"set statusline=%n\ %F\ %m%r\%=%c-%l/%L
set iskeyword-=!-~][)(
set iskeyword-=.
set iskeyword-='
set iskeyword-="
set iskeyword-=,
set iskeyword-=|
set termguicolors

let mapleader = " "

"movement
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
nmap <silent> <leader>k :wincmd k<CR>
nmap <silent> <leader>j :wincmd j<CR>
nmap <silent> <leader>h :wincmd h<CR>
nmap <silent> <leader>l :wincmd l<CR>

map <silent> <Down> :cn<CR>
map <silent> <Up> :cp<CR>
nmap <leader>en :cn<CR>
nmap <leader>ep :cn<CR>

"maintain selection when indenting
vnoremap < <gv
vnoremap > >gv
"replace the hovered word
nnoremap <leader>r :%s/\<<C-r>=expand('<cword>')<CR>\>/
"delete without adding to register
nnoremap <Leader>D "_D
nnoremap <Leader>C "_C
nnoremap <Leader>c "_c
nnoremap <Leader>x "_x
" Move to the previous buffer
nnoremap H :bprevious<CR>
" Move to the next buffer
nnoremap L :bnext<CR>

" Replace H and L
nnoremap zh H
nnoremap zl L
" AND/OR
nnoremap + H
nnoremap - L

"ui
nmap <silent><M-1> :ToggleNERDTreeAndTagbar<CR>
nmap <silent><M-2> :TagbarToggle<CR>
nmap <silent><M-3> :NERDTreeToggle<CR>
nmap <silent> <Leader>q :lclose<CR>:pclose<CR>:cclose<CR>
nmap <silent> <Leader>n :FZF<CR>
nmap <silent> <leader>b :Buffers<CR>
nmap <silent> <leader>gs :GFiles?<CR>
nnoremap <leader><TAB> :bnext<CR>
nnoremap <leader><S-tab> :bprevious<CR>
nnoremap <C-X> :bdelete<CR>
let g:focuscolour = 1

function! ToggleFocusColor()
  if (g:focuscolour)
    colorscheme base16-solarized-light
    set background=light
    let g:focuscolour = 0
  else
    colorscheme dracula
    set background=dark
    let g:focuscolour = 1
  endif
endfunc

call ToggleFocusColor()

"Set F6 to toggle
nmap <leader>c :call ToggleFocusColor()<CR>

nmap <silent> <leader>fz :FZF<CR>
nmap <silent> <c-N> :FZF<CR>


"productivity
noremap <Leader>f :Ag <C-R><C-W><CR>
nmap <silent> <Leader><Space> :bnext<CR>
nmap <silent> <C-A> :e $MYVIMRC<CR>
inoremap <C-space> <C-x><C-o>
noremap <silent> <Leader>h :Startify <CR>
nnoremap Q gq

"scala
"au filetype scala nmap <Leader>m :%!java -jar /home/octav/cli-assembly-0.1.7.jar -f -q +compactControlReadability +alignParameters +alignSingleLineCaseStatements +doubleIndentClassDeclaration +preserveDanglingCloseParenthesis +rewriteArrowSymbols +preserveSpaceBeforeArguments --stdin --stdout <CR>

vmap <Leader>% :Tabularize /%\{1,2} <CR>
vmap <Leader>= :Tabularize /=\{1,2} <CR>
vmap <Leader>, :Tabularize /=\{1} <CR>
vmap <Leader>s :Tabularize /\s\+ <CR>

"elm
au FileType elm nmap <silent> <Leader>t :ElmShowDocs<CR>
au FileType elm nmap <silent> <Leader>c :ElmMake<CR>
au FileType elm nmap <silent> <Leader>l :ElmMakeMain<CR>
au FileType elm nmap <silent> <Leader>e :ElmErrorDetail<CR>
au FileType elm nmap <silent> <Leader>d :ElmBrowseDocs<CR>
au FileType elm nmap <silent> <Leader>re :ElmRepl<CR>
au FileType elm nmap <silent> <C-A-l> :ElmFormat<CR>

"purescript
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

"clojure
au FileType clojure nmap <silent> cpR :Require!<CR>
au FileType clojure nmap <silent> <leader>R :Require!<CR>
au FileType clojure nmap <silent> <leader><f9> :!lein run<CR>
au FileType clojure nmap <silent> <Leader>q :ccl<CR>

"haskell
au FileType haskell nnoremap <silent> <leader>his :HsimportSymbol<CR>
au FileType haskell nnoremap <silent> <leader>him :HsimportModule<CR>
" Or map each action separately
au FileType haskell,javascript,python,fsharp,reason nnoremap <leader>t :call LanguageClient#textDocument_hover()<CR>
au FileType haskell,javascript,python,fsharp,reason nnoremap <A-=> :call LanguageClient#textDocument_hover()<CR>
au FileType haskell,javascript,python,fsharp,reason nnoremap <leader><S-t> :call LanguageClient#textDocument_typeDefinition()<CR>
au FileType haskell,javascript,python,fsharp,reason nnoremap gd :call LanguageClient#textDocument_definition()<CR>
au FileType haskell,javascript,python,fsharp,reason nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>
au FileType haskell,javascript,python,fsharp,reason nnoremap <leader>lf :call LanguageClient#textDocument_rangeFormatting()<CR>
au FileType haskell,javascript,python,fsharp,reason nnoremap <C-A-l> :call LanguageClient#textDocument_formatting()<CR>
au FileType haskell,javascript,python,fsharp,reason nnoremap <A-F7> :call LanguageClient#textDocument_references()<CR>
au FileType haskell,javascript,python,fsharp,reason nnoremap <A-CR> :call LanguageClient#textDocument_codeAction()<CR>
au FileType haskell,javascript,python,fsharp,reason nnoremap <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
au FileType haskell,javascript,python,fsharp,reason nnoremap <F5> :call LanguageClient_contextMenu()<CR>
au FileType haskell,javascript,python,fsharp,reason set formatexpr=LanguageClient_textDocument_rangeFormatting() 

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
au FileType scala,rust,haskell set updatetime=300
au FileType scala,rust,haskell set shortmess+=c
au FileType scala,rust,haskell set signcolumn=yes
au FileType scala,rust,haskell inoremap <silent><expr> <c-space> coc#refresh()
au FileType scala,rust,haskell inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
au FileType scala,rust,haskell nmap <silent> <S-F2> <Plug>(coc-diagnostic-prev)
au FileType scala,rust,haskell nmap <silent> <F2> <Plug>(coc-diagnostic-next)
au FileType scala,rust,haskell nmap <silent> gd <Plug>(coc-definition)
au FileType scala,rust,haskell nmap <silent> gy <Plug>(coc-type-definition)
au FileType scala,rust,haskell nmap <silent> gi <Plug>(coc-implementation)
au FileType scala,rust,haskell nmap <silent> gr <Plug>(coc-references)
au FileType scala,rust,haskell nmap <A-CR> <Plug>(coc-codeaction)
au FileType scala,rust,haskell nnoremap <silent> <C-A-l> :call CocAction('format')<CR>
au FileType scala,rust,haskell nnoremap <silent>K :call <SID>show_documentation()<CR>
au FileType scala,rust,haskell autocmd CursorHold * silent call CocActionAsync('highlight')
au FileType scala,rust,haskell nmap <leader>r <Plug>(coc-rename)
" Show all diagnostics
au FileType scala,rust,haskell nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
au FileType scala,rust,haskell nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
au FileType scala,rust,haskell nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
au FileType scala,rust,haskell nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
au FileType scala,rust,haskell nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
au FileType scala,rust,haskell nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
