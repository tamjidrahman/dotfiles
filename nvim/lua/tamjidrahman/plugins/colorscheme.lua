return {
  "folke/tokyonight.nvim",
  priority = 1000, -- ensure this runs first
  config = function ()
    vim.cmd("colorscheme tokyonight")

    require("tokyonight").setup({
      style = "night",
    })
  end
}
