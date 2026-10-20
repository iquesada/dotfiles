" vim-bootstrap b0a75e4

"*****************************************************************************
": Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
let g:plug_timeout = 300
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
" Split and join code lines
Plug 'AndrewRadev/splitjoin.vim'

" NerdTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Status line and buffer tabline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" Git
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'

" Highlight trailing whitespaces
Plug 'bronson/vim-trailing-whitespace'

" Close brackets, parenthesis, etc
Plug 'Raimondi/delimitMate'

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Test
Plug 'janko-m/vim-test'

" vimux
Plug 'benmills/vimux'

" Flosting windows
Plug 'voldikss/vim-floaterm'

" Surrondings " ' ( {
Plug 'tpope/vim-surround'

" Syntax highlighting and folding. Vim uses its bundled syntax files instead
if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'main', 'do': ':TSUpdate' }
endif

" Nerdtree icons
Plug 'ryanoasis/vim-devicons'

" Tabularize (:Tab /=)
Plug 'godlygeek/tabular'

" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" Markdown syntax, folding and concealing (requires tabular, loaded above)
Plug 'preservim/vim-markdown'

" Maximize panes
Plug 'szw/vim-maximizer'

" Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

"" Color
Plug 'NLKNguyen/papercolor-theme'

"*****************************************************************************
"" Custom bundles
"*****************************************************************************

" elixir. Neither Vim nor Neovim bundle elixir filetype/indent support
Plug 'elixir-lang/vim-elixir'

" html
Plug 'mattn/emmet-vim'

" ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"*****************************************************************************
"*****************************************************************************

"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

" Required:
filetype plugin indent on


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" NVim config
if !has('nvim')
  set ttymouse=xterm2
endif

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab

"" Map leader to ,
let mapleader="\<Space>"

"" Enable hidden buffers
set hidden

""" Give more space for displaying messages
set cmdheight=2

""" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
""" delays and poor user experience.
set updatetime=300

""" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" Search visually selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif


"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number relativenumber
augroup toggle_relative_number
  autocmd!
  autocmd InsertEnter * setlocal norelativenumber
  autocmd InsertLeave * setlocal relativenumber
augroup END

set nolazyredraw
set ttyfast
set cursorline

let no_buffers_menu=1
if !exists('g:not_finish_vimplug')
  set termguicolors
  set background=dark
  colorscheme PaperColor
endif

set mousemodel=popup
set t_Co=256
" set guioptions=egmrti
set gfn=Monospace\ 10

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    " set guifont=JetBrains_Mono_Regular:h11
    set transparency=7
  endif
else
  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif
  
endif


if &term =~ '256color'
  set t_ut=
endif


"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
" vies can only be collapsed with the global statusline
set laststatus=3

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" maximize current split or return to previous
noremap <C-w>m :MaximizerToggle<CR>

""""""""""""""""""""""""""
" Go configurations
""""""""""""""""""""""""""
"
" Function to source only if file exists {
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" run go imports on file save
let g:go_fmt_command = "goimports"

" automatically highlight variable your cursor is on
let g:go_auto_sameids = 0

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

nmap <silent> <leader>gtf :GoTestFuncEnv<CR>
nmap <silent> <leader>gta :GoTestEnv<CR>
nmap <silent> <leader>gtt :GoAlternate<CR>

:command! GoTestFuncEnv :call SourceIfExists(".env") | GoTestFunc
:command! GoTestEnv :call SourceIfExists(".env") | GoTest

""""""""""""""""""""""""""
" vim-test configuration
""""""""""""""""""""""""""
let test#filename_modifier = ":p"
let g:test#preserve_screen = 1
let test#strategy = "vimux"
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

let g:test#javascript#runner = 'jest'
let g:test#javascript#jest#file_pattern = '\v(__tests__/.*|(spec|[t|T]est))\.(js|jsx|coffee|ts|tsx)$'

""""""""""""""""""""""""""
" Floaterm configuration
""""""""""""""""""""""""""
let g:floaterm_winblend = 0
let g:floaterm_keymap_toggle = '<Leader>fn'
let g:floaterm_position = 'center'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_borderchars = ['─', '│', '─', '│', '┌', '┐', '┘', '└']
hi FloatermBorderNF guibg='#4c556a' guifg='#ABB9CF'

