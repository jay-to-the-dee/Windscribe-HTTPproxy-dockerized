#!/bin/bash

# User greeting
echo "Welcome to Windscribe HTTP proxy!"
echo "WINDSCRIBE_COUNTRY set to: ${WINDSCRIBE_COUNTRY}"
echo "HOST_PORT set to: ${HOST_PORT}"

# For OpenVPN operation
mkdir -p /dev/net
mknod /dev/net/tun c 10 200

# Start windscribe service
/etc/init.d/windscribe-cli start #"Starting windscribe ... OK\n"
read WINDSCRIBE_PID < /etc/windscribe/windscribe.pid
echo "Windscribe service started on container PID ${WINDSCRIBE_PID}"

if [ -z "$WINDSCRIBE_USERNAME" ] || [ -z "$WINDSCRIBE_PASSWORD" ];
then
    # Login interactively (requires interactive shell)
    windscribe login
else
    # Simulate "interactive" login
    expect << EOF
    spawn windscribe login
    expect "Windscribe Username: "
    send "${WINDSCRIBE_USERNAME}\n"
    expect "Windscribe Password: "
    send "${WINDSCRIBE_PASSWORD}\n"
    expect eof
EOF
fi

# Print users account info
windscribe account

# Final config tweaks possible now logged in
#windscribe firewall off #Proxy operation does not require this be disabled so we'll leave as is
windscribe protocol tcp #We switch this as it may potentially work better over some NAT configurations
windscribe connect ${WINDSCRIBE_COUNTRY}

# Start tinyproxy HTTP proxy service
echo "Starting HTTP proxy on host port ${HOST_PORT} (HOST_PORT)..."
# Wait for tinyproxy daemon (hopefully forever) else docker dies :(
/usr/sbin/tinyproxy -d

