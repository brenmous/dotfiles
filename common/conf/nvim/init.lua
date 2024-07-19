-- plugins
---- copied from https://github.com/Allaman/nvim
---- bootstraps packer.nvim
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({
		"git",
		"clone",
		"https://github.com/wbthomason/packer.nvim",
		install_path
	})
	vim.api.nvim_command("packadd packer.nvim")
end

local packer = require("packer")

packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use({
             "nvim-treesitter/nvim-treesitter",
	     run= {":TSUpdate"}
	})
        use("themercorp/themer.lua")
	use("nvim-lualine/lualine.nvim")
	use("ctrlpvim/ctrlp.vim")
	use("williamboman/mason.nvim")
        use("williamboman/mason-lspconfig.nvim")
        use("neovim/nvim-lspconfig")
	use("ggandor/leap.nvim")
        use("hrsh7th/nvim-cmp")
        use("hrsh7th/cmp-nvim-lsp")
        use("saadparwaiz1/cmp_luasnip")
        use("L3MON4D3/LuaSnip")
	use("supermaven-inc/supermaven-nvim")
	use("onsails/lspkind.nvim")
end)

require("supermaven-nvim").setup({
    use_free_version = true,
    disable_inline_completion = true
})

-- set python interpreter
vim.g.python3_host_prog = '/home/bren/.quickenvs/neovim/bin/python'

-- setup mason
---- Note: make sure this happens before lsp setup
require("mason").setup()
require("mason-lspconfig").setup()

-- lsp
---- Available servers and configurations:
---- https://github.com/neovim/nvim-lspconfig/blob/044388b0d437c2f266d69231421e99b1598cc39c/doc/server_configurations.md
---- When not using Mason we need to install the LSP binaries manually.
---- Using Mason, we can run :Mason.
local lspconfig = require('lspconfig')
pylsp_settings = {
    pylsp = {
        plugins = {
            pycodestyle = {
                maxLineLength = 100
            },
        }
    }
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = { 
    pylsp=pylsp_settings,
    cssls={},
    eslint={},
    html={},
    terraformls={},
    jsonls={},
    rust_analyzer={} 
}
for lsp, settings in pairs(servers) do
    lspconfig[lsp].setup {
        settings = settings,
        capabilities = capabilities
    }
end

-- luasnip
local luasnip = require('luasnip')

-- lspkind
local lspkind = require('lspkind')

-- nvim-cmp
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'supermaven' },
  },
  formatting = {
      format = lspkind.cmp_format({
        mode = "symbol",
        maxwidth = 50,
        symbol_map = { Supermaven = "" }
    })
  }
}

---- ctrlp
vim.g.ctrlp_custom_ignore = 'git'

-- lualine
require("lualine").setup({})

-- treesitter
require('nvim-treesitter.configs').setup({
    ensure_installed = { 'python', 'html', 'javascript', 'hcl', 'css' },
    sync_install = false,
    highlight = {
        enable = true
    }
})

-- leap
require('leap').set_default_keymaps()

-- mappings
---- leader
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

---- ctrlp
vim.keymap.set("n", "<leader>pa", ":CtrlP<cr>")
vim.keymap.set("n", "<leader>pb", ":CtrlPBuffer<cr>")
vim.keymap.set("n", "<leader>pr", ":CtrlPMRU<cr>")

---- unhighlight
vim.keymap.set("n", "<leader>h", ":noh<cr>")

---- timestamp insert
vim.keymap.set("n", "<F5>", "=strftime('%Y-%m-%d %H:%M:%S')<CR>P", { noremap = true })
vim.keymap.set("i", "<F5>", "<C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR>", { noremap = true })

---- lsp
vim.keymap.set('n', '<leader>e', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>E', vim.diagnostic.goto_next)
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- indentation options
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.api.nvim_create_autocmd(
    {"BufNewFile", "BufRead"},
    {
        pattern = {"*.html", "*.css", "*.js", "*.tf"},
        command = "setlocal sw=2 sts=2"
    }
)

-- line numbers
vim.opt.number = true

-- colors
---- use :SCROLLCOLOR to preview the available themes
require("themer").setup({
    colorscheme="jellybeans"
})
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.colorcolumn = "73,101"
vim.api.nvim_create_autocmd("InsertEnter", {command = "set cul"})
vim.api.nvim_create_autocmd("InsertLeave", {command = "set nocul"})
vim.api.nvim_create_autocmd(
    {"BufRead", "BufNewFile"},
    {
        pattern = {"*.txt", "*.md", "*.rst"},
        command = "setlocal spell"
    }
)
