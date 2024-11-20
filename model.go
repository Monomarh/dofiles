package main

import (
	"dotfiles/modules"
	"fmt"
	"github.com/charmbracelet/bubbles/list"
	tea "github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
)

var (
	AppStyle           = lipgloss.NewStyle().Margin(2, 3)
	StatusMessageStyle = lipgloss.NewStyle().Foreground(lipgloss.Color("#04B575")).Render
	ErrorMessageStyle  = lipgloss.NewStyle().Foreground(lipgloss.Color("#C1121F")).Render
)

type Model struct{ list list.Model }

func (m Model) Init() tea.Cmd { return tea.SetWindowTitle("Dotfiles manager.") }
func (m Model) View() string  { return AppStyle.Render(m.list.View()) }

func (m Model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.KeyMsg:
		switch msg.Type {
		case tea.KeyEnter:
			i := m.list.SelectedItem()

			if i == nil {
				return m, m.list.NewStatusMessage(StatusMessageStyle("Empty choice."))
			}
			return m, func() tea.Msg { return i.(modules.Module).Exec() }

		case tea.KeyRunes:
			switch string(msg.Runes) {
			case "q", "ctrl+c":
				return m, tea.Quit
			}
		}

	case modules.DoneMsg:
		m.list.RemoveItem(msg.Index)
		return m, m.list.NewStatusMessage(StatusMessageStyle(fmt.Sprintf("%s is configured.", msg.Name)))

	case modules.ErrMsg:
		return m, m.list.NewStatusMessage(ErrorMessageStyle(fmt.Sprintf("Something went wrong: %s.", msg.Err)))

	case tea.WindowSizeMsg:
		h, v := AppStyle.GetFrameSize()
		m.list.SetSize(msg.Width-h, msg.Height-v)

		return m, nil
	}

	var cmd tea.Cmd
	m.list, cmd = m.list.Update(msg)
	return m, cmd
}
