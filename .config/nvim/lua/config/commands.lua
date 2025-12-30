-- NeoVim の configファイルを開くコマンド
vim.api.nvim_create_user_command("Config", function()
  vim.cmd.e(vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "NeoVim の configファイルを開く" })

-- dotfiles の configファイルを開くコマンド
vim.api.nvim_create_user_command("Dotfiles", function()
  -- oilで dotfiles ディレクトリを開く
  vim.cmd.Oil(vim.fn.expand("~/dotfiles"))
end, { desc = "dotfiles の configファイルを開く" })
