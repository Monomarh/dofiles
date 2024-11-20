package git

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

func (m Module) Title() string       { return "git" }
func (m Module) Description() string { return "Install git with config and gitignore files." }
func (m Module) FilterValue() string { return m.Title() }

func (m Module) Exec() any {
	home := filepath.Join("/home", m.user)

	cmds := []string{
		"apt install -y git",
		fmt.Sprintf("ln -sf %[1]s/.dotfiles/modules/git/configs/.gitconfig %[1]s/.gitconfig", home),
		fmt.Sprintf("chown -h %[1]s:%[1]s %s/.gitconfig", m.user, home),
	}

	return modules.ExecCommand(m.Title(), m.shell, cmds)
}
