-- vim.g.neotest_runner[adapter] で追加引数やenvを上書きできるようにする
local function adapter_opts(key, defaults)
  local overridden = rawget(vim.g, "neotest_runner") or {}
  local alias = overridden[key] or overridden[key:gsub("neotest%-", "")]
  if type(alias) == "function" then
    local ok, result = pcall(alias, vim.deepcopy(defaults or {}))
    alias = ok and result or defaults
  end
  if alias == false then
    return false
  end
  if type(alias) == "table" then
    if defaults then
      return vim.tbl_deep_extend("force", defaults, alias)
    end
    return alias
  end
  return defaults
end

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
      "marilari88/neotest-vitest",
    },
    keys = {
      { "<leader>t", "", desc = "+test" },
      {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "現在のファイルをテスト",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "現在位置のテスト",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "直前のテストを再実行",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "実行中テストへアタッチ",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "テスト出力を開く",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "出力パネル切替",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "サマリー切替",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "テスト停止",
      },
    },
    opts = function()
      local adapters = {}
      local go_defaults = {
        runner = "go",
        go_test_args = { "-count=1" },
        env = {},
      }
      local vitest_defaults = {
        vitestCommand = nil,
        env = {},
      }
      adapters["neotest-golang"] = adapter_opts("neotest-golang", go_defaults)
      adapters["neotest-vitest"] = adapter_opts("neotest-vitest", vitest_defaults)
      return {
        status = { virtual_text = true },
        output = { open_on_run = false },
        adapters = adapters,
      }
    end,
    config = function(_, opts)
      local adapters = {}
      for name, adapter in pairs(opts.adapters or {}) do
        if adapter ~= false then
          local mod = require(name)
          if type(adapter) == "table" and not vim.tbl_isempty(adapter) then
            local meta = getmetatable(mod)
            if mod.setup then
              mod.setup(adapter)
            elseif meta and meta.__call then
              mod = mod(adapter)
            elseif type(mod) == "function" then
              mod = mod(adapter)
            end
          end
          adapters[#adapters + 1] = mod
        end
      end
      opts.adapters = adapters
      require("neotest").setup(opts)
    end,
  },
}
