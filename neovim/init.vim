"s nvim python hosts
let g:python_host_prog=$HOME.'/.venvs/nvim2/bin/python'
let g:python3_host_prog=$HOME.'/.venvs/nvim3/bin/python'

" plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'davidhalter/jedi-vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do': 'UpdateRemotePlugins'}
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'
Plug 'neomake/neomake'
Plug 'tmhedberg/SimpylFold'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sbdchd/neoformat'
call plug#end()

" folding
set nofoldenable

" neomake
let g:neomake_python_enabled_makers = ['flake8', 'mypy']
call neomake#configure#automake('nwri', 500)

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
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#show_call_signatures = "2"

"deoplete
let g:deoplete#enable_at_startup = 1

" deoplete-jedi
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
set splitbelow
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><cr> pumvisible() ? "\<C-Y>" : "<CR>"

" airline
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

let g:ctrlp_working_path_mode = 'r'

nmap <leader>pf :CtrlP<cr>
nmap <leader>pb :CtrlPBuffer<cr>
nmap <leader>pa :CtrlPMixed<cr>
nmap <leader>pr :CtrlPMRU<cr>

" my binds
nmap <leader>h :noh<cr>

" buffers
"set hidden
"nmap <leader>T :enew<cr>
"nmap <leader>[ :bnext<cr>
"nmap <leader>] :bnext<cr>
"nmap <leader>Q :bp <BAR> bd #<cr>
"nmap <leader>tl :ls<cr>

nmap <leader>w <C-W><w>
nmap <leader>W <C-W><W>

" insert timestamp with F5
nnoremap <F5> "=strftime("%d-%m-%Y %T %Z")<CR>P
inoremap <F5> <C-R>=strftime("%d-%m-%Y %T %Z")<CR>

" tabs
set expandtab
set shiftwidth=4
set softtabstop=4
autocmd BufRead,BufNewFile *.htm,*.html,*.css setlocal tabstop=2 shiftwidth=2 softtabstop=2

" colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

colorscheme gruvbox
set background=dark

set colorcolumn=73,101

set number

autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

" Cursorline color
" Gruvbox dark
autocmd InsertEnter * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=237 guifg=NONE guibg=#3c3836
" Gruvbox light
" autocmd InsertEnter * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=223 guifg=NONE guibg=#ebdbb2

syntax on
