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
au BufRead,BufNewFile *.md setlocal textwidth=80

highlight ColorColumn ctermbg=0 guibg=lightgrey
colorscheme default

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'zivyangll/git-blame.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'djoshea/vim-autoread'
call plug#end()

colorscheme gruvbox
let g:javascript_plugin_jsdoc = 1
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-python']
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
nmap <leader>jd <Plug>(coc-definition)
nmap <leader>jy <Plug>(coc-type-definition)
nmap <leader>ji <Plug>(coc-implementation)
nmap <leader>jr <Plug>(coc-references)

" -- vim fugitive key mappings
"  get commit from right window
nmap <leader>gk :diffget //3<CR>
" get commit from left window
nmap <leader>gj :diffget //2<CR>
" git status
nmap <leader>gs :G<CR>
" git blame
nnoremap <Leader>gb :<C-u>call gitblame#echo()<CR>

"------------------"
"-------FZF--------"
"------------------"
nnoremap <leader>f :Rg<CR>
nnoremap <C-p> :Files<CR>
noremap <C-f> :Lines<CR>
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

