# A node.js v8 box
FROM node:8.9
 
# Create a working directory 
RUN mkdir -p /home/node/app
 
# Switch to working directory
WORKDIR /home/node/app
 
# Copy contents of local folder to `WORKDIR`
# You can pick individual files based on your need
COPY . .

# Install nodemon globally
RUN npm install -g nodemon
 
# Install dependencies (if any) in package.json
RUN npm install
 
# Expose port from container so host can access 3000 and 9229 debug
EXPOSE 3000 9229
 
# Debug the Node.js app on load
CMD [ "npm", "run", "debug" ]

# Run without debug
#CMD [ "npm", "start" ]
