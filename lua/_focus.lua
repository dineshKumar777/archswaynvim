require("focus").setup(
  {
    winhighlight = true
  }
)

vim.api.nvim_set_keymap("n", "<c-l>", ":FocusSplitNicely<CR>", {silent = true})
vim.cmd("hi link UnfocusedWindow CursorLine")
vim.cmd("hi link FocusedWindow VisualNOS")
