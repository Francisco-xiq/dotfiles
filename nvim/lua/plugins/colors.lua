return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- Garante que o tema carregue logo na inicialização
    priority = 1000, -- Dá prioridade máxima ao tema
    opts = {
      transparent = true, -- <--- A mágica acontece aqui!
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        theme = 'tokyonight',
      }
    }
  },
}
