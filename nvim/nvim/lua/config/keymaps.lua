-- "global" keymaps, not configured for specific plugins
-- explanation of keymap.set see: https://neovim.io/doc/user/lua.html#vim.keymap.set()

-- leader key(s)
vim.keymap.set({"n", "v"}, "<Space>", "<Nop>")
vim.g.mapleader = " "

-- unhighlight
vim.keymap.set("n", "<leader>h", ":noh<cr>", { silent = true })
