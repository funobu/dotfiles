local eslint_config_files = {
  ".eslintrc",
  ".eslintrc.json",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.yaml",
  ".eslintrc.yml",
  ".eslintrc.ts",
  ".eslintrc.mjs",
  "eslint.config.js",
  "eslint.config.cjs",
  "eslint.config.mjs",
  "eslint.config.ts",
}

local function has_eslint_config(ctx)
  return vim.fs.find(eslint_config_files, { path = ctx.dirname, upward = true })[1] ~= nil
end

local function find_node_bin(bin, startpath)
  local path = vim.fs.dirname(startpath)
  if not path or path == "" then
    path = vim.fn.getcwd()
  end
  local found = vim.fs.find("node_modules/.bin/" .. bin, {
    upward = true,
    path = path,
    type = "file",
  })[1]
  return found
end

local function resolve_eslint_command()
  local buf = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(buf)
  local local_bin = filename ~= "" and find_node_bin("eslint", filename)
  if local_bin then
    return local_bin, {}
  end
  if vim.fn.executable("pnpm") == 1 then
    return "pnpm", { "exec", "eslint" }
  end
  if vim.fn.executable("yarn") == 1 then
    return "yarn", { "eslint" }
  end
  if vim.fn.executable("npm") == 1 then
    return "npx", { "eslint" }
  end
  return "eslint", {}
end

local function eslint_cmd()
  local cmd = resolve_eslint_command()
  return cmd[1]
end

local function eslint_args()
  local cmd = resolve_eslint_command()
  local bufname = vim.api.nvim_buf_get_name(0)
  local base_args = { "--format", "json", "--stdin", "--stdin-filename", bufname }
  local args = {}
  vim.list_extend(args, cmd[2])
  vim.list_extend(args, base_args)
  return args
end

return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local formatters_by_ft = { go = { "gofmt" } }
      local prettier_fts = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
        "astro",
        "json",
        "jsonc",
        "yaml",
        "css",
        "scss",
        "less",
        "html",
        "markdown",
        "markdown.mdx",
      }
      for _, ft in ipairs(prettier_fts) do
        formatters_by_ft[ft] = { "prettier" }
      end
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, formatters_by_ft)
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local linters_by_ft = {
        javascript = { "eslint" },
        javascriptreact = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        vue = { "eslint" },
        svelte = { "eslint" },
        astro = { "eslint" },
        json = { "eslint" },
        jsonc = { "eslint" },
        go = { "golangcilint" },
      }
      opts.linters_by_ft = vim.tbl_deep_extend("force", opts.linters_by_ft or {}, linters_by_ft)
      opts.linters = vim.tbl_deep_extend("force", opts.linters or {}, {
        eslint = {
          condition = has_eslint_config,
          cmd = eslint_cmd,
          args = eslint_args,
        },
        golangcilint = {
          condition = function()
            return vim.fn.executable("golangci-lint") == 1
          end,
        },
      })
    end,
  },
}
