#!/usr/bin/env bash

set -o errexit

bundle install

# Only run asset tasks if they exist (for regular Rails apps)
if bin/rails -T | grep -q "assets:precompile"; then
  echo "Running asset compilation..."
  bin/rails assets:precompile
  bin/rails assets:clean
else
  echo "Skipping asset compilation (API-only app)"
fi

# Skip all database operations during build
# Database setup will happen at runtime when the database is available
echo "Skipping database operations during build"
echo "Migrations and seeds will run at runtime"