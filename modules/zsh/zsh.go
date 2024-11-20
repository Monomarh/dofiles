package zsh

import (
	"dotfiles/modules"
	"fmt"
	"os"
	"path/filepath"
)

var (
	tmp = os.TempDir()

	// oh-my-zsh
	// https://github.com/ohmyzsh/ohmyzsh
	ohMyZshScript    = "install.sh"
	ohMyZshInstaller = fmt.Sprintf("https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/%s", ohMyZshScript)

	// zsh-autosuggestions
	autoSuggestion = "https://github.com/zsh-users/zsh-autosuggestions"

	// zsh-syntax-highlighting
	syntaxHighlighting = "https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

type Module struct {
	Index int

	shell string
	user  string
}

func NewModule(shell string, user string, index int) modules.Module {
	return Module{shell: shell, user: user, Index: index}
}

func (m Module) Title() string       { return "zsh" }
func (m Module) Description() string { return "Install zsh and oh-my-zsh with aliases and functions." }
func (m Module) FilterValue() string { return m.Title() }

func (m Module) Exec() any {
	home := filepath.Join("/home", m.user)
	installer := filepath.Join(tmp, ohMyZshScript)
	zshCustom := filepath.Join(home, ".dotfiles/modules/zsh")
	zshDotfiles := filepath.Join(zshCustom, "configs")

	cmds := []string{
		"apt install -y zsh",

		// Download oh-my-zsh installer
		fmt.Sprintf("wget -qO %s %s", installer, ohMyZshInstaller),

		// Make it executable
		fmt.Sprintf("chmod a+x %s", installer),

		// Run installer with custom ENVs
		fmt.Sprintf("sudo -u %s %s -c '%s'", m.user, m.shell, installer),

		// Create links to the dotfiles
		fmt.Sprintf("ln -sf %s/.zshrc %s/.zshrc", zshDotfiles, home),
		fmt.Sprintf("ln -sf %s/.zsh_functions %s/.zsh_functions", zshDotfiles, home),
		fmt.Sprintf("ln -sf %s/.zsh_aliases %s/.zsh_aliases", zshDotfiles, home),
		fmt.Sprintf("chown -h %[1]s:%[1]s %[2]s/.zshrc %[2]s/.zsh_aliases %[2]s/.zsh_functions", m.user, home),

		// Install Plugins
		fmt.Sprintf("sudo -u %s %s -c 'git clone %s %s'", m.user, m.shell, autoSuggestion, filepath.Join(zshCustom, "plugins/zsh-autosuggestions")),
		fmt.Sprintf("sudo -u %s %s -c 'git clone %s %s'", m.user, m.shell, syntaxHighlighting, filepath.Join(zshCustom, "plugins/zsh-syntax-highlighting")),
	}

	return modules.ExecCommand(m.Title(), m.shell, cmds)
}
