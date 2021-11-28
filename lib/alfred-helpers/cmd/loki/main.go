package main

import (
	"fmt"
	"net/url"
	"os"
	"alfred-helpers/packages/alfred"
	"alfred-helpers/packages/config"

	"github.com/lithammer/fuzzysearch/fuzzy"
)

func buildLokiUrl(config config.Loki, service string) string {
	v := url.Values{}
	v.Set("orgId", fmt.Sprintf("%d", config.OrgId))
	v.Set("left", fmt.Sprintf(
		"[\"now-%s\",\"now\",\"%s\",{\"refId\":\"A\",\"expr\":\"{app=\\\"%s\\\"}\"}]",
		config.Interval,
		config.DataSource,
		service,
	))

	return fmt.Sprintf("%s/explore?%s", config.URL, v.Encode())
}

func main() {
	config := config.LoadConfig().Loki

	if len(os.Args) < 2 {
		return
	}
	arg := os.Args[1]
	if len(arg) == 0 {
		return
	}

	matches := fuzzy.Find(arg, config.Services)

	items := make([]alfred.Item, len(matches))
	for i, match := range matches {
		items[i].Title = match
		items[i].Arg = buildLokiUrl(config, match)
	}
	result := alfred.BuildOutput(items)

	fmt.Print(result)
}
