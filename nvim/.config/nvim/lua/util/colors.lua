-- Detect current colorscheme and return appropriate colors
local M = {}

function M.get_incline_colors()
	local colorscheme = vim.g.colors_name or "catppuccin"

	if colorscheme == "solarized-osaka" then
		-- Solarized-osaka colors
		local colors = require("solarized-osaka.colors").setup()
		return {
			bg = colors.magenta500,
			fg = colors.base04,
			bg_nc = colors.base03,
			fg_nc = colors.violet500,
		}
	else
		-- Catppuccin (default)
		local colors = require("catppuccin.palettes").get_palette("mocha")
		return {
			bg = colors.mauve,
			fg = colors.crust,
			bg_nc = colors.mantle,
			fg_nc = colors.lavender,
		}
	end
end

return M
