package workflow

import (
	aw "github.com/deanishe/awgo"
	"github.com/urfave/cli/v2"
)

type Context struct {
	cliContext *cli.Context

	*aw.Workflow
}

func (c *Context) GetBoolFlag(flag string) bool {
	return c.cliContext.Bool(flag)
}

func (c *Context) GetStringFlag(flag string) string {
	return c.cliContext.String(flag)
}

func (c *Context) GetFirstQuery() string {
	return c.cliContext.Args().First()
}

func (c *Context) GetLastQuery() string {
	if c.cliContext.Args().Len() == 0 {
		return ""
	}
	return c.cliContext.Args().Get(c.cliContext.Args().Len() - 1)
}

type Action interface {
	FetchNewest(ctx *Context) error

	BuildItems(ctx *Context) error
}

func GetStringFlags(usage string, names ...string) []cli.Flag {
	flags := make([]cli.Flag, 0)
	for _, name := range names {
		flags = append(flags, &cli.StringFlag{
			Name:  name,
			Usage: usage,
		})
	}
	return flags
}

func GetActionFunc(action Action, filter bool, cache bool) cli.ActionFunc {
	return func(ctx *cli.Context) error {
		wf := aw.New()
		workflowCtx := &Context{
			cliContext: ctx,
			Workflow:   wf,
		}

		if err := action.FetchNewest(workflowCtx); err != nil {
			wf.FatalError(err)
		}

		if err := action.BuildItems(workflowCtx); err != nil {
			wf.FatalError(err)
		}

		if filter {
			wf.Feedback.Filter(workflowCtx.GetLastQuery())
		}

		wf.SendFeedback()
		return nil
	}
}
