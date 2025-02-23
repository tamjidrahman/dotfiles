return {version=12,pkgs={{source="lazy",dir="/Users/tamjid/.local/share/nvim/lazy/noice.nvim",name="noice.nvim",spec=function()
return {
  -- nui.nvim can be lazy loaded
  { "MunifTanjim/nui.nvim", lazy = true },
  {
    "folke/noice.nvim",
  },
}

end,file="lazy.lua",},{source="lazy",dir="/Users/tamjid/.local/share/nvim/lazy/plenary.nvim",name="plenary.nvim",spec={"nvim-lua/plenary.nvim",lazy=true,},file="community",},{source="rockspec",dir="/Users/tamjid/.local/share/nvim/lazy/telescope.nvim",name="telescope.nvim",spec={"telescope.nvim",build=false,specs={{"nvim-lua/plenary.nvim",lazy=true,},},},file="telescope.nvim-scm-1.rockspec",},},}