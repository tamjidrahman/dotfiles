return {
	"sainnhe/gruvbox-material",
	priority = 1000, -- ensure this runs first
	config = function()
		vim.cmd("colorscheme gruvbox-material")

		-- set transparent background
		vim.cmd([[
      highlight Normal guibg=none
      highlight NormalNC guibg=none
      highlight NvimTreeNormal guibg=none
      highlight NvimTreeNormalNC guibg=none
      highlight NonText guibg=none
      highlight Normal ctermbg=none
      highlight NormalNC ctermbg=none
      highlight NonText ctermbg=none
      highlight NvimTreeEndOfBuffer guibg=none
    ]])
	end,
}
