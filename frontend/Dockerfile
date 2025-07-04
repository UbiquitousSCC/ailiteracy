# Name the node stage "builder"
FROM node:22.16.0 AS builder
# Set working directory
WORKDIR /app
# Copy package files first for better caching
COPY package*.json ./
# Install dependencies
RUN npm install
# Copy all files
COPY . .

# 接收建置時的環境變數
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

# Build the app
RUN chmod a+x node_modules/.bin/react-scripts
RUN npm run build

# nginx stage for serving content
FROM nginx:alpine
# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*
# Copy static assets from builder stage
COPY --from=builder /app/build .

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]