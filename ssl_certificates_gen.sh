#!/bin/bash

# Generate SSL certificates if they don't exist
if [ ! -f /app/config/ssl/server.key ]; then
  mkdir -p /app/config/ssl
  openssl req -newkey rsa:2048 -nodes -keyout /app/config/ssl/server.key -x509 -days 365 -out /app/config/ssl/server.crt -subj "/CN=localhost"
fi

bin/rails s -e production -b '0.0.0.0'
