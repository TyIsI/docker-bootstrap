# shellcheck shell=dash

BANNER="docker-bootstrap v${DOCKER_BOOSTRAP_VERSION:-0.0.0}"

LEADER_LENGTH=$(((40 - ${#BANNER} - 2) / 2))

repeat() {
	local start=1
	local end=${1:-80}
	local str="${2:-=}"
	local range=$(seq $start $end)
	# shellcheck disable=SC2034
	for i in $range; do echo -n "${str}"; done
}

echo "========================================"
printf -- "=%-40s\n" "$(printf "%s %s %s\n" "$(repeat "${LEADER_LENGTH}")" "${BANNER}" "$(repeat "${LEADER_LENGTH}")")"
echo "========================================"
