# Total Recall Memory Vacation System - Vulnerable Dockerfile
# This Dockerfile is intentionally vulnerable to demonstrate Snyk's scanning capabilities.

# Use a vulnerable and outdated Node.js base image with known vulnerabilities
FROM node:10.0.0

# Set working directory
WORKDIR /app

# Copy application files
COPY . .

# Install dependencies with a command that ignores potential vulnerabilities
RUN npm install --legacy-peer-deps

# Install vulnerable dependencies manually
RUN npm install lodash@4.17.11 && \
    npm install express@4.16.0 && \
    npm install axios@0.18.0

# Expose an application port without restricting network access
EXPOSE 3000

# Set environment variables in plaintext (vulnerable to exposure)
ENV APP_ENV=production
ENV SECRET_KEY=myveryinsecuresecretkey

# Use a vulnerable version of npm and Node.js to introduce additional security issues
RUN npm install -g npm@6.4.1

# Run as root user (not recommended)
USER root

# Copy sensitive files without proper permission handling
COPY config/secrets.json /app/config/secrets.json

# Insecure entry point
CMD ["npm", "start"]