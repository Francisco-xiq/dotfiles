return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true
            },
            view = {
                side = "left",
                width = {
                    min = 30,    -- A largura nunca será menor que 30 colunas
                    max = 60,    -- Limita o crescimento automático para não engolir a tela
                    padding = 1, -- Dá 1 caractere de respiro no final do nome do arquivo
                },
            },
            renderer = {
                group_empty = true,
            },
        })

        -- Atalho: <Espaço> + e para abrir/fechar a árvore
        vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true, desc = "Toggle Explorer" })
    end
}
