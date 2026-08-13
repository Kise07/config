return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>y", "<cmd>Yazi<cr>", desc = "Open yazi (file manager)" },
  },
  opts = {
    open_for_directories = false,
  },
}
