echo "=== Trying to connect to database before migrating ==="
if bundle exec rails db:environment:set RAILS_ENV=production && bundle exec rails db:version > /dev/null 2>&1; then
  echo "=== Database connection OK. Running migrations ==="
  bundle exec rails db:migrate
  bundle exec rails db:seed
else
  echo "⚠️ Skipping migrations (no DB connection yet)"
fi
