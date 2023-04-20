" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|
"
" Author: @wurahara

" =====================================================================================================================
" Automatic Installation of Vim-plug and Plugins
" =====================================================================================================================

" Automatic installation of vim-plug if not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . data_dir .
              \'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" ======================================================================================================================
" Plugin Registration
" ======================================================================================================================

call plug#begin('~/.vim/plugged')

  Plug 'morhetz/gruvbox'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}                     " language server CoC, using relase branch
  Plug 'rhysd/vim-healthcheck'

call plug#end()

" ======================================================================================================================
" Basic Settings
" ======================================================================================================================

" string and file encoding for current buffer
set encoding=utf-8
set fileencodings=utf-8

" minimal number of lines to keep above/below the cursor
set scrolloff=8
set sidescrolloff=8

" show line numbers and relative numbers
set number
set relativenumber

" highlight the current line
set cursorline

" draw the signcolumn, `yes` means always
set signcolumn=yes

" highlight column
set colorcolumn=120

" number of spaces that a <Tab> counts for while editing
set tabstop=2
set softtabstop=2

" round indents to multiple of `shiftwidth`
set shiftround
set shiftwidth=2

" use the appropriate number of spaces to insert a <Tab>
set expandtab
set smarttab

" copy indents from current line when starting a new line
"
set autoindent
set smartindent

" ignore case in search patterns
" but override `ignorecase` when search pattern containing uppercase characters
set ignorecase
set smartcase

" cancel the highlighting of matched search patterns
" show the pattern as it was typed so far, incremental searching
set nohlsearch
set incsearch

" number of lines for command line interface
set cmdheight=2

" not wrap lines even if longer than the width of window
set nowrap

" allow keys move cursor left/right to move to the prev/next line
set whichwrap=<,>,[,]

" a buffer becomes hidden when it is abandoned
set hidden

" enable mouse control, `a` means support all modes
set mouse=a

" cancel backup files and swap files for the buffer
set nobackup
set nowritebackup
set noswapfile

" swap file written to disk if nothing is typed in 300 ms
" mapped sequence to complete waiting in 800 ms
set updatetime=300
set timeoutlen=800

" splitted window below/right
set splitbelow
set splitright

" options for INSERT mode completion:
set completeopt=menu,menuone,noselect,noinsert

" enable 24-bit RGB color in the terminal UI (TUI)
set termguicolors

" command-line completion operates in enhanced mode
set wildmenu

" maximum number of items shown in the popups
set pumheight=10

" always show the tabline
set showtabline=2

" cancel the display of modes, since we will use plugins
set noshowmode

" allow system clipboards
set clipboard=unnamed
set clipboard=unnamedplus

" backspace in INSERT mode
set backspace=indent,eol,start

" background accent
set background=dark

" =====================================================================================================================
" Other Settings
" =====================================================================================================================

" Leader Key Remapping
let g:mapleader = "\<space>"

" =====================================================================================================================
" Shortcuts and Key Bindings
" =====================================================================================================================

" NORMAL & VISUAL: baby step (10 lines) and giant step (30 lines) scroll
noremap <silent> <C-j> 10j
noremap <silent> <C-k> 10k
noremap <silent> <C-d> 30j
noremap <silent> <C-u> 30k

" NORMAL & VISUAL: swap `$` and `g_`, jump to tail without space
noremap <silent> $ g_
noremap <silent> g_ $

" NORMAL: set wrappings
nnoremap <silent><expr> j v:count==0 ? 'gj' : 'j'
nnoremap <silent><expr> k v:count==0 ? 'gk' : 'k'

" VISUAL: code indenting
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" VISUAL: move and text selection
vnoremap <silent> J :move '>+1<CR>gv-gv
vnoremap <silent> K :move '<-2<CR>gv-gv

" VISUAL: copy
vnoremap <silent> p _dp

" NORMAL & VISUAL: magic searching
noremap / /\v

" NORMAL: cancel default `s` for window splitting
nnoremap <silent> s ''

" NORMAL: set `sv` and `sh` for window splitting vertically and horizontally
nnoremap <silent> sh :sp<CR>
nnoremap <silent> sv :vsp<CR>

" NORMAL: close current/other window(s)
nnoremap <silent> sc <C-w>c
nnoremap <silent> so <C-w>o

" NORMAL: switch between windows using <leader>
nnoremap <silent> <leader>h <C-w>h
nnoremap <silent> <leader>l <C-w>l
nnoremap <silent> <leader>k <C-w>k
nnoremap <silent> <leader>j <C-w>j

" NORMAL: window resize in baby step
nnoremap <silent> <C-Left> :vertical resize -2<CR>
nnoremap <silent> <C-right> :vertical resize +2<CR>
nnoremap <silent> <C-Down> :resize -2<CR>
nnoremap <silent> <C-Up> :resize +2<CR>

" NORMAL: window resize in giant step
nnoremap <silent> s, :vertical resize -10<CR>
nnoremap <silent> s. :vertical resize +10<CR>
nnoremap <silent> sj :resize -10<CR>
nnoremap <silent> sk : resize +10<CR>

" NORMAL: window resize default
nnoremap <silent> s= <C-W>=

" NORMAL: split window for terminals
nnoremap <silent> <leader>th :term ++close<CR>
nnoremap <silent> <leader>tv :vert term ++close<CR>

" TERMINAL: <Esc> for back to NORMAL mode in terminals
tnoremap <silent> <Esc> <C-\><C-n>

" TERMINAL: ??
tnoremap <silent> <leader>h <C-\><C-N><C-w>h
tnoremap <silent> <leader>l <C-\><C-N><C-w>l
tnoremap <silent> <leader>j <C-\><C-N><C-w>j
tnoremap <silent> <leader>k <C-\><C-N><C-w>k

" =====================================================================================================================
" Color Theme & Tabline
" =====================================================================================================================

colorscheme gruvbox
let g:airline_theme = 'gruvbox'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'default'

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" =====================================================================================================================
" Netrw Settings
" =====================================================================================================================

let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25

" =====================================================================================================================
" CoC Language Server
" =====================================================================================================================

" coc language server extensions
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-highlight',
      \ 'coc-vimlsp'
      \ ]

" use <TAB> to trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" use <S-TAB> to iterate candidate backward
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" use <CR> to auto-select the first completion item and notify coc.nvim to
" format on enter. Thus <cr> can be remapped by other vim plugins
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" use `[g` and `]g` to navigate diagnostics
" use `:CocDiagnostics` to get all diagnostics of current buffer
nmap <silent> [g <Plug>(coc-diagnostics-prev)
nmap <silent> ]g <Plug>(coc-diagnostics-next)

" GoTo code navication
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedKeys('K', 'in')
  endif
endfunction

" highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" format selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" apply codeAction to the selected region
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" remap keys for applying codeAction to the current buffer
nmap <leader>ac <Plug>(coc-codeaction)
" apply AutoFix to problem on the current line
nmap <leader>qf <Plug>(coc-fix-current)
" run the Code Lens action on the current line
nmap <leader>cl <Plug>(coc-codelens-action)

" map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" remap <C-f> and <C-b> for scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" sse <C-s> for selections ranges
" NOTE: requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')
" add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" add vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" mappings for CoCList
" show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" do default action for next item
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" do default action for previous item
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
