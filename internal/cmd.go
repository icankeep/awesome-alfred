package internal

import (
	"github.com/icankeep/awesome_alfred/internal/jetbrains"
	"github.com/icankeep/awesome_alfred/internal/workflow"
	"github.com/urfave/cli/v2"
)

func GetCommands() []*cli.Command {
	cmds := make([]*cli.Command, 0)
	cmds = append(cmds, &cli.Command{
		Name:      "projects",
		Usage:     "projects --ide {ideType} {query}",
		UsageText: "list recent projects of the products of Jetbrains",
		Action:    jetbrains.Action,
		Flags:     workflow.GetStringFlags("--ide {ideType}", "ide"),
	})
	return cmds
}
