# Step 1: Build the React/Vite app
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all files and build the app
COPY . .
RUN npm run build

# Step 2: Serve the build using Nginx
FROM nginx:alpine

# Copy built files from previous stage to Nginx’s default web directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
