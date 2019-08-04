#!/bin/bash

echo '     _       _    __ _ _                      _               '
echo '  __| | ___ | |_ / _(_) | ___  ___   ___  ___| |_ _   _ _ __  '
echo ' / _` |/ _ \| __| |_| | |/ _ \/ __| / __|/ _ \ __| | | | ._ \ '
echo '| (_| | (_) | |_|  _| | |  __/\__ \ \__ \  __/ |_| |_| | |_) |'
echo ' \__,_|\___/ \__|_| |_|_|\___||___/ |___/\___|\__|\__,_| .__/ '
echo '                                                       |_|    '

# create symlinks to dotfiles
ln -sf $HOME/dotfiles/config/nvim/init.vim $HOME/.config/nvim/init.vim
ln -sf $HOME/dotfiles/config/zsh/.zshrc $HOME/.zshrc
ln -sf $HOME/dotfiles/config/tmux/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/dotfiles/config/git/.gitconfig $HOME/.gitconfig
