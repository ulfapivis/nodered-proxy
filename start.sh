#!/bin/bash

if [ -n "${CUSTOM_NODES}" ]; then
    # If not empty, install the custom nodes
    npm install $(echo ${CUSTOM_NODES})
else
    echo "No custom nodes specified"
fi

# Start Node-RED
node-red -s /settings.js &
# Start Express proxy server
# node /express-proxy-server.js &
#wait

