#!/usr/bin/env bash

set -o errexit

echo "Starting Rails API server..."

# Run database migrations
echo "Running database migrations..."
bundle exec rails db:migrate

# Run database seeds
echo "Running database seeds..."
bundle exec rails db:seed

# Start the Rails server
echo "Starting Rails server on port $PORT..."
bundle exec rails server -p $PORT
