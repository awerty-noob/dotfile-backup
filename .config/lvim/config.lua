-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.clipboard = unnamedplus
vim.opt.relativenumber = true

lvim.plugins = {
  {
    "ggandor/leap.nvim",
    name = "leap",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_general_viewer = 'okular'
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = '-xelatex'
      }
      vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
      vim.g.vimtex_quickfix_enabled = 1
      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_quickfix_mode = 0
    end,
  }
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "latexindent", filetypes = { "tex" } },
}
