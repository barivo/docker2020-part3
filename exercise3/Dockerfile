FROM alpine

WORKDIR /usr/app

COPY my_password.txt /usr/app
COPY bash-script.sh /usr/app

RUN apk update && apk add --no-cache docker-cli git bash

# run with:
# docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock CONTAINER_NAME
