ARG  RUBY_VERSION
FROM ruby:${RUBY_VERSION}-alpine
ARG  PAGES_VERSION

RUN apk add --no-cache --virtual .build-deps build-base \
  && apk add --no-cache git libcap \
  && gem install github-pages:${PAGES_VERSION} minitest \
  && apk del --no-cache .build-deps

RUN mkdir -p /jekyll/source /jekyll/destination \
  && addgroup -Sg 1000 jekyll \
  && adduser  -Su 1000 -G jekyll jekyll \
  && chown -R jekyll:jekyll /jekyll/ \
  && setcap 'cap_net_bind_service=+ep' /usr/local/bin/ruby

USER jekyll
EXPOSE 80

WORKDIR /jekyll/source

CMD jekyll serve \
  --host 0.0.0.0 \
  --port ${JEKYLL_PORT:-80} \
  --source /jekyll/source \
  --destination /jekyll/destination
