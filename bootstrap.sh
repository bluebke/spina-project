#!/bin/bash
set -e

export RAILS_ENV=development

echo "==> Installing gems..."
cd /app && bundle install

echo "==> Running migrations and seeding..."
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed

# Remove stale pid then start server
cd /app
rm -f tmp/pids/server.pid

echo ""
echo "  Homepage:   http://127.0.0.1:3000"
echo "  Admin page: http://127.0.0.1:3000/admin"
echo "  Login:      admin@spina.com / password"
echo ""

exec "$@"