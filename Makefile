ifndef D_HOST
D_HOST=localhost
endif

ifndef CLEAN_UP
CLEAN_UP=ON
endif

CONTAINER=ode
IMAGE=hemantksingh/odetofood
PORT=4000

.PHONY: build run test push deploy clean

all: build test push clean deploy

build:
	docker info
	docker build -t $(IMAGE):latest .

run:
	docker run --name $(CONTAINER) -d -p $(PORT):$(PORT) $(IMAGE):latest

test: run
	sleep 5
	curl --retry 10 --retry-delay 5 -v http://$(D_HOST):$(PORT)
ifeq ($(CLEAN_UP), ON)
	docker rm -f $(CONTAINER)
else
	@echo Not cleaning container
endif

push:
	@docker login -e $(DOCKER_EMAIL) -u $(DOCKER_USER) -p $(DOCKER_PASS)
	docker push $(IMAGE)

deploy:
	@echo Deployment using ebcli yet to be done ...

clean:
ifeq ($(CLEAN_UP), ON)
	rm ~/.docker/config.json
else
	@echo Not cleaning container
endif
