# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
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
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Aliases and functions
  ### Bash
  alias ll="ls -alh --group-directories-first"
  alias le="less --tabs=4 -RNFX"
  alias sudo="sudo "
  ### GIT
  alias ga="git add"
  alias gc="git commit"
  alias gs="git status -sb"
  alias gsv="git status -vv"
  alias gh="git log --pretty=format:'%Cred%h %C(#FF7F50)%d %Cgreen[%an] %cr%n%n%B' --graph"
  alias gb="git branch"
  alias go="git checkout"

gprev() {
  for i in {1.."$1"}; do
    echo -n  "$i\t";
    git rev-parse --symbolic-full-name @{-$i};
  done
}

grew() {
  git rebase HEAD~"$1" -i;
}

gdn() {
  git diff -- $(git ls-files --modified | sed -n "$1p")
}

gcn() {
  git checkout -- $(git ls-files --modified | sed -n "$1p")
}

grn() {
  git reset -- $(git ls-files --modified | sed -n "$1p")
}

previous() {
    commitCount="${1:-10}"

    if [[ "$commitCount" != <-> ]]; then
        echo -en 'Numeric value must be in parameter'
        return 0
    fi

    for i in {1..$commitCount}; do
        echo -n "@{-$i} - "
        git rev-parse --abbrev-ref "@{-$i}"
    done

    echo -en 'Enter commit number(n/q for cancel): '; read -r
    if [[ "$REPLY" != 'n' ]] && [[ "$REPLY" != 'q' ]]; then
        git checkout $(git rev-parse --abbrev-ref "@{-$REPLY}")
    fi
}

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

eval $(thefuck --alias)
alias grep_debug="grep -E 'alert|debugger|console\.log|var_dump|die'"

export TERM=xterm-color
