-- Install using :TSInstall {lang}

require("nvim-treesitter.configs").setup {
  ensure_installed = {"typescript", "lua"},
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  autopairs = {
    enable = true
  }
}
