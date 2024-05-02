# Use an official Node runtime as the base image
FROM node:18-alpine

# Set the working directory in the container to /frontend
WORKDIR /frontend

# Copy package.json and package-lock.json before other files
# Utilise Docker cache to save re-installing dependencies if unchanged
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the current directory contents into the container at /frontend
COPY . .

# Make the build of the application
RUN npm run build

# Install serve module globally
RUN npm install -g serve

# The app is served by serve, so ensure it's exposed
EXPOSE 3000

# Define the command to run the app using CMD which defines your runtime
# Here we use the serve package to serve the build directory
CMD ["serve", "-s", "build"]