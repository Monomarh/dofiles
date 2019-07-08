# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme of zsh
ZSH_THEME="agnoster-nanof"

# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

plugins=(
  git
  zsh-syntax-highlighting  
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases
### Bash
alias ll="ls -alh --group-directories-first"
alias vim="nvim"
alias sudo="sudo "
### GIT
alias ga="git add"
alias gc="git commit"
alias gs="git status"
alias gh="git log --pretty=format:'%Cred%h %C(#FF7F50)%d %Cgreen[%an] %cr%n%n%B' --graph"
alias gb="git branch"
alias go="git checkout"

# Color for autoseggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"
