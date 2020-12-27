# docker run -it -p 8080:80 frontend-multi-stage
FROM alpine as build-stage

WORKDIR /app

RUN apk add --no-cache git nodejs nodejs-npm && \
    git clone https://github.com/docker-hy/frontend-example-docker.git . && \
    npm install && \
    npm run build

FROM nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html
