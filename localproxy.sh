#!/bin/bash

source ./vars.sh

IMAGE_NAME="dilks/windscribe-httpproxy"
DNS1="1.1.1.1"
DNS2="1.0.0.1"

docker run --rm -d \
--cap-add=NET_ADMIN \
--env WINDSCRIBE_COUNTRY="$WINDSCRIBE_COUNTRY" \
--env WINDSCRIBE_USERNAME \
--env WINDSCRIBE_PASSWORD \
-p $LOCAL_PORT:8888 \
--dns "${DNS1}" \
--dns "${DNS2}" \
"${IMAGE_NAME}"
