umask 022

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-color
export PATH=~/.local/bin:$HOME/.composer/vendor/bin:/usr/local/go/bin:$PATH

ZSH_CUSTOM="$HOME"/.dotfiles/modules/zsh/

# Theme of zsh
PROMPT_EOL_MARK=''
ZSH_THEME="miloshadzic-custom"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  vi-mode
  web-search
  colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# Source files with additional alias
source ~/.zsh_aliases && source ~/.zsh_functions

[ -f /etc/profile.d/bash_completion.sh ] && source /etc/profile.d/bash_completion.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
