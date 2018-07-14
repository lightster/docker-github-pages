ARG  RUBY_VERSION
FROM ruby:${RUBY_VERSION}-alpine
ARG  PAGES_VERSION

RUN apk add --no-cache --virtual .build-deps build-base \
  && apk add --no-cache git libcap libstdc++ \
  && gem install github-pages:${PAGES_VERSION} minitest jekyll-include-cache \
  && apk del --no-cache .build-deps

RUN mkdir -p /jekyll/source /jekyll/destination \
  && addgroup -Sg 1000 jekyll \
  && adduser  -Su 1000 -G jekyll jekyll \
  && chown -R jekyll:jekyll /jekyll/ \
  && setcap 'cap_net_bind_service=+ep' /usr/local/bin/ruby

USER jekyll
EXPOSE 80

COPY docker-entrypoint.sh /usr/local/bin

WORKDIR /jekyll/source

ENTRYPOINT ["docker-entrypoint.sh"]
