package alfred

import (
	"encoding/json"
	"log"
)

type Item struct {
	Title string `json:"title"`
	Arg   string `json:"arg"`
}

type Alfred struct {
	Items []Item `json:"items"`
}

func BuildOutput(items []Item) string {
	output := Alfred{Items: items}
	result, err := json.Marshal(output)
	if err != nil {
		log.Fatalln("Failed to marshal result", err)
	}

	return string(result)
}
