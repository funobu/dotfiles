# Repository Guidelines

## Project Structure & Module Organization
- `.config/fish/`: fish shell 設定（`config.fish`, `fish_variables`）。
- `.config/mise/`: mise 設定（`config.toml`）。
- `.config/nvim/`: Neovim/LazyVim 設定（`init.lua`, `lua/config/*`, `lua/plugins/*`, `stylua.toml`）。
- `scripts/`: メンテ用スクリプト（例: `scripts/syncpath.sh`）。
- 追加のツール設定は `.config/<app>/` 配下に置くことを想定。
- ルートは `~/dotfiles` を前提にパスが書かれている。

## Build, Test, and Development Commands
- `bash scripts/syncpath.sh`: `~/.config/{fish,mise,nvim}` をバックアップしてシンボリックリンクを作成。
- `nvim`: Neovim を起動して設定の反映を確認。
- `fish`: fish を起動して設定の反映を確認。
- `ls -la ~/.config/fish` / `readlink ~/.config/fish`: リンク先が `~/dotfiles/.config/fish` になっているか確認。

## Coding Style & Naming Conventions
- シェル: `bash` を前提。2スペースインデント、短い日本語コメントで意図を明確に。
- Lua: `stylua.toml` に準拠（2スペース、列幅120）。
- フォーマット例: `stylua .config/nvim/lua`（導入済みなら実行可）。
- 命名: ディレクトリは小文字、設定は `.config/<app>/` に集約。

## Testing Guidelines
- 自動テストは未整備。変更後は手動で動作確認する。
- 例: `fish` 起動、`nvim` 起動、必要に応じて mise の設定読込を確認。
- 例: `nvim --headless '+checkhealth' +q` で簡易ヘルスチェックを実行。

## Commit & Pull Request Guidelines
- コミットは短く具体的に（例: “mise toml config”）。厳密な規約はなし。
- PR では変更内容、影響範囲、手動検証手順を簡潔に記載。
- 既存設定のバックアップやシンボリックリンク変更がある場合は明記。

## Configuration Workflow
- 変更はまず `~/dotfiles/.config/<app>/` に反映し、次に `bash scripts/syncpath.sh` でリンクを更新。
- バックアップは `~/.config/<app>.backup` に作成されるため、差分確認後に整理する。
- Neovim の Lua 設定は `init.lua` から `lua/config/*` と `lua/plugins/*` に分割して更新。

## Security & Configuration Tips
- 個人情報やトークンはコミットしない。
- `scripts/syncpath.sh` は `~/.config` を変更するため、実行前に内容を確認する。
- 公開前に `git status` と `git diff` で差分を確認する。

## Troubleshooting & Rollback
- 期待通りに動かない場合は `ls -la ~/.config` でリンクと実体を確認する。
- バックアップへ戻す例: `rm -rf ~/.config/fish` の後に `mv ~/.config/fish.backup ~/.config/fish`。
- mise や nvim も同様に `~/.config/<app>.backup` から復元できる。
