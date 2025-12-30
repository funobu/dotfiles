-- Based on: https://github.com/ryoppippi/dotfiles/blob/main/nvim/lua/plugin/oil/init.lua
return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  cmd = "Oil",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/snacks.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Oil<CR>", desc = "Open Oil" },
    { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
  },
  init = function()
    -- oilを起動する設定
    local oilPathPatterns = { "oil://", "oil-ssh://", "oil-trash://" }
    local path = vim.fn.expand("%s:p")
    -- stylua: ignore start
    local isDir = vim.fn.isdirectory(path) == 1
    local isOilPath = vim.iter(oilPathPatterns):any(function(opp)
      return (string.find(path, opp, 1, true)) ~= nil
    end)
    if isDir or isOilPath then require("oil") end
    --stylua: igonre end

    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })
    vim.api.nvim_create_autocmd("Filetype", {
      pattern = "oil",
      callback = function(event)
        vim.b.snacks_main = true
      end
    })
  end,
  opts = function()
    return {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          local ignore_list = { ".DS_Store" }
          return vim.tbl_contains(ignore_list, name)
        end,
      },
    }
  end,
}
