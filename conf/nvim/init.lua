--plugins
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
	use("github/copilot.vim")
        use("neovim/nvim-lspconfig")
end)

--plugin config
require("themer").setup({
    colorscheme="nord",
    styles={
        comment = {fg = "#707D97"},
        string = {fg = "#89A571"}
    }
})

require('lspconfig').pyright.setup({})

vim.g.ctrlp_custom_ignore = 'git'

require("lualine").setup({})

require('nvim-treesitter.configs').setup({
    ensure_installed = { 'python', 'html', 'javascript', 'hcl' },
    sync_install = false,
    highlight = {
        enable = true
    }
})

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

---- copilot accept
vim.keymap.set("i", "<S-tab>", "copilot#Accept('<CR>')", { silent = true, expr = true })

---- timestamp insert
vim.keymap.set("n", "<F5>", "=strftime('%Y-%m-%d %H:%M:%S')<CR>P", { noremap = true })
vim.keymap.set("i", "<F5>", "<C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR>", { noremap = true })

---- lsp
vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.goto_next()<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>w", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>gD", "<cmd>lua vim.lsp.buf.definition()<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>qq", ":cclose<cr>", {noremap=true, silent=true})


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
