require("focus").setup(
  {
    winhighlight = false
  }
)

vim.api.nvim_set_keymap("n", "<c-l>", ":FocusSplitNicely<CR>", {silent = true})
vim.cmd("hi link UnfocusedWindow CursorLine")
vim.cmd("hi link FocusedWindow VisualNOS")
