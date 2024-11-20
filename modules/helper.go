package modules

import (
	"log"
	"os/exec"
)

type Module interface {
	Title() string
	Description() string
	FilterValue() string
	Exec() any
}

type DoneMsg struct {
	Name  string
	Index int
}

type ErrMsg struct{ Err error }

func ExecCommand(module string, shell string, cmds []string) any {
	for _, cmd := range cmds {
		c := exec.Command(shell, "-c", cmd)

		output, err := c.CombinedOutput()
		if err != nil {
			log.Printf("error executing command: %s. Error [%s]\n%s", cmd, err, string(output))

			return ErrMsg{Err: err}
		}

		log.Printf("command executed: %s\n%s", cmd, string(output))
	}

	return DoneMsg{Name: module}
}
