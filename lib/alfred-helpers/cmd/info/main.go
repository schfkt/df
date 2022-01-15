package main

import (
	"alfred-helpers/packages/alfred"
	"alfred-helpers/packages/config"
	"fmt"
	"os"

	"github.com/lithammer/fuzzysearch/fuzzy"
)

func main() {
	config := config.LoadConfig().Info

	if len(os.Args) < 3 {
		return
	}
	env := os.Args[1]
	if len(env) == 0 {
		return
	}
	arg := os.Args[2]
	if len(arg) == 0 {
		return
	}

	matches := fuzzy.Find(arg, config.Services)

	items := make([]alfred.Item, len(matches))
	for i, match := range matches {
		items[i].Title = match
		items[i].Arg = fmt.Sprintf("https://%s.%s.%s/info", match, env, config.Domain)
	}
	result := alfred.BuildOutput(items)

	fmt.Print(result)
}
