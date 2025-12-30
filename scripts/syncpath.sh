#!/bin/bash

###############################
#
# fishのシンボリックリンクを作成
#
###############################

# 既存の.config/fishがあればバックアップ
if [ -d ~/.config/fish ]; then
  mv ~/.config/fish ~/.config/fish.backup
fi

# ~/.configがなければ作成
mkdir -p ~/.config

# シンボリックリンク作成
ln -s ~/dotfiles/.config/fish ~/.config/fish

# 確認
ls -la ~/.config/fish

###############################
#
# miseのシンボリックリンクを作成
#
###############################

# 既存の.config/miseがあればバックアップ
if [ -d ~/.config/mise ]; then
  mv ~/.config/mise ~/.config/mise.backup
fi

ln -s ~/dotfiles/.config/mise/config.toml ~/.config/mise/config.toml

###############################
#
# nvimのシンボリックリンクを作成
#
###############################
# 既存の.config/miseがあればバックアップ
if [ -d ~/.config/nvim ]; then
  mv ~/.config/mise ~/.config/mise.backup
fi

ln -s ~/dotfiles/.config/nvim ~/.config/nvim
