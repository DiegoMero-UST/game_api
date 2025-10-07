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

# Check if database is available before running migrations
if bin/rails runner "puts 'Database connection successful'" 2>/dev/null; then
  echo "Database available, running migrations..."
  bin/rails db:migrate
  bin/rails db:seed
else
  echo "Database not available during build, skipping migrations"
  echo "Migrations will run at runtime"
fi