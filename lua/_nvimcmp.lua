vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.pumheight = 10

local cmp = require("cmp")

-- attach to lsp
require("cmp_nvim_lsp").setup()
for index, value in ipairs(vim.lsp.protocol.CompletionItemKind) do
  cmp.lsp.CompletionItemKind[index] = value
end

cmp.setup {
  snippet = {
    expand = function(args)
      -- You must install `vim-vsnip` if you use the following as-is.
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  -- You must set mapping if you want.
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm(
      {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true
      }
    ),
    -- TODO
    -- when tab binding enabled for both vsnip and cmp it causes nvim freeze when combined with tabout
    ["<Tab>"] = function(fallback)
      --[[ if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n") ]]
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"]() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "")
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      --[[ if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n") ]]
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#available"]() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "")
      else
        fallback()
      end
    end
  },
  -- You should specify your *installed* sources.
  sources = {
    {name = "nvim_lsp"},
    {name = "nvim_lua"},
    {name = "path"},
    {name = "vsnip"}
  },
  experimental = {
    ghost_text = false
  }
}

-- autopairs integration
require("nvim-autopairs.completion.cmp").setup(
  {
    map_cr = true, --  map <CR> on insert mode
    map_complete = false -- it will auto insert `(` after select function or method item
  }
)
