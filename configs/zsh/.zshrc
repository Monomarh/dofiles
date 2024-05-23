# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
umask 022

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-color
export PATH=~/.local/bin:$HOME/.composer/vendor/bin:$PATH

ZSH_CUSTOM="$HOME"/dotfiles/configs/oh-my-zsh/

# Theme of zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
PROMPT_EOL_MARK=''
  ### Color for autoseggestions
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  vi-mode
  web-search
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
  alias gi="git checkout"
  alias gd="git diff"
  alias gds="git diff --staged"

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
source ~/.zshrc_base_alias && source ~/.zshrc_function
[ -f ~/.zshrc_custom_alias ] && source ~/.zshrc_custom_alias

command -v thefuck &> /dev/null; [ $? -eq 0 ] && eval $(thefuck --alias)

if [ -f /etc/profile.d/bash_completion.sh ]; then
  . /etc/profile.d/bash_completion.sh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:/usr/local/go/bin
