build:
	docker build -t odetofood:latest --file docker/Dockerfile .

run:
	docker run -it -p 4000:4000 odetofood:latest