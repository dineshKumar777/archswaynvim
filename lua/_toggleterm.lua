vim.api.nvim_set_keymap("n", "<f9>", ":ToggleTermOpenAll<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<f10>", ":ToggleTermCloseAll<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("t", "<f10>", "<C-\\><C-n>:ToggleTermCloseAll<CR>", {noremap = true, silent = true})

require("toggleterm").setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-t>]],
  hide_numbers = true,
  start_in_insert = false,
  insert_mappings = true,
  persist_size = false,
  direction = "horizontal",
  close_on_exit = true,
  shell = vim.o.shell
}
