# nvim

Nvim config using lazy.nvim

## Install

The `install-nvim.sh` script will grab the nightly nvim appimage
and put it in /usr/local/bin

## nvim config

Basic settings:
- use termguicolors
- use darkmode
- add colour columns at 73, 101
- set space as leader key
- <leader>h to turn off highlighting (`:noh`)
- set up indentation
    - 4 spaces, except 2 for html, css, js and HCL
- enable line numbers
- turn on cursor line in insert mode
- turn on spellcheck for text files

Plugins/fancy settings:
- Using themercorp for colorschemes
- Set up LSP using Mason
    - We use `mason-tool-installer` so we can script the installs in the config file
    - Autoconfigure LSP servers with mason-lspconfig
- Supermaven
    - Pretty decent AI autocompletion
- nvim-cmp
    - LSP and completion
    - Basic keybindings + format on save
- fzf-lua
    - fuzzy finder, replacing CtrlP for me
    - search for files in current dir, recent files, current buffers, live grep code, 
      some git stuff, pretty cool
- treesitter
    - installed everything, maybe I'll open a verilog file or some shit one day
