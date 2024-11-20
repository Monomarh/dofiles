package main

import (
	"dotfiles/modules"
	"dotfiles/modules/base"
	"dotfiles/modules/git"
	"dotfiles/modules/tmux"
	"dotfiles/modules/zsh"
	"flag"
	"fmt"
	"github.com/charmbracelet/bubbles/list"
	tea "github.com/charmbracelet/bubbletea"
	"log"
	"os"
	"time"
)

var (
	shell = flag.String("shell", os.Getenv("SHELL"), "shell to execute")
	user  = flag.String("user", "", "user to execute")
)

func main() {
	flag.Parse()
	if *user == "" {
		fmt.Println("User not set")
		os.Exit(1)
	}

	f, err := tea.LogToFile("./output.log", "")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()

	l := list.New(items(), list.NewDefaultDelegate(), 20, 0)
	l.Title = "What should be installed?"
	l.StatusMessageLifetime = 10 * time.Second

	if _, err = tea.NewProgram(
		Model{list: l},
		tea.WithAltScreen(),
		tea.WithMouseCellMotion(),
	).Run(); err != nil {
		fmt.Println("Error during the installation: ", err)
		os.Exit(1)
	}
}

func items() []list.Item {
	fabrics := []func(string, string, int) modules.Module{
		base.NewModule,
		git.NewModule,
		zsh.NewModule,
		tmux.NewModule,
	}

	var it []list.Item
	for i, f := range fabrics {
		it = append(it, f(*shell, *user, i))
	}

	return it
}
