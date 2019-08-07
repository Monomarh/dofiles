# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
fpath=(~/.zsh $fpath)

# Theme of zsh
ZSH_THEME="agnoster-custom"
$PROMPT_EOL_MARK=''
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
  ### Color for autoseggestions
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  vi-mode
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
  alias gs="git status -sb"
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
source ~/.zshrc_alias
