" nvim python hosts
let g:python_host_prog=$HOME.'/.venvs/nvim27/bin/python'
let g:python3_host_prog=$HOME.'/.venvs/nvim37/bin/python'

" plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'lifepillar/vim-solarized8'
call plug#end()

" coc.nvim
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" browse suggestions with tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" enter confirms completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" '[g' ']g' to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use K to show docs
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" rename
nmap <leader>rn <Plug>(coc-rename)

" status line
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" tabs
set expandtab
set shiftwidth=4
set softtabstop=4

" colors
set termguicolors
hi ColorColumn ctermbg=0 guibg=lightgrey
set colorcolumn=72,100
set hlsearch
hi Search ctermbg=DarkYellow ctermfg=White

set number

syntax on
