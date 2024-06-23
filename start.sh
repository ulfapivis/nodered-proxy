#!/bin/bash

# Load flow data from the environmental variable
FLOW_DATA="$NODE_RED_FLOW"
echo "Flow data received: $FLOW_DATA"

chmod 777 /data

# Copy the flow data to the /data directory
echo "$FLOW_DATA" > /data/flows.json

# Verify if the file was created
ls -l /data/flows.json

# Install custom nodes if specified
if [ -n "${CUSTOM_NODES}" ]; then
    npm install $(echo ${CUSTOM_NODES})
else
    echo "No custom nodes specified"
fi

# Start Node-RED
node-red -s /settings.js



