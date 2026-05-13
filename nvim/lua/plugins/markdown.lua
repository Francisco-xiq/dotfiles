return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- Constrói o servidor localmente usando npm (muito mais confiável)
    build = "cd app && npm install",
    
    -- init roda ANTES do plugin carregar, preparando o terreno
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
    
    -- keys mapeia o atalho e já acorda o plugin quando você aperta
    keys = {
        { "<leader>md", "<Cmd>MarkdownPreviewToggle<CR>", desc = "Markdown Preview" },
    },
}
