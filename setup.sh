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
  sleep 1

  if [ "$SPIN_PID" ]; then
    kill -9 "$SPIN_PID"
    unset SPIN_PID
  fi
}

setupQuestionEcho() {
  echo -n "Would you setup $1 configs(y/n)? "
}

startSetupEcho() {
  echo -e "\nSetting $1 configs..."
}

completeSetupEcho() {
  echo -e "\010Installation of $1 configs is completed!\n"
}

notSetupEcho() {
  echo -e '\nNot setup'
}

checkForPackage() {
  command -v "$1" &> /dev/null; [ $? -ne 0 ] && sudo apt install "$1"
}

trap spinEnd $(seq 0 15)

# create symlinks to dotfiles
git='git'
setupQuestionEcho $git; read -rs
if [ "$REPLY" = 'y' ] || [ "$REPLY" = 'Y' ]; then
  startSetupEcho $git

  checkForPackage $git

  if [ -e "$HOME/dotfiles/configs/git/.gitconfig" ]; then
    existGitName=$(grep 'name =' "$HOME"/dotfiles/configs/git/.gitconfig | sed 's/=/is/' | sed 's/  //')
    echo -n "Your git $existGitName(y/n)? "; read -rs; echo
    if [ "$REPLY" = 'n' ] || [ "$REPLY" = 'N' ]; then
      echo -en 'Enter you git username: '; read -r
      sed -i "s/\tname =.*/\tname = $REPLY/gi" "$HOME"/dotfiles/configs/git/.gitconfig
    fi

    existGitEmail=$(grep 'email =' "$HOME"/dotfiles/configs/git/.gitconfig | sed 's/=/is/' | sed 's/  //')
    echo -n "Your git $existGitEmail(y/n)? "; read -rs; echo
    if [ "$REPLY" = 'n' ] || [ "$REPLY" = 'N' ]; then
      echo -en 'Enter you git email: '; read -r
      sed -i "s/\temail =.*/\temail = $REPLY/gi" "$HOME"/dotfiles/configs/git/.gitconfig
    fi
  else
    echo -en 'Enter you git email: '; read -r gitEmail
    echo -en 'Enter you git username: '; read -r gitName
    sed -i "s/\temail =/\temail = $gitEmail/gi; s/\tname =/\tname = $gitName/gi" "$HOME"/dotfiles/configs/git/.gitconfig
  fi

  spinStart

  ln -sf "$HOME"/dotfiles/configs/git/.gitconfig "$HOME"/.gitconfig

  spinEnd; completeSetupEcho $git
else
  notSetupEcho
fi

zsh='zsh'
setupQuestionEcho $zsh; read -rs
if [ "$REPLY" = 'y' ] || [ "$REPLY" = 'Y' ]; then
  startSetupEcho $zsh; spinStart

  checkForPackage $zsh
  checkForPackage curl

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  ln -sf "$HOME"/dotfiles/configs/zsh/.zshrc "$HOME"/
  ln -sf "$HOME"/dotfiles/configs/zsh/.zshrc_base_alias "$HOME"/
  ln -sf "$HOME"/dotfiles/configs/zsh/.zshrc_function "$HOME"/

  mkdir -p "$HOME"/.zhs/
  curl -o "$HOME"/.zsh/ https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

  # zsh-autosuggestions plugin
  git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME"/dotfiles/configs/oh-my-zsh/plugins/zsh-autosuggestions

  # zsh-syntax-highlighting plugin
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME"/dotfiles/configs/oh-my-zsh/plugins/zsh-syntax-highlighting

  chsh -s /usr/bin/zsh

  spinEnd; completeSetupEcho $zsh
else
  notSetupEcho
fi

tmux='tmux'
setupQuestionEcho $tmux; read -rs
if [ "$REPLY" = 'y' ] || [ "$REPLY" = 'Y' ]; then
  startSetupEcho $tmux; spinStart

  checkForPackage $tmux

  ln -sf "$HOME"/dotfiles/configs/tmux/.tmux.conf "$HOME"/

  spinEnd; completeSetupEcho $tmux
else
  notSetupEcho
fi

vim='vim'
setupQuestionEcho $vim; read -rs
if [ "$REPLY" = 'y' ] || [ "$REPLY" = 'Y' ]; then
  startSetupEcho $vim; spinStart

  checkForPackage $vim

  ln -sf "$HOME"/dotfiles/configs/vim/.vimrc "$HOME"/

  spinEnd; completeSetupEcho $vim
else
  notSetupEcho
fi

nvim='nvim'
setupQuestionEcho $nvim; read -rs
if [ "$REPLY" = 'y' ] || [ "$REPLY" = 'Y' ]; then
  startSetupEcho $nvim; spinStart

  mkdir -p "$HOME"/.config/nvim/
  ln -sf "$HOME"/dotfiles/configs/nvim/init.vim "$HOME"/.config/nvim/

  spinEnd; completeSetupEcho $nvim
else
  notSetupEcho
fi
