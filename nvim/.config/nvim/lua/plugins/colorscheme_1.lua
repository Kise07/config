return {
	{
		"catppuccin/nvim",
		name = "catppuccin", -- important for lazy.nvim
		lazy = false, -- load immediately (colorscheme should not be lazy)
		priority = 1000,
		opts = function()
			return {
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				transparent_background = true,
			}
		end,
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
