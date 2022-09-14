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
set autoread
set guifont=Consolas:h17
set ffs=dos
set cursorline
au FocusGained,BufEnter * :checktime

set updatetime=50

set colorcolumn=80
au BufRead,BufNewFile *.md setlocal textwidth=80

highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin()
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
call plug#end()

colorscheme gruvbox
let mapleader = " "

nnoremap <Leader>= :vertical resize +5<CR> 
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

" Feature: git push set upstream remap
nnoremap<silent> <Leader>gpsu :call GitPushUpsOrgBranch()<CR>

" Feature: refresh vim env
nnoremap<silent> <Leader><C-r> :source $MYVIMRC<CR>

let s:fontsize = 17
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  execute ":set guifont=Consolas:h" . s:fontsize
endfunction

" Feature: change font size
nnoremap <A-=> :call AdjustFontSize(1)<CR>
nnoremap <A--> :call AdjustFontSize(-1)<CR>

" Feature: change tabs
nnoremap <C-Tab> :tabn<CR>
nnoremap <S-Tab> :tabp<CR>
 
" Feature: copy, paste from clipboard
" copy in visual mode
vnoremap <C-c>y "+y<CR> 
" paste in normal mode
nnoremap <C-c>p "+p<CR>
" paste in insert mode
inoremap <C-c>p <C-r>+

nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fw <cmd>lua require('telescope.builtin').live_grep()<cr>

function! BuildProject()
  " clear redirection buffer
  let pwd = getcwd(0)
  if pwd ==? 'W:\gamedev\quantm'
    let buf_nr = bufnr('build.log')
    if buf_nr != -1
      execute ":".buf_nr."bd"
    endif
    execute ":redir! > build\\build.log"
    execute ":silent !code\\build.bat"
    execute ":redir END"
    execute ":rightbelow sview build\\build.log" 
  endif
endfunction

nnoremap <A-m> :call BuildProject()<cr>
" NOTES
" Jump between files(buffers)
" => Ctrl-^
