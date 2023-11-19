package ide

import (
	"github.com/icankeep/awesome_alfred/internal/workflow"
	"github.com/icankeep/simplego/external/ide"
)

var Action = workflow.GetActionFunc(&handler{}, true, false)

type handler struct{}

func (h *handler) FetchNewest(ctx *workflow.Context) error {
	return nil
}

func (h *handler) BuildItems(ctx *workflow.Context) error {
	var projects []*ide.Project

	ideType := ctx.GetStringFlag("ide")
	projects, err := ide.GetRecentProjects(ideType)
	if err != nil {
		return err
	}
	if len(projects) == 0 {
		ctx.NewItem("Not Found Project, Type: " + ideType).Valid(false)
	}

	for _, project := range projects {
		ctx.NewItem(project.Name).Subtitle(project.Dir).Var("IDE_TYPE", ideType).
			Var("PROJECT_DIR", project.Dir).Valid(true)
	}
	return nil
}
