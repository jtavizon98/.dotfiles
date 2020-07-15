" My .vimrc Jairo Tavizon

" Automatic Reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Sets =========================================================================

" Mouse functionality
set mouse=a

" Real programmers dont't use TABs but spaces
set tabstop=4 softtabstop=4
set expandtab
set shiftwidth=4
set shiftround

" Makin' it pretty 
syntax enable
set smartindent
set nu
set nowrap
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Undo fun
set undodir=~/.vim/undodir
set undofile

" Make search case insensitive
set ignorecase
set incsearch
set hlsearch
set smartcase

" Disable backup and swap files - they cause problems
set nobackup
set nowritebackup
set noswapfile


" Plugins ======================================================================

" Using vim-plug ---------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Dracula theme from https://draculatheme.com/
Plug 'dracula/vim',{'as':'dracula'}

" Faster grep
Plug 'jremmen/vim-ripgrep'

" man pages inside vim
Plug 'vim-utils/vim-man'

" Undo history of that file
Plug 'mbbill/undotree'

" File Explorer as expandables
Plug 'preservim/nerdtree'

" Ranger inside vim
Plug 'francoiscabrol/ranger.vim'

" Syntax highlighting for many languages
Plug 'sheerun/vim-polyglot'

" Autocompletion and linting for several languages 
Plug 'neoclide/coc.nvim', {'branch':'release'} 

" Creates automatic pairs for (, [, {
Plug 'jiangmiao/auto-pairs'

" Shows what commands can follow the mapleader key (like Emacs)
Plug 'liuchengxu/vim-which-key'

" Shows indentation lines
Plug 'Yggdroot/indentLine'

" Status bar at the bottom
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
"-------------------------------------------------------------------------------

colorscheme dracula

" Fixes issues with ripgrep
if executable('rg')
	let g:rg_derive_root='true'
endif

" Sets nerdtree to also show hidden files
let NERDTreeShowHidden=1

" Coc setup --------------------------------------------------------------------

 let g:coc_global_extensions = [
    \ 'coc-floaterm',  
    \ 'coc-python',
    \]

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

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
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Explorer
let g:coc_explorer_global_presets = {
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 30,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'right-center',
\      'floating-width': 30,
\   },
\   'simplify': {
\     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }
"nmap <silent> <space>e :CocCommand explorer<CR>
" nnoremap <silent> <leader>e :CocCommand explorer<CR>
" nmap <space>f :CocCommand explorer --preset floatingRightside<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
"-------------------------------------------------------------------------------

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif


" Keybindings ==================================================================

" Rebind <Leader> key
let mapleader = " "

" Basic navigation keybindings
nnoremap <leader>q :q<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>nt :NERDTree<CR>
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <leader>s :split<CR>
nnoremap <leader>vs :vsplit<CR>

" easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" Toggle transparent background
let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_tranparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>


