" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|
"
" Author: @wurahara

" =====================================================================================================================
"                                    Automatic Installation of vim-plug and Plugins
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

" =====================================================================================================================
"                                            Install Plugins via vim-plug
" =====================================================================================================================

call plug#begin('~/.vim/plugged')

  Plug 'morhetz/gruvbox'                                              " color schemes
  Plug 'vim-airline/vim-airline'                                      " status and tabline
  Plug 'neoclide/coc.nvim', {'branch': 'release'}                     " language server CoC, using relase branch
  Plug 'rhysd/vim-healthcheck'

call plug#end()

" =====================================================================================================================
"                                                Color Theme Settings
" =====================================================================================================================

let g:gruvbox_contrast_dark = 'medium'
set bg=dark
colorscheme gruvbox

" =====================================================================================================================
"                                                   Editor Settings
" =====================================================================================================================

set nu				                                                        " line numbers
set ruler			                                                        " bottom info
set nobackup
set nowritebackup
set noswapfile
set autoindent                                                        " automatic indent
set tabstop=2                                                         " 4 spaces for tab
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set smartindent
set hlsearch                                                          " searching highlight
set incsearch                                                         " intelligent instant searching
set cc=120                                                            " color column at 120
set clipboard=unnamed
set clipboard=unnamedplus
set cursorline                                                        " current line highlight
set encoding=utf-8
set mouse=a                                                           " allow mouse clicking
set relativenumber
set cmdheight=2                                                       " give more space for display messages
set wildmenu
set backspace=indent,eol,start
set ignorecase
set smartcase
set hidden                                                            " TextEdit might fail if hidden is not set
set signcolumn=yes

" =====================================================================================================================
"                                          Vim Airline Tabline and Status
" =====================================================================================================================

let g:airline#extensions#tabline#enabled = 1

" =====================================================================================================================
"                                                   Netrw Settings
" =====================================================================================================================

let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25

" =====================================================================================================================
"                                                CoC Language Server
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
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
