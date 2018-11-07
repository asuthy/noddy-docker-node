# A node.js v8 box
FROM node:8.9

# Copy entrypoint script to container
COPY ./docker-entrypoint.sh /usr/local/bin
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

# Create and define the node_modules's cache directory.
RUN mkdir /usr/src/cache
WORKDIR /usr/src/cache

# Install the application's dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install

# Create and define the application's working directory
RUN mkdir /usr/src/app
WORKDIR /usr/src/app

# Install nodemon globally
RUN npm install -g nodemon

# Copy contents of local folder to the application's working directory
COPY . .
 
# Expose port from container so host can access 3000 and 9229 debug
EXPOSE 3000 9229

# Copy cached node modules to local volume and start in debug mode
ENTRYPOINT ["docker-entrypoint.sh"]