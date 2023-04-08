package main

import (
	"alfred-helpers/packages/alfred"
	"alfred-helpers/packages/config"
	"fmt"
	"os"
	"sort"

	"github.com/lithammer/fuzzysearch/fuzzy"
)

func buildFindFileUrl(baseUrl, project string) string {
	return fmt.Sprintf("%s/%s/-/find_file/master", baseUrl, project)
}

func main() {
	config := config.LoadConfig().GitLab

	if len(os.Args) < 2 {
		return
	}
	arg := os.Args[1]
	if len(arg) == 0 {
		return
	}

	matches := fuzzy.RankFind(arg, config.Projects)
  sort.Sort(matches)

	items := make([]alfred.Item, len(matches))
	for i, match := range matches {
		items[i].Title = match.Target
		items[i].Arg = buildFindFileUrl(config.URL, match.Target)
	}
	result := alfred.BuildOutput(items)

	fmt.Print(result)
}
