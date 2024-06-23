#!/bin/bash

# Load flow data from the environmental variable
FLOW_DATA="$NODE_RED_FLOW"
#echo "Flow data received: $FLOW_DATA"

# Copy the flow data to the /data directory
echo "$FLOW_DATA" > /data/flows.json

# Verify if the file was created
ls -l /data/flows.json

# load custom_flows.json if specified
if [ -n "${NODE_RED_FLOW_CRED}" ]; then
    echo "$NODE_RED_FLOW_CRED" > /data/flows_cred.json
else
    echo "No flows_cred.json"
fi

# Install custom nodes if specified
if [ -n "${CUSTOM_NODES}" ]; then
    npm install $(echo ${CUSTOM_NODES})
else
    echo "No custom nodes specified"
fi

# Start Node-RED
node-red -s /settings.js



