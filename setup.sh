#!/bin/bash

echo '     _       _    __ _ _                      _               '
echo '  __| | ___ | |_ / _(_) | ___  ___   ___  ___| |_ _   _ _ __  '
echo ' / _` |/ _ \| __| |_| | |/ _ \/ __| / __|/ _ \ __| | | | ._ \ '
echo '| (_| | (_) | |_|  _| | |  __/\__ \ \__ \  __/ |_| |_| | |_) |'
echo ' \__,_|\___/ \__|_| |_|_|\___||___/ |___/\___|\__|\__,_| .__/ '
echo '                                                       |_|    '

spin() {
  spinner="/|\\-/|\\-"
  while :
  do
    for i in $(seq 0 7)
    do
      echo -en "${spinner:$i:1}"
      echo -en "\010"
      sleep 0.1
    done
  done
}

spinStart() {
  spin &
  SPIN_PID=$!
}

spinEnd() {
  if [ "$SPIN_PID" ]; then
    kill -9 "$SPIN_PID"
    unset SPIN_PID
  fi
}

trap spinEnd $(seq 0 15)

# create symlinks to dotfiles
echo -n 'Would you setup git configs(y/n)? '; read -rs isGitConf
if [ "$isGitConf" = 'y' ] || [ "$isGitConf" = 'Y' ]; then
  echo -e '\nSetting git configs...'

  if [ -e "$HOME/dotfiles/configs/git/.gitconfig" ]; then
    existGitName=$(grep 'name =' "$HOME"/dotfiles/configs/git/.gitconfig | sed 's/=/is/' | sed 's/  //')
    echo -n "Your git $existGitName(y/n)? "; read -rs isExistGitNameValid; echo
    if [ "$isExistGitNameValid" = 'n' ] || [ "$isExistGitNameValid" = 'N' ]; then
      echo -en 'Enter you git username: '; read -r gitName
      sed -i "s/\tname =.*/\tname = $gitName/gi" "$HOME"/dotfiles/configs/git/.gitconfig
    fi

    existGitEmail=$(grep 'email =' "$HOME"/dotfiles/configs/git/.gitconfig | sed 's/=/is/' | sed 's/  //')
    echo -n "Your git $existGitEmail(y/n)? "; read -rs isExistGitEmailValid; echo
    if [ "$isExistGitEmailValid" = 'n' ] || [ "$isExistGitEmailValid" = 'N' ]; then
      echo -en 'Enter you git email: '; read -r gitName
      sed -i "s/\temail =.*/\temail = $gitName/gi" "$HOME"/dotfiles/configs/git/.gitconfig
    fi
  else
    echo -en 'Enter you git email: '; read -r gitEmail
    echo -en 'Enter you git username: '; read -r gitName
    sed -i "s/\temail =/\temail = $gitEmail/gi; s/\tname =/\tname = $gitName/gi" "$HOME"/dotfiles/configs/git/.gitconfig
  fi

  spinStart

  ln -sf "$HOME"/dotfiles/configs/git/.gitconfig "$HOME"/.gitconfig

  sleep 2
  spinEnd

  echo -e '\010Installation of git configs is completed!\n'
else
  echo -e '\nNot setup'
fi

echo -n 'Would you setup zsh configs(y/n)? '; read -rs isZshConf
if [ "$isZshConf" = 'y' ] || [ "$isZshConf" = 'Y' ]; then
  echo -e '\nSetting zsh configs...'

  spinStart

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  ln -sf "$HOME"/dotfiles/configs/zsh/.zshrc "$HOME"/.zshrc

  mkdir -p "$HOME"/.zhs/
  curl -o "$HOME"/.zsh/ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

  # zsh-autosuggestions plugin
  git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME"/dotfiles/configs/oh-my-zsh/plugins/zsh-autosuggestions

  # zsh-syntax-highlighting plugin
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME"/dotfiles/configs/oh-my-zsh/plugins/zsh-syntax-highlighting

  chsh -s /usr/bin/zsh
  sleep 2
  spinEnd

  echo -e '\010Installation of zsh configs is completed!\n'
else
  echo -e '\nNot setup'
fi

echo -n 'Would you setup tmux configs(y/n)? '
read -rs isTmuxConf
if [ "$isTmuxConf" = 'y' ] || [ "$isTmuxConf" = 'Y' ]; then
  echo -e '\nSetting tmux configs...'

  spinStart

  ln -sf "$HOME"/dotfiles/configs/tmux/.tmux.conf "$HOME"/.tmux.conf

  sleep 2
  spinEnd

  echo -e '\010Installation of tmux configs is completed!\n'
else
  echo -e '\nNot setup'
fi

echo -n 'Would you setup nvim configs(y/n)? '
read -rs isNvimConf
if [ "$isNvimConf" = 'y' ] || [ "$isNvimConf" = 'Y' ]; then
  echo -e '\nSetting nvim configs...'

  spinStart

  ln -sf "$HOME"/dotfiles/configs/nvim/init.vim "$HOME"/.config/nvim/init.vim

  sleep 2
  spinEnd

  echo -e '\010Installation of nvim configs is completed!\n'
else
  echo -e '\nNot setup'
fi