" lightline
set noshowmode
set showtabline=2
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': { 'left': [ [ 'buffers' ] ], 'right': [ [] ] },
      \ 'component_function': { 'gitbranch': 'FugitiveHead' },
      \ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
      \ 'component_type': { 'buffers': 'tabsel' },
      \ }
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unnamed = '[No Name]'

" Format
nnoremap <silent> <leader>ff :call CocActionAsync('format')<CR>

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
let NERDTreeShowHidden=1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

" Grep project for word under cursor
nnoremap <silent> <leader>fw :Rg <C-R><C-W><CR>

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>

" Comment lines (gc/gcc). Built in on Neovim, a bundled package on Vim
if !has('nvim')
  packadd! comment
endif

" Splitjoin
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nmap <Leader>J :SplitjoinJoin<cr>
nmap <Leader>S :SplitjoinSplit<cr>

" Markdown preview. Only non-default settings
let g:mkdp_images_path = expand("~/.markdown_images")
let g:mkdp_theme = "dark"

"*****************************************************************************
"" Functions
"*****************************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

set splitbelow
set splitright

"" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Git
let g:fugitive_gitlab_domains = ['https://gitlab.otters.xyz/']
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Git commit<CR>
noremap <Leader>gph :Git push<CR>
noremap <Leader>gpf :Git push --force<CR>
noremap <Leader>gpl :Git pull<CR>
noremap <Leader>gs :Git<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gd :Gvdiffsplit<CR>
noremap <Leader>gr :GRemove<CR>
noremap <Leader>ge :Gedit<CR>
noremap <Leader>gl :silent! Gclog<CR>:bot copen<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" Copy file path
nnoremap <Leader>yf :let @+ = expand("%:p")<CR>

"" fzf.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6 } }
set grepprg=rg\ --vimgrep

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>e :FZF -m<CR>
nnoremap <silent> <leader>E :Rg<CR>

" coc
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" coc tab completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

hi CocSearch ctermfg=12 guifg=#EBDD96
hi CocMenuSel ctermbg=109 guibg=#18A3FF

" Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location
" list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>ft  <Plug>(coc-format-selected)
nmap <leader>ft  <Plug>(coc-format-selected)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Timeout
set timeoutlen=300 ttimeoutlen=0

" Save on focus lost
autocmd BufLeave,FocusLost * silent! wall

" Save and restore view on leave and enter
if v:version >= 700
  au BufLeave * let b:winview = winsaveview()
  au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" Quickly source .vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Quickly quit editting without save
nnoremap <leader>Q :qa!<CR>

"" Open on GitLab/GitHub: current line or whole file
nnoremap <Leader>ol :.GBrowse<CR>
nnoremap <Leader>op :GBrowse<CR>

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" Foding
set foldmethod=syntax
set foldlevel=20

" Indentation guides
set list listchars=tab:┆\ ,leadmultispace:┆\ ,nbsp:␣
augroup vimrc-nolist
  autocmd!
  autocmd FileType markdown,help setlocal nolist
augroup END

" Treesitter: highlight and fold with it whenever a parser exists.
" Markdown keeps vim-markdown's folding
if has('nvim')
lua << EOF
local ok, ts = pcall(require, 'nvim-treesitter')
if ok then ts.install({
  'bash', 'c', 'cpp', 'css', 'dockerfile', 'eex', 'elixir', 'erlang', 'go',
  'gomod', 'gosum', 'hcl', 'heex', 'html', 'javascript', 'json', 'kotlin',
  'lua', 'proto', 'ruby', 'sql', 'terraform', 'tsx', 'typescript', 'vim',
  'vimdoc', 'yaml',
}) end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('vimrc-treesitter', { clear = true }),
  callback = function(args)
    if vim.bo[args.buf].filetype == 'markdown' then return end
    if pcall(vim.treesitter.start, args.buf) then
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end
  end,
})
EOF
endif

" elixir

" erlang
let erlang_folding = 1
let erlang_show_errors = 1

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab


" javascript
augroup vimrc-javascript
  autocmd!
  autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
augroup END


" ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:coc_global_extensions = ['coc-elixir']
autocmd BufRead *.xlsx.axlsx set filetype=ruby

augroup vimrc-ruby
  autocmd!
  autocmd BufNewFile,BufRead *.rb,*.rbw,*.gemspec setlocal filetype=ruby
  autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab softtabstop=2
augroup END

" Extended % matching (def/end, if/end...). Neovim loads it by default
if !has('nvim')
  packadd! matchit
endif


"*****************************************************************************
"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
