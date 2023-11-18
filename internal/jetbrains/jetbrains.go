package jetbrains

import (
	aw "github.com/deanishe/awgo"
	jetbrains_util "github.com/icankeep/simplego/external/jetbrains"
)

func GetRecentObjects() {
}

func Run(wf *aw.Workflow, ideType jetbrains_util.IDEType) {
	defer wf.SendFeedback()
	projects, err := jetbrains_util.GetRecentProjects(ideType)
	if err != nil {
		wf.NewItem("Get recent projects failed").Subtitle(err.Error())
		//wf.SendFeedback()
		return
	}

	for _, project := range projects {
		wf.NewItem(project.Name).Subtitle(project.Dir).Arg(project.Dir).Valid(true)
	}
}
