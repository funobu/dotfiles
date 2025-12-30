-- Based on: https://github.com/ryoppippi/dotfiles/blob/main/nvim/lua/plugin/vim-sonictemplate.lua

return {
  "mattn/vim-sonictemplate",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "Template" },
  keys = {
    { "tmp", "Template", mode = "ca" },
  },
  init = function()
    vim.g.sonictemplate_key = 0
    vim.g.sonictemplate_intelligent_key = 0
    vim.g.sonictemplate_postfix_key = 0
  end,
  config = function()
    -- template の保存場所を変更
    local Path = require("plenary.path")
    local template_path = Path:new(vim.fn.stdpath("config"), "templates")
    vim.g.sonictemplate_template_dir = template_path:absolute()
  end,
}
