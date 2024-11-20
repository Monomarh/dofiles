package nvim

import (
	"dotfiles/modules"
	"fmt"
	"path/filepath"
)

type Module struct {
	Index int

	shell string
	user  string
}

func NewModule(shell string, user string, index int) modules.Module {
	return Module{shell: shell, user: user, Index: index}
}

func (m Module) Title() string       { return "tmux" }
func (m Module) Description() string { return "Install neovim with config file." }
func (m Module) FilterValue() string { return m.Title() }

func (m Module) Exec() any {
	home := filepath.Join("/home", m.user)

	cmds := []string{
		"apt install -y automake libtool autoconf cmake g++ neovim",
		fmt.Sprintf("ln -sf %[1]s/.dotfiles/modules/nvim/configs/init.vim %[1]s/init.vim", home),
		fmt.Sprintf("chown -h %[1]s:%[1]s %s/init.vim", m.user, home),
	}

	return modules.ExecCommand(m.Title(), m.shell, cmds)
}
