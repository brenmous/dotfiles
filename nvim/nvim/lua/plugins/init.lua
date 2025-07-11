function merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
    return t1
end

return {
    {
        "themercorp/themer.lua",
        lazy=false,
        priority=1000,
        opts = {
            colorscheme = "jellybeans"
        }
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {ensure_installed={}},
        dependencies = {
            {"mason-org/mason.nvim", opts={}},
            "neovim/nvim-lspconfig"
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "bashls",
                "shfmt",
                "shellcheck",
                "denols",
                "cssls",
                "hclfmt",
                "html",
                "jsonls",
                "prettier",
                "pyright",
                "ruff",
                "terraform-ls"
            }
        }
    },
    {
        "supermaven-inc/supermaven-nvim",
        opts = {
            use_free_version = true,
            disable_inline_completion = true
        }
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(event)
                  local opts = {buffer = event.buf}
                  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
                  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
                  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
                  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                  vim.keymap.set('n', '<leader>f', "<cmd>lua vim.lsp.buf.format { async=true }<cr>", opts)
                  vim.api.nvim_create_autocmd('BufWritePre', {
                    callback = function()
                      vim.lsp.buf.format { async = false, buffer = event.buf }
                    end,
                  })
                  end,
            })

            local cmp = require("cmp")
            cmp.setup {
                sources = {
                    { name = "nvim_lsp" },
                    { name = "supermaven" }
                },
                completion = {
                    completeopt = "menu,menuone,noinsert"
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behvior = cmp.ConfirmBehavior.insert,    
                        select = true
                    }),
                    ["<C-a>"] = cmp.mapping.abort()
                }),
            }
        end
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        keys = {
            { "<leader>pf", "<cmd>lua require('fzf-lua').files()<cr>" },
            { "<leader>pg", "<cmd>lua require('fzf-lua').live_grep()<cr>" },
            { "<leader>pr", "<cmd>lua require('fzf-lua').oldfiles()<cr>" },
            { "<leader>pb", "<cmd>lua require('fzf-lua').buffers()<cr>" },
            { "<leader>pgc", "<cmd>lua require('fzf-lua').git_commits()<cr>" },
            { "<leader>pgl", "<cmd>lua require('fzf-lua').git_blame()<cr>" },
            { "<leader>pgb", "<cmd>lua require('fzf-lua').git_branches()<cr>" },
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                -- ensure_installed = "all", -- make your laptop loud as fuck with this one simple trick!
                -- seriously, work laptop can't get through the install, and treesitter starts from scratch if it fails
                ensure_installed = {"python", "lua", "markdown", "html", "css", "javascript", "bash"},
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true } 
            }
        end
    },
}
