#!/bin/sh

if [[ $# -eq 0 ]]; then
    exec jekyll serve \
        --host 0.0.0.0 \
        --port "${JEKYLL_PORT:-80}" \
        --source /jekyll/source \
        --destination /jekyll/destination \
        --force_polling
fi

exec "$@"
