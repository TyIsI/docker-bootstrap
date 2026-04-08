#!/bin/sh

export DOCKER_BOOSTRAP_VERSION=0.0.1

set -e

BOOTSTRAP_BYPASS=${BOOTSTRAP_BYPASS:-0}

BOOTSTRAP_SHELL="${BOOTSTRAP_SHELL:-$(realpath /bin/sh)}"
SELF_SHELL=$(realpath /proc/$$/exe)

if [ "${BOOTSTRAP_SHELL}" != "${SELF_SHELL}" ]; then
    echo "Bootstrap_shell (${BOOTSTRAP_SHELL}) is not matching parent shell (${SELF_SHELL})."
    echo "Respawing!"
    exec "${BOOTSTRAP_SHELL}" "$0" "$*"
fi

if [ "${BOOTSTRAP_BYPASS}" = "0" ]; then
    BOOTSTRAP_DIRS="${BOOTSTRAP_DIRS:-}"

    BOOTSTRAP_DIRS="${BOOTSTRAP_DIRS} ${BOOTSTRAP_DIR:-/etc/bootstrap.d}"

    if [ "${CUSTOM_BOOTSTRAP_DIR}" != "" ]; then
        BOOTSTRAP_DIRS="${BOOTSTRAP_DIRS} ${CUSTOM_BOOTSTRAP_DIR}"
    fi

    BOOTSTRAP_DIRS=$(echo "${BOOTSTRAP_DIRS}" | sed 's/^ *//g;s/ *$//g;s/ {2}/ /g')

    for CHECK_DIR in ${BOOTSTRAP_DIRS}; do
        test -d "${CHECK_DIR}" || (
            echo "Missing bootstrap directory: [${CHECK_DIR}]"
            exit 255
        )
    done

    for BOOTSTRAP_SCRIPT_DIR in ${BOOTSTRAP_DIRS}; do
        find "${BOOTSTRAP_SCRIPT_DIR}" -type f | sort | while read -r BOOTSTRAP_SCRIPT_FILE; do
            # shellcheck source=/dev/null
            . "${BOOTSTRAP_SCRIPT_FILE}"
        done
    done
fi

BOOTSTRAP_BUILDONLY=${BOOTSTRAP_BUILDONLY:-false}

if [ "${BOOTSTRAP_BUILDONLY}" = "false" ]; then
    exec ${BOOTSTRAP_ENTRYPOINT:-${BOOTSTRAP_SHELL} -c} "$*"
fi
