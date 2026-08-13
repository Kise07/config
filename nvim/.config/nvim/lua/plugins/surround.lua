return {
  "nvim-mini/mini.surround",
  event = "BufReadPost",
  opts = {
    mappings = {
      add = "sa", -- Add surrounding
      delete = "sd", -- Delete surrounding
      replace = "sr", -- Replace surrounding
      find = "", -- Disable (use / or grep instead)
      find_left = "", -- Disable
      highlight = "", -- Disable
      update_n_lines = "", -- Disable
    },
  },
}
