#!/bin/bash
# Load flow data from the environmental variable
FLOW_DATA="$NODE_RED_FLOW"

# Copy the flow data to the /data directory
echo "$FLOW_DATA" > /data/flow.json

if [ -n "${CUSTOM_NODES}" ]; then
    # If not empty, install the custom nodes
    npm install $(echo ${CUSTOM_NODES})
else
    echo "No custom nodes specified"
fi

# Start Node-RED
node-red -s /data/settings.js


