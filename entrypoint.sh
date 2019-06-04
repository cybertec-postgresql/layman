#!/usr/bin/env bash

set -e

YELLOW="\033[0;33m"
COLOR_OFF="\033[0m"

PATH_TO_BASE="/layman/"
BASE_DIRECTORY="lower/"

function warning {
	echo -e "${YELLOW}${1}${COLOR_OFF}"
}

cd "${PATH_TO_BASE}"
mkdir -p lower upper work merged
cd "${BASE_DIRECTORY}"

lowerdir=""

while read line; do
	if [[ "${line}" =~ ^[0-9]*$ ]]; then
		lowerdir+="${PATH_TO_BASE}${BASE_DIRECTORY}${line}:"
	else
		warning "${line} does not match directory pattern"
	fi
done <<< $(ls -d */ | cut -f1 -d '/' | sort --version-sort)

/usr/bin/fuse-overlayfs \
	-o lowerdir="${lowerdir::-1}",upperdir=/layman/upper,workdir=/layman/work \
	/layman/merged

while [ 1 ]; do
	sleep 0.5
done
