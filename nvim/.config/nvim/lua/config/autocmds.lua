-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

-- Refresh incline colors when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		-- Force reload incline with new colors
		require("incline").setup({
			highlight = {
				groups = {
					InclineNormal = { guibg = "NONE", guifg = "NONE" },
					InclineNormalNC = { guifg = "NONE", guibg = "NONE" },
				},
			},
		})
		-- Reinitialize with correct colors
		local color_util = require("util.colors")
		local colors = color_util.get_incline_colors()
		vim.api.nvim_set_hl(0, "InclineNormal", { bg = colors.bg, fg = colors.fg })
		vim.api.nvim_set_hl(0, "InclineNormalNC", { fg = colors.fg_nc, bg = colors.bg_nc })
	end,
})
