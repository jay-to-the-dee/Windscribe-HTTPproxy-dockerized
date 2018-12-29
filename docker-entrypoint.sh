#!/bin/bash

# User greeting
echo "Welcome to Windscribe HTTP proxy!"
echo "WINDSCRIBE_COUNTRY set to: ${WINDSCRIBE_COUNTRY}"

# For OpenVPN operation
mkdir -p /dev/net
mknod /dev/net/tun c 10 200

# Start windscribe service
/etc/init.d/windscribe-cli start #"Starting windscribe ... OK\n"

if [ -z "$WINDSCRIBE_USERNAME" ] || [ -z "$WINDSCRIBE_PASSWORD" ];
then
    # Login interactively
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
windscribe firewall off #Null since IPTables is dummy
windscribe protocol tcp #May potentially work better over NAT
windscribe connect ${WINDSCRIBE_COUNTRY}

# Start tinyproxy HTTP proxy service
/etc/init.d/tinyproxy start

# Wait for ever else docker dies :(
sleep infinity
