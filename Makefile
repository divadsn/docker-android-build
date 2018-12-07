DOCKER = docker
IMAGE = divadsn/android-build

build: Dockerfile
	$(DOCKER) build -t $(IMAGE) .

.PHONY: build
