#!/bin/bash

echo '     _       _    __ _ _                      _               '
echo '  __| | ___ | |_ / _(_) | ___  ___   ___  ___| |_ _   _ _ __  '
echo ' / _` |/ _ \| __| |_| | |/ _ \/ __| / __|/ _ \ __| | | | ._ \ '
echo '| (_| | (_) | |_|  _| | |  __/\__ \ \__ \  __/ |_| |_| | |_) |'
echo ' \__,_|\___/ \__|_| |_|_|\___||___/ |___/\___|\__|\__,_| .__/ '
echo '                                                       |_|    '

spin()
{
  spinner="/|\\-/|\\-"
  while :
  do
    for i in $(seq 0 7)
    do
      echo -n "${spinner:$i:1}"
      echo -en "\010"
      sleep 0.1
    done
  done
}

# create symlinks to dotfiles
echo -n 'Would you setup git configs(y/n)?'
read -rs isGitConf
if [ "$isGitConf" = 'y' ] || [ "$isGitConf" = 'Y' ]; then
  echo -e '\nSetting git configs...'
  spin &
  SPIN_PID=$!
  trap 'kill -9 "$SPIN_PID"' $(seq 0 15)

   ln -sf "$HOME"/dotfiles/configs/git/.gitconfig "$HOME"/.gitconfig
  sleep 2

  kill -9 $SPIN_PID
  echo -e '\nInstallation of git configs is completed!\n'
else
  echo -e '\nNot setup'
fi

echo -n 'Would you setup zsh configs(y/n)?'
read -rs isZshConf
if [ "$isZshConf" = 'y' ] || [ "$isZshConf" = 'Y' ]; then
  echo -e '\nSetting zsh configs...'
  spin &
  SPIN_PID=$!
  trap 'kill -9 "$SPIN_PID"' $(seq 0 15)

  ln -sf "$HOME"/dotfiles/configs/zsh/.zshrc "$HOME"/.zshrc
  curl -o ~/.zsh/_git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
  sleep 2

  kill -9 $SPIN_PID
  echo -e '\nInstallation of zsh configs is completed!\n'
else
  echo -e '\nNot setup'
fi

echo -n 'Would you setup tmux configs(y/n)?'
read -rs isTmuxConf
if [ "$isTmuxConf" = 'y' ] || [ "$isTmuxConf" = 'Y' ]; then
  echo -e '\nSetting tmux configs...'
  spin &
  SPIN_PID=$!
  trap 'kill -9 "$SPIN_PID"' $(seq 0 15)

  ln -sf "$HOME"/dotfiles/configs/tmux/.tmux.conf "$HOME"/.tmux.conf
  sleep 2

  kill -9 $SPIN_PID
  echo -e '\nInstallation of tmux configs is completed!\n'
else
  echo -e '\nNot setup'
fi

echo -n 'Would you setup nvim configs(y/n)?'
read -rs isNvimConf
if [ "$isNvimConf" = 'y' ] || [ "$isNvimConf" = 'Y' ]; then
  echo -e '\nSetting nvim configs...'
  spin &
  SPIN_PID=$!
  trap 'kill -9 "$SPIN_PID"' $(seq 0 15)

  ln -sf "$HOME"/dotfiles/configs/nvim/init.vim "$HOME"/.config/nvim/init.vim
  sleep 2

  kill -9 $SPIN_PID
  echo -e '\nInstallation of nvim configs is completed!\n'
else
  echo -e '\nNot setup'
fi

exit 0