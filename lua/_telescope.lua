local utils = require("telescope.utils")
local builtin = require("telescope.builtin")
local _telescope = require("telescope")
local M = {}

_telescope.setup {
  defaults = {
    file_ignore_patterns = {"plugged", "node_modules"}
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case"
    }
  }
}

_telescope.load_extension("fzf")

M.project_files = function()
  local _, ret, _ =
    utils.get_os_command_output(
    {
      "git",
      "rev-parse",
      "--is-inside-work-tree"
    }
  )
  local gopts = {}
  gopts.prompt_title = "Git Files"
  gopts.prompt_prefix = " -> "
  if ret == 0 then
    builtin.git_files(gopts)
  else
    builtin.find_files()
  end
end

vim.api.nvim_set_keymap("n", "<leader>;", ":Telescope oldfiles<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>b", ":Telescope buffers<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap(
  "n",
  "<leader>f",
  ":lua require('_telescope').project_files()<CR>",
  {noremap = true, silent = true}
)
vim.api.nvim_set_keymap("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<CR>", {noremap = true, silent = true})

return M
