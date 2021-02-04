autocmd FileType json syntax match Comment +\/\/.\+$+

set nocompatible | filetype indent plugin on | syn off
set hidden
set autoread
au CursorHold * checktime

call plug#begin()
"ui stuff
Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'
"Plug 'ervandew/supertab'
Plug 'codcodog/simplebuffer.vim'
Plug 'arcticicestudio/nord-vim'

"colors
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nanotech/jellybeans.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/vim-solarized8'
Plug 'tpope/vim-surround'
Plug 'romgrk/github-light.vim'

"general text productivity 
Plug 'vim-scripts/SyntaxRange'
Plug 'vim-scripts/LargeFile'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'
Plug 'godlygeek/tabular'
"Plug 'tmsvg/pear-tree'
Plug 'justinmk/vim-sneak'
Plug 'dyng/ctrlsf.vim'
Plug 'ojroques/vim-oscyank'

"programming productivity
Plug 'tomtom/tcomment_vim'
Plug 'kassio/neoterm'
Plug 'luochen1990/rainbow'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-rooter'
Plug 'pechorin/any-jump.vim'
Plug 'tpope/vim-dadbod'

"languages
"scala
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scalameta/nvim-metals'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'gfanto/fzf-lsp.nvim'
"haskell
"Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }
"Plug 'ndmitchell/ghcid', { 'for' : 'haskell', 'rtp': 'plugins/nvim' }

"reasonml
Plug 'reasonml-editor/vim-reason-plus'

call plug#end()

"autocmd BufLeave,FocusLost * silent! wall
"copy text to + register using OSC
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | OSCYankReg + | endif

let g:rainbow_active = 1
let g:sneak#label = 1
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'
let g:SuperTabClosePreviewOnPopupClose = 1
let g:pear_tree_repeatable_expand = 0
"
" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

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
set textwidth=120
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

set directory=$HOME/.vim/swapfiles//
set undodir=$HOME/.vim/tmp//
set backupdir=$HOME/.vim/backup//
set undofile
set undolevels=1000
set undoreload=10000
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

" nnoremap <leader>F :AnyJump<CR>
" xnoremap <leader>F :AnyJumpVisual<CR>

nmap     <leader>f <Plug>CtrlSFCwordPath<CR>
vmap     <leader>F <Plug>CtrlSFVwordPath
vmap     <leader>r <Plug>CtrlSFVwordExec

"nnoremap <leader>fo :CtrlSFOpen<CR>
"nnoremap <leader>ft :CtrlSFToggle<CR>

map <silent> <Down> :cn<CR>
map <silent> <Up> :cp<CR>
nmap <leader>en :cn<CR>
nmap <leader>ep :cn<CR>

"maintain selection when indenting
vnoremap < <gv
vnoremap > >gv
"replace the hovered word
"nnoremap <leader>r :%s/\<<C-r>=expand('<cword>')<CR>\>/
"delete without adding to register
nnoremap <Leader>D "_D
nnoremap <Leader>C "_C
nnoremap <Leader>c "_c
nnoremap <Leader>x "_x
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

nnoremap <leader>T :tabnew<CR>
nnoremap <leader>H :tabprevious<CR>
nnoremap <leader>L :tabnext<CR>

"ui
nmap <silent><Leader>1 :NERDTreeToggleVCS<CR>
nmap <silent><Leader>S :NERDTreeFind<CR>
nmap <silent> <Leader>q :lclose<CR>:pclose<CR>:cclose<CR>
nmap <silent> <Leader>Q :bd<CR>
nmap <silent> <Leader>n :FZF<CR>
nmap <silent> <leader>b :SimpleBufferToggle<CR>

nnoremap <silent> <leader><tab> :bnext<CR>:call SyncTree()<CR>
nnoremap <silent> <leader><s-tab> :bprev<CR>:call SyncTree()<CR>
nnoremap <silent> <F2> :NERDTreeToggle<cr><c-w>l:call SyncTree()<cr><c-w>h

nnoremap <C-x> :bdelete<CR>
nnoremap <C-A-x> :bdelete!<CR>
let g:focuscolour = 1
colorscheme nord


function! ToggleFocusColor()
  if (g:focuscolour)
    set background=dark
    let g:focuscolour = 0
  else
    set background=light
    let g:focuscolour = 1
  endif
endfunc

call ToggleFocusColor()

