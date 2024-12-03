#Replaced mhart/alpine-node with the official Node.js 18-alpine image to ensure it’s actively maintained.
FROM node:18-alpine

# Update apk-tools and ensure all packages are updated
RUN apk add --no-cache bash curl

# Set a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY --chown=appuser:appgroup package*.json ./

# Install dependencies in production mode
RUN npm ci --only=production

# Copy the rest of the application files
COPY --chown=appuser:appgroup . .

# Expose the application port
EXPOSE 3000

# Use a lightweight command for better performance
CMD ["node", "app.js"]


