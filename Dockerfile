# Stage 1: Build the Angular app using Node
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy all files to the container
COPY . .

# Install dependencies
RUN npm install

# Build the Angular app for production
RUN npm run build --configuration production

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Remove default Nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy the Angular build output to Nginx's web root
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
