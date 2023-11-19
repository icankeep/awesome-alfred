package main

import (
	"github.com/icankeep/awesome_alfred/internal"
	"github.com/urfave/cli/v2"
	"log"
	"os"
)

func main() {
	// parse command line arguments

	// Wrap your entry point with Run() to catch and log panics and
	// show an error in Alfred instead of silently dying

	var app = &cli.App{
		Name:     "aw",
		Usage:    "",
		Commands: internal.GetCommands(),
	}
	if err := app.Run(os.Args); err != nil {
		log.Fatal(err)
	}
}
