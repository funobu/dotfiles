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
