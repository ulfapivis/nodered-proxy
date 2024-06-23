# Use Alpine Linux as the base image
FROM nodered/node-red:3.1.11-18

USER root
# Set environment variables for Node-RED plugins
# These should be set in the Render dashboard
ENV CUSTOM_NODES=${CUSTOM_NODES}
ENV NODE_RED_USERNAME=${NODE_RED_USERNAME}
ENV NODE_RED_PASSWORD=${NODE_RED_PASSWORD}
ENV NODE_RED_CREDENTIAL_SECRET=${NODE_RED_CREDENTIAL_SECRET}
ENV ALLOWED_IPS=${ALLOWED_IPS}

# # Copy the settings.js file into the container
COPY settings.js /settings.js
RUN chmod +x /settings.js
#COPY custom_nodes.sh /data/custom_nodes.sh
#RUN chmod +x /data/custom_nodes.sh

COPY passwordUtils.js /passwordUtils.js
RUN chmod +x /passwordUtils.js

COPY start.sh /start.sh
RUN chmod +x /start.sh
# Install necessary programs and npm packages
RUN apk add --no-cache tini && \
    npm install -g npm@latest && \
    npm cache clean --force


# Set up the Express server as a reverse proxy
COPY express-proxy-server.js /express-proxy-server.js
RUN npm install express http-proxy-middleware helmet cors

# # Copy the start script into the container
# COPY start.sh /data/start.sh

# # Give execute permissions to the start script
# RUN chmod +x /data/start.sh

# Start Node-RED with Tini to handle proper process termination
ENTRYPOINT ["/sbin/tini", "--"]

# Start both Node-RED and the Express proxy server using the start script
CMD ["/bin/bash", "-c", "/start.sh"]
