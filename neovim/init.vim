"s nvim python hosts
let g:python_host_prog=$HOME.'/.venvs/nvim27/bin/python'
let g:python3_host_prog=$HOME.'/.venvs/nvim37/bin/python'

" plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', {'do': 'UpdateRemotePlugins'}
Plug 'zchee/deoplete-jedi'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'
Plug 'neomake/neomake'
Plug 'tmhedberg/SimpylFold'
call plug#end()

" folding
set nofoldenable

" neomake
" let g:neomake_python_enabled_makers = ['pylint', 'mypy']
let g:neomake_python_enabled_makers = ['mypy']

function! NextError()                                                                  
  try                                                                                     
    lnext                                                                                 
  catch                                                                                   
    try | lfirst | catch | endtry                                                         
  endtry                                                                                  
endfunction                                                                               

nnoremap <leader>e :call NextError()<cr>
nnoremap <leader>E :lprev<cr>

" jedi
let g:jedi#completeions_enabled = 0
let g:jedi#use_splits_not_buffers="right"

"deoplete
let g:deoplete#enable_at_startup = 1

" deoplete-jedi
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
set splitbelow
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" airline
let g:airline_theme='molokai'



" my binds
" insert timestamp with F5
nnoremap <F5> "=strftime("%d-%m-%Y %T %Z")<CR>P
inoremap <F5> <C-R>=strftime("%d-%m-%Y %T %Z")<CR>

" tabs
set expandtab
set shiftwidth=4
set softtabstop=4

" colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

colorscheme gruvbox

set colorcolumn=73,101

set number

set cursorline
autocmd InsertEnter * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=234 guifg=NONE guibg=#1d1d1d
autocmd InsertLeave * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=237 guifg=NONE guibg=#3c3836

syntax on
