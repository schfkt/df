package config

import (
	"log"
	"os"

	"github.com/jinzhu/configor"
)

const configEnvVar = "CONFIG_PATH"

type GitLab struct {
	URL      string
	Projects []string
}

type Loki struct {
	URL        string
	OrgId      int
	Interval   string
	DataSource string
	Services   []string
}

type Sentry struct {
	URL      string
	Org      string
	Projects []string
}

type Info struct {
	Envs     []string
	Domain   string
	Services []string
}

type Config struct {
	GitLab GitLab
	Loki   Loki
	Info   Info
	Sentry Sentry
}

func LoadConfig() *Config {
	path := os.Getenv(configEnvVar)
	if path == "" {
		path = "config/config.json"
	}

	config := new(Config)
	err := configor.
		New(&configor.Config{ErrorOnUnmatchedKeys: true}).
		Load(config, path)

	if err != nil {
		log.Fatalln("Failed to load the config from path", path)
	}

	return config
}
