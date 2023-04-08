.PHONY: lint
lint:
	golangci-lint run ./...

.PHONY: fmt
fmt:
	go fmt ./...

.PHONY: ff
ff:
	go build -o bin/ff cmd/ff/main.go

.PHONY: loki
loki:
	go build -o bin/loki cmd/loki/main.go

.PHONY: info
info:
	go build -o bin/info cmd/info/main.go

.PHONY: sentry
sentry:
	go build -o bin/sentry cmd/sentry/main.go

.PHONY: build
build: ff loki info sentry
