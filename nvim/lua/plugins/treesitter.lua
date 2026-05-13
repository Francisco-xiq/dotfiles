return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  lazy = false, -- Garante que carregue direto na inicialização
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    require("nvim-treesitter.install").prefer_git = true
  end,
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "lua",
      "python",
      "terraform",
      "markdown",
      "yaml",
    },
    auto_install = true,
  },
}
