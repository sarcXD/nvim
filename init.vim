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
set cmdheight=1

set updatetime=50

set colorcolumn=80
au BufRead,BufNewFile *.md setlocal textwidth=80

highlight ColorColumn ctermbg=0 guibg=lightgrey
colorscheme default

"function! CheckForFolder(folder)
"  let searchStr = 'find '.a:folder.' -maxdepth 3 | '
"  let fout = execute()

let ftFrontend= 'typescript,javascript,html,css' 
let ftBackendNode= 'javascript,typescript'
let ftBackendPy= 'python'
let ftFullStackCurr=ftFrontend.",".ftBackendPy
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'https://github.com/morhetz/gruvbox.git'
Plugin 'preservim/nerdtree'
autocmd FileType ftFullStackCurr execute \
      \ Plugin 'neoclide/coc.nvim', {'branch': 'release'}
autocmd FileType javascript execute \
      \ Plugin 'pangloss/vim-javascript' " for javascript only
autocmd FileType typscript execute \
      \ Plugin 'leafgarland/typescript-vim' " for typescript only
autocmd FileType ftFrontend execute Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
autocmd FileType ftFullStackCurr execute \
      \ Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
autocmd FileType ftFullStackCurr execute Plugin 'junegunn/fzf.vim'
Plugin 'djoshea/vim-autoread' " autoupdate files
Plugin 'https://github.com/szw/vim-maximizer.git' " window maximizer for vim
" Plug 'puremourning/vimspector' " #TODO Setup vimspector debugging for vim
call vundle#end()

" Selectively bundling plugins based on filetype

colorscheme gruvbox
let g:javascript_plugin_jsdoc = 1
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-pyright']
let mapleader = " "

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
nnoremap <Leader>gb :Git blame<CR>
" git switch to develop
nnoremap <Leader>gcd :Git checkout develop<CR>
" git switch to master
nnoremap <Leader>gcm :Git checkout master<CR>
" git checkout to existing branch
nnoremap <Leader>gce :Git checkout 
" git create and checkout branch, and have user type branch_name
nnoremap <Leader>gcb :Git checkout -b 

" Custom function for creating Confirmation Box
function! ConfirmBox(msg)
  let result = confirm(a:msg, "&Yes\n&No")
  return result
endfunction

" For new branch
" gets branch name
" sets upstream origin automatically
function! GitPushUpsOrgBranch()
  let branch = system("git branch --show-current")
  let push_str = "git push --set-upstream origin ".branch
  let conf_msg = "Do you want to execute\n".push_str
  let conf_res = ConfirmBox(conf_msg)
  if conf_res == 1
    let push_str_out = system(push_str)
    echo push_str_out
  endif
  return 1
endfunction

" git push set upstream remap
nnoremap<silent> <Leader>gpsu :call GitPushUpsOrgBranch()<CR>

" refresh vim env
nnoremap<silent> <C-r><C-s> :source $MYVIMRC<CR>

"------------------"
"-------FZF--------"
"------------------"
nnoremap <leader>f :Rg <CR>
nnoremap <C-p> :Files<CR>
noremap <C-f> :Lines<CR>
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

"---------Vim Maximizer-------"
nnoremap <leader>mx :MaximizerToggle<CR>
