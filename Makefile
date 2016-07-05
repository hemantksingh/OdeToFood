build:
	docker info
	docker build -t odetofood:latest --file docker/Dockerfile .

run:
	docker run -d -p 4000:4000 odetofood:latest

test: run
	sleep 5
	curl --retry 10 --retry-delay 5 -v http://localhost:4000
