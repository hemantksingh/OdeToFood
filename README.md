## Build docker image ##
There are 2 ways to build the docker image

* `docker build -t ode-to-food`
* `docker-compose build`

## Start the app in docker container ##

Run the container using the built image `docker run -it -p 4000:4000 -v $(pwd)/src/OdeToFood:/app -w "/app" ode-to-food`

or `docker-compose up`
The app should start at `http://$DOCKER_HOST:4000`
