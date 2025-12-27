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
  init = function() end,
  opts = {
    default_file_explorer = true,
  },
}
