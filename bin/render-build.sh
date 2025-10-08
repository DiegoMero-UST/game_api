#!/usr/bin/env bash
# bin/render-build.sh

set -o errexit

echo "=== Installing gems ==="
bundle install

echo "=== Skipping asset precompilation (API-only app) ==="
# No assets pipeline for API-only Rails apps, so skip these
# If you leave these lines, Render will fail with 'Unrecognized command "assets:precompile"'
# bin/rails assets:precompile
# bin/rails assets:clean

echo "=== Running database migrations ==="
bundle exec rails db:migrate

echo "=== Seeding the database ==="
bundle exec rails db:seed

echo "=== Build completed successfully ==="
