#!/bin/bash
set -e

export RAILS_ENV=development
BOOTSTRAP_FLAG="/app/.spina_bootstrapped"

# Generate Rails app and install Spina (first boot only)
if [ ! -f "$BOOTSTRAP_FLAG" ]; then
  echo "==> Generating Rails app..."
  bundle exec rails new /app \
    --database=postgresql \
    --skip-git \
    --skip-test \
    --skip-bundle \
    --force

  echo "gem 'spina'" >> /app/Gemfile

  cd /app && bundle install

  # Create database.yml after rails new (which overwrites it)
  cat > /app/config/database.yml <<EOF
default: &default
  adapter: postgresql
  encoding: unicode
  host: <%= ENV.fetch("DATABASE_HOST", "db") %>
  username: <%= ENV.fetch("DATABASE_USER", "postgres") %>
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: spinaapp_development
EOF

  bundle exec rails db:create
  bundle exec rails active_storage:install

  bundle exec rails spina:install <<EOF
My Website
default
admin@spina.com
password
EOF

  bundle exec rails db:migrate

  touch "$BOOTSTRAP_FLAG"
  echo ""
  echo " Homepage:   http://127.0.0.1:3000"
  echo " Admin page: http://127.0.0.1:3000/admin"
  echo " Login:      admin@example.com / password"
  echo ""
fi

# Remove stale pid then start server
cd /app
rm -f tmp/pids/server.pid
exec "$@"