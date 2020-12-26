# Dotfiles

### Include configs for:

* `zsh`
    * `aliases` [file](configs/zsh/.zshrc_base_alias)
    * `functions` [file](configs/zsh/.zshrc_function)
* `oh-my-zsh`
    * `sobole` theme with two lines
    * `miloshadzic` theme with two lines
    * `agnoster` theme with two lines
* `tmux`
* `vim`
    * Nerd font
* `nvim`
* `git`
    * `.gitconfig`
    * `.gitignore`

### There are some useful tips (All links are clickable):

* [`mysql`](tips/mysql.md)
* [`terminal`](tips/terminal.md)
* [`utilities`](tips/utilities.md)
* [`vim`](tips/vim.md) - In Russian

## Dotfiles installation

### Need to make the setup.sh file executable

```bash
sudo chmod u+x setup.sh
```

### Run script

Script has some interactive options (possible to choose which configs need to install)
```bash
. setup.sh
```
