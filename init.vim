syntax enable 
set relativenumber
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set termguicolors
set cmdheight=2

set updatetime=50

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
colorscheme default

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'ryanoasis/vim-devicons'
call plug#end()

colorscheme gruvbox
let g:javascript_plugin_jsdoc = 1
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']
let mapleader = " "

nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
nnoremap <Leader>+ :vertical resize +5<CR> 
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <leader>nt :NERDTree<CR>
nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>hs :split<CR>
" Use `[g` and `]g` to navigate diagnostics
nmap <leader>[g <Plug>(coc-diagnostic-prev)
nmap <leader>]g <Plug>(coc-diagnostic-next)

" " GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
