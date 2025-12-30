return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        gopls = {},
        rust_analyzer = {},
        tsserver = {},
        lua_ls = {},
        yamlls = {},
        jsonls = {},
        dockerls = {},
        bufls = {},
        taplo = {},
        oxlint = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "rust-analyzer",
        "typescript-language-server",
        "lua-language-server",
        "yaml-language-server",
        "json-lsp",
        "dockerfile-language-server",
        "buf",
        "taplo",
        "eslint",
        "prettier",
        "golangci-lint",
      },
    },
  },
}
