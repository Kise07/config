return {
  "vimichael/floatingtodo.nvim",
  opts = {
    target_file = "~/notes/todo.md",
    border = "rounded",
    width = 0.8,
    height = 0.8,
    position = "center",
  },
  cmd = "Td",
  keys = {
    { "<leader>td", "<cmd>Td<cr>", desc = "Todo float" },
    { "<leader>tw", "<cmd>Td<cr>Go", desc = "Todo float (quick add)" },
  },
  config = function(_, opts)
    require("floatingtodo").setup(opts)

    -- <CR> toggles the checkbox on todo lines (buffer-local to the todo file)
    local todo_file = vim.fn.expand(opts.target_file)
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = todo_file,
      callback = function(event)
        vim.keymap.set("n", "<CR>", function()
          local line = vim.api.nvim_get_current_line()
          local updated
          if line:match("^%s*- %[ %]") then
            updated = line:gsub("%[ %]", "[x]", 1)
          elseif line:match("^%s*- %[[xX]%]") then
            updated = line:gsub("%[[xX]%]", "[ ]", 1)
          end
          if updated then
            vim.api.nvim_set_current_line(updated)
          else
            -- not a checkbox line: fall back to normal <CR> (no remap = no recursion)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
          end
        end, { buffer = event.buf, silent = true, desc = "Toggle todo checkbox" })
      end,
    })
  end,
}
