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
call neomake#configure#automake('n')

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
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#show_call_signatures = "2"

"deoplete
let g:deoplete#enable_at_startup = 1

" deoplete-jedi
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
set splitbelow
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><CR> pumvisible() ? "\<C-Y>" : "<CR>"

" airline
let g:airline_theme='gruvbox'

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
set background=light

set colorcolumn=73,101

set number

autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

" Cursorline color
" Gruvbox light
autocmd InsertEnter * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=223 guifg=NONE guibg=#ebdbb2
" Gruvbox Dark
" autocmd InsertEnter * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=223 guifg=NONE guibg=#ebdbb2

" Cursor
" highlight Cursor guifg=white guibg=black
autocmd ColorScheme * set guicursor=

syntax on
