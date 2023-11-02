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
        use("neovim/nvim-lspconfig")
	use("ggandor/leap.nvim")
        use("hrsh7th/nvim-cmp")
        use("hrsh7th/cmp-nvim-lsp")
        use("saadparwaiz1/cmp_luasnip")
        use("L3MON4D3/LuaSnip")
end)

--plugin config
---- themer - lsp and treesitter compatible colorschemes
--
---- use :SCROLLCOLOR to preview the available themes
require("themer").setup({
    colorscheme="jellybeans"
    ---styles={
    ---    comment = {fg = "#707D97"},
    ---    string = {fg = "#89A571"},
    ---    ["function"] = {fg = "#88C0D0"}
    ---}
})

---- lsp setup
---- available servers and configurations:
---- https://github.com/neovim/nvim-lspconfig/blob/044388b0d437c2f266d69231421e99b1598cc39c/doc/server_configurations.md
--require('lspconfig').pyright.setup({})
local lspconfig = require('lspconfig')
pylsp_settings = {
    pylsp = {
        plugins = {
            pycodestyle = {
                maxLineLength = 100
            }
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

---- luasnip
local luasnip = require('luasnip')

---- nvim-cmp
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
  },
}

---- ctrlp
vim.g.ctrlp_custom_ignore = 'git'

---- lualine
require("lualine").setup({})

---- treesitter
require('nvim-treesitter.configs').setup({
    ensure_installed = { 'python', 'html', 'javascript', 'hcl', 'css' },
    sync_install = false,
    highlight = {
        enable = true
    }
})

---- leap
require('leap').set_default_keymaps()

--mappings
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
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>E', vim.diagnostic.goto_next)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
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



---- lsp
--vim.keymap.set("n", "<leader>E", "<cmd>lua vim.diagnostic.goto_next()<CR>", {noremap=true, silent=true})
--vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {noremap=true, silent=true})
--vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap=true, silent=true})
--vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", {noremap=true, silent=true})
--vim.keymap.set("n", "<leader>gD", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap=true, silent=true})
--vim.keymap.set("n", "<leader>gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap=true, silent=true})
--vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap=true, silent=true})
--vim.keymap.set("n", "<leader>qq", ":cclose<cr>", {noremap=true, silent=true})


--options
---- indentation
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

---- line numbers
vim.opt.number = true

---- colors
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
