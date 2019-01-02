#!/bin/bash

export $(grep -v '^#' .env | xargs -d '\n')

IMAGE_NAME="dilks/windscribe-httpproxy"
DNS1="1.1.1.1"
DNS2="1.0.0.1"

docker run --rm -d \
--init \
--cap-add=NET_ADMIN \
--env WINDSCRIBE_USERNAME \
--env WINDSCRIBE_PASSWORD \
--env HOST_PORT="$HOST_PORT" \
--env WINDSCRIBE_COUNTRY="$WINDSCRIBE_COUNTRY" \
-p $HOST_PORT:8888 \
--dns "${DNS1}" \
--dns "${DNS2}" \
"${IMAGE_NAME}"
