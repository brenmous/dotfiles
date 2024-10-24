-- indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.api.nvim_create_autocmd({
     "BufNewFile", "BufRead"
    },{
	pattern = {"*.html*", "*.css*", "*.js*", "*.tf*"},
	command = "setlocal sw=2 sts=2"
    }
)

-- line numbers
vim.opt.number = true

-- turn on cursor line in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {command = "set cul"})
vim.api.nvim_create_autocmd("InsertLeave", {command = "set nocul"})

-- turn on spellcheck for text files
vim.api.nvim_create_autocmd({
        "BufRead", "BufNewFile"
    },{
        pattern = {"*.txt*", "*.md*", "*.rst*"},
        command = "setlocal spell spelllang=en_au"
    }
)


