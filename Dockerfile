FROM node:hydrogen-alpine3.20

# Set work dir:
WORKDIR /app


# Run bot script:
CMD bash /home/startbot.sh
