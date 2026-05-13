return {
    -- 1. Primeiro instalamos o Mason base
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- Garante que os repositórios fiquem atualizados
        config = function()
            require("mason").setup()
        end
    },
    
    -- 2. Depois o Mason-LSPConfig, que depende do Mason
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    "clangd",
                    "bashls",
                    "terraformls",
                    "ansiblels",
                },
            })
        end
    },

    -- 3. Por último o LSPConfig em si, que depende do passo 2
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        config = function()
            local lspconfig = require("lspconfig")

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'Atalhos do LSP',
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                end,
            })

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup({})
                end,
                -- A nossa configuração especial para o clangd processar bem os scripts em C/eBPF
                ["clangd"] = function()
                    lspconfig.clangd.setup({
                        cmd = {
                            "clangd",
                            "--background-index",
                            "--clang-tidy",
                            "--header-insertion=iwyu",
                        },
                    })
                end,
            })
        end
    }
}