nmap <leader>` :call ToggleFocusColor()<CR>

nmap <silent> <leader>fz :FZF<CR>
nmap <silent> <c-N> :FZF<CR>


"productivity
"noremap <Leader>F :Ack <C-R><C-W><CR>
nmap <silent> <Leader><Space> <C-^>
nmap <silent> <C-A> :e $MYVIMRC<CR>
"inoremap <C-space> <C-x><C-o>
noremap <silent> <Leader>h :Startify <CR>
nnoremap Q gq

"scala

vmap <Leader>t% :Tabularize /%\{1,2} <CR>
vmap <Leader>t= :Tabularize /=\{1,2} <CR>
vmap <Leader>t, :Tabularize /=\{1} <CR>
vmap <Leader>ts :Tabularize /\s\+ <CR>

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

"au FileType scala call SetCocOptions()

set shortmess-=F

"nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

function SetCocOptions()
  :cd %:h | cd `git rev-parse --show-toplevel`
  set updatetime=300
  set cmdheight=1
  set shortmess+=c
  set signcolumn=yes
  set completeopt=longest,menuone

  autocmd CursorHold * silent call CocActionAsync('highlight')
  inoremap <silent><expr> <c-space> coc#refresh()
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  inoremap <expr> <C-n> pumvisible() ? '<C-n>' : \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
  inoremap <expr> <M-,> pumvisible() ? '<C-n>' : \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif


  " Use `[c` and `]c` for navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Remap for do codeAction of current line
  nmap <leader>ac <Plug>(coc-codeaction)

  " Remap for do action format
  nnoremap <silent> F :call CocAction('format')<CR>

  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  " Highlight symbol under cursor on CursorHold
  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

  " Show all diagnostics
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Find symbol of current document
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

  " Notify coc.nvim that <enter> has been pressed.
  " Currently used for the formatOnType feature.
" Toggle panel with Tree Views
  nnoremap <silent> <space>2 :<C-u>CocCommand metals.tvp<CR>
  " Toggle Tree View 'metalsPackages'
  nnoremap <silent> <space>tp :<C-u>CocCommand metals.tvp metalsPackages<CR>
  " Toggle Tree View 'metalsCompile'
  nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
  " Toggle Tree View 'metalsBuild'
  nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
  " Reveal current current class (trait or object) in Tree View 'metalsPackages'
  nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR
endfunction

nnoremap <C-left> :call NextColor(-1)<CR>
nnoremap <C-right> :call NextColor(1)<CR>
nnoremap <C-up> :call NextColor(0)<CR>

nnoremap <C-down> :SetColors all<CR>
nnoremap <A-down> :SetColors all<CR>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

set colorcolumn=100

"=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" These are example settings to use with nvim-metals and the nvim built in
" LSP.  Be sure to thoroughly read the the help docs to get an idea of what
" everything does.
"
" The below configuration also makes use of the following plugin
" - https://github.com/nvim-lua/completion-nvim
"=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

"-----------------------------------------------------------------------------
" nvim-lsp Mappings
"-----------------------------------------------------------------------------
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gds         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> <leader>ws   <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ws  <cmd>lua require'metals'.worksheet_hover()<CR>
nnoremap <silent> <leader>a   <cmd>lua require'metals'.open_all_diagnostics()<CR>
nnoremap <silent> <space>d    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> [c          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ]c          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>

"-----------------------------------------------------------------------------
" nvim-lsp Settings
"-----------------------------------------------------------------------------

"-----------------------------------------------------------------------------
" nvim-metals setup with a few additions such as nvim-completions
"-----------------------------------------------------------------------------
:lua << EOF
  metals_config = require'metals'.bare_config
  metals_config.settings = {
     showImplicitArguments = true,
     excludedPackages = {
       "akka.actor.typed.javadsl",
       "com.github.swagger.akka.javadsl"
     }
  }

  metals_config.on_attach = function()
    require'completion'.on_attach();
  end

  metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = '',
      }
    }
  )
EOF

if has('nvim-0.5')
  augroup lsp
    au!
    au FileType scala,sbt lua require('metals').initialize_or_attach(metals_config)
  augroup end
endif

"-----------------------------------------------------------------------------
" completion-nvim settings
"-----------------------------------------------------------------------------
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <silent> <c-space> <Plug>(completion_trigger)

let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp']},
    \{'complete_items': ['buffers']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

let g:completion_auto_change_source = 1

nnoremap <leader>s :WorkspaceSymbols 
"-----------------------------------------------------------------------------
" Helpful general settings
"-----------------------------------------------------------------------------

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Ensure autocmd works for Filetype
set shortmess-=F
