# Use Alpine Linux as the base image
FROM nodered/node-red:3.1.11-18

USER root
# Set environment variables for Node-RED plugins
# These should be set in the Render dashboard
# ENV CUSTOM_NODES=${CUSTOM_NODES}
# ENV NODE_RED_USERNAME=${NODE_RED_USERNAME}
# ENV NODE_RED_PASSWORD=${NODE_RED_PASSWORD}
# ENV NODE_RED_CREDENTIAL_SECRET=${NODE_RED_CREDENTIAL_SECRET}
# ENV ALLOWED_IPS=${ALLOWED_IPS}
WORKDIR /usr/src/node-red
# # Copy the settings.js file into the container
COPY settings.js /data/settings.js
RUN chmod +x /data/settings.js
#COPY custom_nodes.sh /data/custom_nodes.sh
#RUN chmod +x /data/custom_nodes.sh

COPY start.sh /start.sh
RUN chmod +x /start.sh
# Install necessary programs and npm packages
RUN npm install -g npm@latest && \
    npm cache clean --force


# Set up the Express server as a reverse proxy
#COPY express-proxy-server.js /express-proxy-server.js
#RUN npm install express http-proxy-middleware helmet cors bcrypt
RUN npm install cors bcrypt

USER node-red
CMD ["/bin/bash", "-c", "/start.sh"]
