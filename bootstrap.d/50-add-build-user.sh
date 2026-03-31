# shellcheck shell=dash

BOOTSTRAP_BUILD_UID=${BOOTSTRAP_BUILD_UID:-55555}
BOOTSTRAP_BUILD_GID=${BOOTSTRAP_BUILD_GID:-55555}
BOOTSTRAP_BUILD_SHELL=${BOOTSTRAP_BUILD_SHELL:-/bin/bash}
BOOTSTRAP_BUILD_GECOS=${BOOTSTRAP_BUILD_GECOS:-Build User}
BOOTSTRAP_BUILD_UNAME=${BOOTSTRAP_BUILD_UNAME:-build}
BOOTSTRAP_BUILD_GNAME=${BOOTSTRAP_BUILD_GNAME:-build}
BOOTSTRAP_BUILD_DIR=${BOOTSTRAP_BUILD_DIR:-/build}

echo -n "Adding build user ${BOOTSTRAP_BUILD_UNAME}..." &&
    addgroup --gid "${BOOTSTRAP_BUILD_GID}" "${BOOTSTRAP_BUILD_GNAME}" &&
    adduser \
        --uid "${BOOTSTRAP_BUILD_UID}" \
        --gid "${BOOTSTRAP_BUILD_GID}" \
        --shell "${BOOTSTRAP_BUILD_SHELL}" \
        --gecos "${BOOTSTRAP_BUILD_GECOS}" \
        --disabled-password \
        --disabled-login \
        --quiet \
        "${BOOTSTRAP_BUILD_UNAME}" &&
    mkdir -p "${BOOTSTRAP_BUILD_DIR}" &&
    chown "${BOOTSTRAP_BUILD_UNAME}:${BOOTSTRAP_BUILD_GNAME}" "${BOOTSTRAP_BUILD_DIR}" &&
    echo "done!"
