package main

import (
	"alfred-helpers/packages/alfred"
	"alfred-helpers/packages/config"
	"fmt"
	"os"
	"sort"

	"github.com/lithammer/fuzzysearch/fuzzy"
)

func buildSentryUrl(config config.Sentry, project string) string {
  return fmt.Sprintf("%s/organizations/%s/projects/%s", config.URL, config.Org, project)
}

func main() {
	config := config.LoadConfig().Sentry

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
		items[i].Arg = buildSentryUrl(config, match.Target)
	}
	result := alfred.BuildOutput(items)

	fmt.Print(result)
}
