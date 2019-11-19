au BufRead,BufNewFile *.sbt set filetype=scala
autocmd FileType json syntax match Comment +\/\/.\+$+

set nocompatible | filetype indent plugin on | syn off
set hidden

call plug#begin()
"ui stuff
Plug 'scrooloose/nerdtree'
Plug 'semanticart/simple-menu.vim'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'
Plug 'vimlab/split-term.vim'
Plug 'ervandew/supertab'

"colors
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/vim-solarized8'

"general text productivity 
Plug 'vim-scripts/SyntaxRange'
Plug 'vim-scripts/LargeFile'
Plug 'justinmk/vim-sneak'
Plug 'rking/ag.vim'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'


"programming productivity
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'kassio/neoterm'
Plug 'luochen1990/rainbow'

"languages
"scala
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

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

"autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd BufLeave,FocusLost * silent! wall

set completeopt=noinsert,menuone,noselect
let g:rainbow_active = 1
let g:sneak#label = 1
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
let g:SuperTabClosePreviewOnPopupClose = 1

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
"end scala


"end haskell

if exists("g:gnvim") 
  set guifont=Iosevka\ Nerd\ Font\ Mono:h12
  "set guifont=Operator\ Mono\ Lig\ Semi-Light:h12
  set lines=999 columns=999
else 
  "let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  "let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif 

let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
let g:fuf_ignoreCase = 1

let g:NERDTreeChDirMode=2

let g:jsx_ext_required = 0
let g:fzf_history_dir = '~/.local/share/fzf-history'
 "let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'down': '~20%' }

let g:netrw_liststyle=3
let g:netrw_winsize=20

"let g:psc_ide_syntastic_mode = 1
let g:LargeFile = 2

"airline settings
let g:airline_section_a = ''
let g:airline_section_y = ''
let g:airline#extensions#tabline#enabled = 0
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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*.hi,*.o
set autowrite
set splitright
set splitbelow

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
tnoremap <C-h> <C-\><C-n><C-h>
tnoremap <C-j> <C-\><C-n><C-j>
tnoremap <C-k> <C-\><C-n><C-k>
tnoremap <C-l> <C-\><C-n><C-l>

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
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
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
nmap <silent><M-1> :NERDTreeToggle<CR>
nmap <silent> <Leader>q :lclose<CR>:pclose<CR>:cclose<CR>
nmap <silent> <Leader>n :FZF<CR>
nmap <silent> <leader>b :Buffers<CR>
nnoremap <leader><TAB> :bnext<CR>
nnoremap <leader><S-tab> :bprevious<CR>
nnoremap <C-X> :bdelete<CR>
let g:focuscolour = 1

function! ToggleFocusColor()
  if (g:focuscolour)
    colorscheme ancient
    let g:focuscolour = 0
  else
    colorscheme dracula
    let g:focuscolour = 1
  endif
endfunc

call ToggleFocusColor()

"Set F6 to toggle, switch colorscheme
nmap <leader>` :call ToggleFocusColor()<CR>

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


"coc settings
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

au FileType reason,scala,rust,haskell call SetCocOptions()


nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

function SetCocOptions()
  set updatetime=300
  set cmdheight=2
  set shortmess+=c
  set signcolumn=yes

  autocmd CursorHold * silent call CocActionAsync('highlight')
  inoremap <silent><expr> <c-space> coc#refresh()
  "noremap <expr> <TAB>
    "\ pumvisible() ? "\<C-n>" :
    "\ <SID>check_back_space() ? "\<TAB>" :
    "\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  xmap <silent><leader>as  <Plug>(coc-codeaction-selected)
  nmap <silent><leader>as  <Plug>(coc-codeaction-selected)
  nmap <silent><leader>af  <Plug>(coc-fix-current)
  xmap <silent><leader>afi <Plug>(coc-funcobj-i)
  xmap <silent><leader>afa <Plug>(coc-funcobj-a)
  omap <silent><leader>afi <Plug>(coc-funcobj-i)
  omap <silent><leader>afa <Plug>(coc-funcobj-a)
  nmap <silent><leader>aa <Plug>(coc-codeaction)

  nmap <silent> <leader>ap <Plug>(coc-diagnostic-prev)
  nmap <silent> <leader>an <Plug>(coc-diagnostic-next)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> <leader>at <Plug>(coc-type-definition)
  nmap <silent> <leader>ai <Plug>(coc-implementation)
  nmap <silent> <leader>ar <Plug>(coc-references)
  nnoremap <silent> <leader>af :call CocAction('format')<CR>
  nnoremap <silent> <leader>ad :call <SID>show_documentation()<CR>
  nmap <leader>ar <Plug>(coc-rename)
  " Show all diagnostics
  nnoremap <silent> <space>ag  :<C-u>CocList diagnostics<cr>
  " Find symbol of current document
  nnoremap <silent> <space>ao  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <space>ay  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>aj  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>ak  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <space>ap  :<C-u>CocListResume<CR>
  nnoremap <silent> <space>am  :<C-u>CocList commands<CR>
endfunction

nnoremap <C-left> :call NextColor(-1)<CR>
nnoremap <C-right> :call NextColor(1)<CR>
nnoremap <C-up> :call NextColor(0)<CR>

nnoremap <C-down> :SetColors all<CR>
function! s:find_project_root()
  let nerd_root = g:NERDTree.ForCurrentTab().getRoot().path.str()
  let git_root = system('git -C '.shellescape(nerd_root).' rev-parse --show-toplevel 2> /dev/null')[:-2]
  if strlen(git_root)
    return git_root
  endif
  return nerd_root
endfunction
command! ProjectFiles execute 'Files' s:find_project_root()
