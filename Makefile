ifndef D_HOST
D_HOST=localhost
endif

CONTAINER=ode
IMAGE=odetofood
PORT=4000

.PHONY: build
build:
	docker info
	docker build -t $(IMAGE):latest --file docker/Dockerfile .

.PHONY: run
run:
	docker run --name $(CONTAINER) -d -p $(PORT):$(PORT) $(IMAGE):latest

.PHONY: test
test: run
	sleep 5
	curl --retry 10 --retry-delay 5 -v http://$(D_HOST):$(PORT)
	make clean

.PHONY: clean
clean:
	docker rm -f $(CONTAINER)
