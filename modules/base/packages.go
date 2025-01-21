package base

import (
	"dotfiles/modules"
	"fmt"
	"os"
	"path/filepath"
)

var (
	tmp = os.TempDir()

	// bat
	// https://github.com/sharkdp/bat/releases
	batVersion    = "v0.24.0"
	batFolder     = fmt.Sprintf("bat-%s-x86_64-unknown-linux-musl", batVersion)
	batRepository = fmt.Sprintf("https://github.com/sharkdp/bat/releases/download/%s/%s.tar.gz", batVersion, batFolder)

	// diff-so-fancy
	// https://github.com/so-fancy/diff-so-fancy/releases
	diffSoFancyVersion    = "v1.4.4"
	diffSoFancyRepository = fmt.Sprintf("https://github.com/so-fancy/diff-so-fancy/releases/download/%s/diff-so-fancy", diffSoFancyVersion)
)

type Module struct {
	Index int

	shell string
	user  string
}

func NewModule(shell string, user string, index int) modules.Module {
	return Module{shell: shell, user: user, Index: index}
}

func (m Module) Title() string       { return "base" }
func (m Module) Description() string { return "Install required packages." }
func (m Module) FilterValue() string { return m.Title() }

func (m Module) Exec() any {
	home := filepath.Join("/home", m.user)

	cmds := []string{
		"apt update",
		"apt install -y perl curl wget ca-certificates make",
		// create local directories
		fmt.Sprintf("install --owner=%[1]s --group=%[1]s -d %s/.local/{bin,share}", m.user, home),

		// install bat for git pager
		fmt.Sprintf("wget %s -qO- | tar -xvz -C %s", batRepository, tmp),
		fmt.Sprintf("install --mode=u+rwx,go+rx --owner=%[1]s --group=%[1]s %s/bat %s/.local/bin/bat", m.user, filepath.Join(tmp, batFolder), home),
		fmt.Sprintf("rm -rf %s/%s", tmp, batFolder),

		// Install diff-so-fancy for git pager
		fmt.Sprintf("wget -qO %s/diff-so-fancy %s", tmp, diffSoFancyRepository),
		fmt.Sprintf("install --mode=u+rwx,go+rx --owner=%[1]s --group=%[1]s %s/diff-so-fancy %s/.local/bin/diff-so-fancy", m.user, tmp, home),
	}

	return modules.ExecCommand(m.Title(), m.shell, cmds)
}
