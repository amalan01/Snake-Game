# FROM mhart/alpine-node 
# COPY . /app
# CMD node /app/app.js
# EXPOSE  3000

# Use a specific version of alpine-node to avoid unexpected updates
FROM mhart/alpine-node:16

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker layer caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the desired port
EXPOSE 3000

# Define the default command to run the application
CMD ["node", "app.js"]

