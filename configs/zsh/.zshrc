# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-color
export PATH=~/.local/bin:$HOME/.composer/vendor/bin:$PATH

fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

ZSH_CUSTOM="$HOME"/dotfiles/configs/oh-my-zsh/

# Theme of zsh
ZSH_THEME="miloshadzic-custom"
PROMPT_EOL_MARK=''
  ### Color for autoseggestions
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  vi-mode
  web-search
  docker
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases and functions
  ### Bash
  alias ll="ls -alh --group-directories-first"
  alias le="less --tabs=4 -RNFX"
  alias sudo="sudo "
  alias echoUIDGID='echo "\nUSER_ID=$(id -u)\nGROUP_ID=$(id -g)"'
  ### GIT
  alias ga="git add"
  alias gc="git commit"
  alias gs="git status -sb"
  alias gsv="git status -vv"
  alias gh="git log --pretty=format:'%Cred%h %C(#FF7F50)%d %Cgreen[%an] %cr%n%n%B' --graph"
  alias gb="git branch"
  alias go="git checkout"

# Fix for arrow-key searching
  ### start typing + [Up-Arrow] - fuzzy find history forward
  if [[ "${terminfo[kcuu1]}" != "" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
  fi
  ### start typing + [Down-Arrow] - fuzzy find history backward
  if [[ "${terminfo[kcud1]}" != "" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
  fi

# Source files with additional alias
source ~/.zshrc_base_alias
source ~/.zshrc_function
[ -f ~/.zshrc_custom_alias ] && source ~/.zshrc_custom_alias

command -v thefuck &> /dev/null; [ $? -eq 0 ] && eval $(thefuck --alias)

if [ -f /etc/profile.d/bash_completion.sh ]; then
  . /etc/profile.d/bash_completion.sh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
