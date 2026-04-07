# Spina CMS Dockerized

Local development environment for [Spina CMS](https://spinacms.com). 
No local Ruby, Rails, or PostgreSQL needed — just Docker.

## Prerequisites

Docker Engine with the Compose plugin installed. [Docker Desktop](https://www.docker.com/products/docker-desktop/) 
(Mac/Windows) includes both. Linux users can follow the 
[Docker Engine install guide](https://docs.docker.com/engine/install/).

## Setup
```bash
git clone https://github.com/bluebke/spina-project.git
cd spina-project
docker compose build
docker compose up
```

The app is ready when you see `* Listening on http://0.0.0.0:3000` in the logs.

| | URL |
|--|--|
| Homepage | http://127.0.0.1:3000 |
| Admin Page | http://127.0.0.1:3000/admin |

Default login: `admin@spina.com` / `password`

## Development

The Rails app lives in the `app/` directory and is mounted directly into the 
container via a bind mount. Any changes you make to files in `app/` are 
reflected immediately without needing to rebuild.

**Running Rails commands:**
```bash
docker compose exec web bundle exec rails console
docker compose exec web bundle exec rails generate model MyModel name:string
docker compose exec web bundle exec rails db:migrate
```

**Typical git workflow:**
```bash
git checkout -b feature/my-change
# make changes to files in app/
git add .
git commit -m "my change"
git push origin feature/my-change
# open a PR on GitHub
```

## Troubleshooting

**Changes to bootstrap.sh aren't taking effect**

The script is baked into the image at build time — rebuild after any edits:
```bash
docker compose build && docker compose down -v && docker compose up
```

**Full reset**
```bash
docker compose down -v && docker compose build --no-cache && docker compose up
```

**Check if admin user was created**
```bash
docker compose exec web bundle exec rails runner "puts Spina::User.all.map(&:email)"
```