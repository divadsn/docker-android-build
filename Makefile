DOCKER = docker
IMAGE = divadsn/android-build
TAG = $(shell git rev-parse --abbrev-ref HEAD)

build: Dockerfile
	$(DOCKER) build -t $(IMAGE):$(TAG) .

.PHONY: build
