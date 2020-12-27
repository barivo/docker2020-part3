#!/bin/bash

DOCKER_LOGIN="jay101"
FILE=Dockerfile

echo "Pleae enter the GitHub repository URL:"
read GIT_URL

# for testing purposes, set a default repo url to avoid reentring it.
if [ -z "$GIT_URL" ];then
  echo "GIT_URL is empty"
  GIT_URL=https://github.com/docker-hy/frontend-example-docker.git
fi

REPO=$(basename $GIT_URL)
DIR=${REPO/.git/''}

echo "The repository name is ${DIR}"

if [ ! -d "$DIR" ]; then
  git  clone $GIT_URL
fi

if [ ! -f "$FILE" ]; then

touch $FILE
cat > $FILE <<- EOM
FROM alpine

WORKDIR /usr/app

RUN apk add --no-cache git nodejs nodejs-npm && \
    git clone ${GIT_URL} . && \
    npm install && \
    npm install -g serve && \
    npm run build && \
    apk del git 

USER app

CMD serve -s -l $PORT dist
EOM

fi

LOGGED_IN=$(docker login)

if [[ "Login Succeeded" =~ *"$LOGGED_IN"* ]]; then 
  echo "Already logged in"
else
  echo "Attempting to log in"
  cat password.txt | docker login --username $DOCKER_LOGIN --password-stdin
fi


IMAGES=$(docker images) # OR IMAGES=`docker images`

if [[ ! -z "$DIR" && ! *"$IMAGES"* =~ "$DIR" ]]; then
  echo "Building docker image."
  docker build -t $DIR .
  docker tag $DIR $DOCKER_LOGIN/$DIR
  docker push $DOCKER_LOGIN/$DIR
else
  echo "Docker image already exists."
fi


echo "Script finished!"
