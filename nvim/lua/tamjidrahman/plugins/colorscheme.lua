return {
	"sainnhe/gruvbox-material",
	priority = 1000, -- ensure this runs first
	config = function()
		vim.cmd("colorscheme gruvbox-material")
	end,
}
