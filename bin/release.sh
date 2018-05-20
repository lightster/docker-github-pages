#!/bin/sh

DOCKER_REPO="lightster/github-pages"

VERSIONS_JSON=$(curl -sS https://pages.github.com/versions.json)

RUBY_VERSION=$(echo "$VERSIONS_JSON" | jq --raw-output '.ruby')
PAGES_VERSION=$(echo "$VERSIONS_JSON" | jq --raw-output '.["github-pages"]')

docker build . \
    --build-arg RUBY_VERSION="${RUBY_VERSION}" \
    --build-arg PAGES_VERSION="${PAGES_VERSION}" \
    --tag "${DOCKER_REPO}:latest" \
    --tag "${DOCKER_REPO}:pages-${PAGES_VERSION}" \
    --tag "${DOCKER_REPO}:pages-${PAGES_VERSION}-ruby-${RUBY_VERSION}" \

docker push "${DOCKER_REPO}"
