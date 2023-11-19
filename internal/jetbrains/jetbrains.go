package jetbrains

import (
	"fmt"
	"github.com/icankeep/awesome_alfred/internal/workflow"
	"github.com/icankeep/simplego/external/jetbrains"
)

var Action = workflow.GetActionFunc(&handler{}, true, false)

type handler struct{}

func (h *handler) FetchNewest(ctx *workflow.Context) error {
	return nil
}

func (h *handler) BuildItems(ctx *workflow.Context) error {
	ideType := ctx.GetStringFlag("ide")
	projects, err := jetbrains.GetRecentProjects(jetbrains.IDEType(ideType))
	if err != nil {
		return fmt.Errorf("failed to get recent projects, error: %v", err)
	}

	for _, project := range projects {
		ctx.NewItem(project.Name).Subtitle(project.Dir).Var("IDE_TYPE", ideType).
			Var("PROJECT_DIR", project.Dir).Valid(true)
	}
	return nil
}
