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

.PHONY: build
build: ff loki
