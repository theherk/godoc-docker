.DEFAULT_GOAL := help

# project variables
IMAGE := godoc
IMAGES := $(shell docker images | awk '/$(IMAGE)/ {print $$3}')
RUNNING :=  $(shell docker ps | grep "$(IMAGE)" | awk '{print $$1}')
ALL := $(shell docker ps -a | grep "$(IMAGE)" | awk '{print $$1}')

help: ## display this usage message
	$(info available targets:)
	@awk '/^[a-zA-Z\-\_0-9\.]+:/ { \
		nb = sub( /^## /, "", helpMsg ); \
		if(nb == 0) { \
			helpMsg = $$0; \
			nb = sub( /^[^:]*:.* ## /, "", helpMsg ); \
		} \
		if (nb) \
			print  $$1 "\t" helpMsg; \
	} \
	{ helpMsg = $$0 }' \
	$(MAKEFILE_LIST) | column -ts $$'\t' | \
	grep --color '^[^ ]*'

attach: ## attach to a running container interactively in bash
	docker exec -ti $(IMAGE)-1 bash

build: ## build the image
	docker build -t $(IMAGE) .

clean: clean-images ## clean all the things

clean-containers: stop-all ## remove containers
	for c in $(ALL); do docker rm $$c; done

clean-images: clean-containers ## remove images
	for c in $(IMAGES); do docker rmi $$c; done

publish: build ## publish the docker build to registry
	docker login -u theherk
	docker tag $(IMAGE):latest theherk/$(IMAGE):latest
	docker push theherk/$(IMAGE):latest

run: clean-containers build ## remove previous and run a new container
	docker run -d -e "GO_PKGS=$(GO_PKGS)" \
	-p 6060:6060 \
	--name $(IMAGE)-1 \
	$(IMAGE)

stop-all: ## stop all running containers of this image
	for c in $(RUNNING); do docker stop $$c; done
