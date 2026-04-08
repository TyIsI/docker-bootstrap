#!/usr/bin/env sh

set -e

DEFAULT_SCRIPTS="${DEFAULT_SCRIPTS:-00-bootstrap-banner.sh}"

INSTALL_COMMIT="${INSTALL_COMMIT:-$(curl -s -H "Accept: application/vnd.github.VERSION.sha" "https://api.github.com/repos/TyIsI/docker-bootstrap/commits/main")}"
INSTALL_CONF_D_DIR="${INSTALL_CONF_D_DIR:-/etc/docker-bootstrap.d}"
INSTALL_SCRIPT_DIR="${INSTALL_SCRIPT_DIR:-/}"
INSTALL_SCRIPTS=$(echo "${DEFAULT_SCRIPTS} ${INSTALL_SCRIPTS} ${*}" | xargs -n1 | xargs)

if [ ! -d "${INSTALL_SCRIPT_DIR}" ]; then
    mkdir -p "${INSTALL_SCRIPT_DIR}"
fi

if [ ! -d "${INSTALL_CONF_D_DIR}" ]; then
    mkdir -p "${INSTALL_CONF_D_DIR}"
fi

INSTALL_SCRIPT_DIR=$(realpath "${INSTALL_SCRIPT_DIR}")
INSTALL_CONF_D_DIR=$(realpath "${INSTALL_CONF_D_DIR}")

(cd "${INSTALL_SCRIPT_DIR}" &&
    wget -q -O ./docker_bootstrap.sh "https://github.com/TyIsI/docker-bootstrap/raw/${INSTALL_COMMIT}/docker_bootstrap.sh" &&
    chmod 755 ./docker_bootstrap.sh) && (
    cd "${INSTALL_CONF_D_DIR}" &&
        echo "Installing default scripts" &&
        for INSTALL_SCRIPT in ${INSTALL_SCRIPTS}; do
            if ! echo "${INSTALL_SCRIPT}" | grep -q -P '^(https?|ftp):'; then INSTALL_SCRIPT="https://github.com/TyIsI/docker-bootstrap/raw/${INSTALL_COMMIT}/docker-bootstrap.d/${INSTALL_SCRIPT}"; fi

            printf "Installing %s..." "${INSTALL_SCRIPT}" &&
                wget -q "${INSTALL_SCRIPT}" &&
                echo " done!"
        done
)
