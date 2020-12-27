FROM jekyll/jekyll:3.8.3 as build-stage

WORKDIR /tmp

COPY Gemfile* ./

RUN bundle install

WORKDIR /usr/src/app

COPY . .

RUN chown -R jekyll .

RUN jekyll build

FROM nginx:alpine


COPY --from=build-stage /usr/src/app/_site/ /usr/share/nginx/html

COPY default.conf /etc/nginx/conf.d/

# replace $PORT placeholder with HEROKU given port in default.conf and run nginx service
CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
