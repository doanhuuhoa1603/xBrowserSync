FROM node:8.12-alpine

# Set environment variables
ENV XBROWSERSYNC_API_VERSION 1.1.13

WORKDIR /usr/src/api
RUN apk add g++ make python

# Download release and unpack
RUN wget -q -O release.tar.gz https://github.com/xBrowserSync/api/archive/v$XBROWSERSYNC_API_VERSION.tar.gz \
	&& tar -C . -xzf release.tar.gz \
	&& rm release.tar.gz \
	&& mv api-$XBROWSERSYNC_API_VERSION/* . \
	&& rm -rf api-$XBROWSERSYNC_API_VERSION/

COPY settings.json /usr/src/api/config/settings.json

# Install dependencies
RUN npm install --only=production --unsafe-perm

# Expose port and start api
EXPOSE 8080
CMD [ "node", "dist/api.js"]
