VERSION := $(shell git describe --tags)
BUILD := $(shell git rev-parse --short HEAD)
PROJECTNAME := $(shell basename "$(PWD)")

# Go related variables.
GOBASE := $(shell pwd)
GOPATH := $(GOBASE)/vendor:$(GOBASE)
GOBIN := $(GOBASE)/bin
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOMOD=$(GOCMD) mod download
BIN_NAME=smak

# Use linker flags to provide version/build settings
LDFLAGS=-ldflags "-X=main.Version=$(VERSION) -X=main.Build=$(BUILD)"

#MAKEFLAGS += --silent

all: test build
build: 
	@-mkdir -p $(GOBIN)
	$(GOBUILD) -o $(GOBIN)/$(BIN_NAME) $(LDFLAGS) -v main.go

test:
	$(GOTEST) -v ./...

clean:
	$(GOCLEAN)
	@-rm -rf $(GOBIN)

deps:
	$(GOMOD)

docker:
	docker build . -t smak:latest