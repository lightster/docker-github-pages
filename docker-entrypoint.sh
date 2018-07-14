#!/bin/sh

if [[ $# -eq 0 ]]; then
    COMMAND="jekyll serve --host 0.0.0.0 --port ${JEKYLL_PORT:-80}"
    COMMAND="${COMMAND} --source /jekyll/source --destination /jekyll/destination"
    COMMAND="${COMMAND} --force_polling ${JEKYLL_CLI_OPTS:-}"

    echo ${COMMAND}
    exec ${COMMAND}
fi

exec "$@"
