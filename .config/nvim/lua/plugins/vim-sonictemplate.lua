-- Based on: https://github.com/ryoppippi/dotfiles/blob/main/nvim/lua/plugin/vim-sonictemplate.lua

return {
  "mattn/vim-sonictemplate",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "tmp", "Template", mode = "ca" },
  },
  init = function()
    vim.g.sonictemplate_key = 0
    vim.g.sonictemplate_intelligent_key = 0
    vim.g.sonictemplate_postfix_key = 0
  end,
  config = function()
    local Path = require("plenary.path")
    vim.g.sonictemplate_vim_template_dir = {
      Path:new(vim.fn.stdpath("config"), "template"):absolute(),
    }
  end,
}
