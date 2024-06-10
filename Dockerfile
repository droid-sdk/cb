# Use the official Ubuntu image as a base image
FROM ubuntu:rolling

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Create and change to the app directory
WORKDIR WORKDIR /usr/src/app

# Expose the port the app runs on
EXPOSE 3000

# Define environment variable
ENV PORT 3000

# Run bot script:
CMD bash /home/startbot.sh
