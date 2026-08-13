-- In your plugins.lua file (or equivalent)
return {
  {
    "webhooked/oscura.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("oscura").setup({ transparent_bg = true })
      vim.cmd.colorscheme("oscura")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oscura",
    },
  },
}
