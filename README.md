# Spina CMS — Docker Developer Environment

Local development environment for [Spina CMS](https://spinacms.com). Bootstraps automatically on first boot — no local Ruby, Rails, or PostgreSQL needed, just Docker.

## Prerequisites

[Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running. (Docker engine and compose will also work)

## Setup

```bash
docker compose build
docker compose up
```

First boot takes ~2-3 minutes. The app is ready when you see `* Listening on http://0.0.0.0:3000` in the logs.

| | URL |
|--|--|
| Site | http://127.0.0.1:3000 |
| Admin | http://127.0.0.1:3000/admin |

Default login: `admin@spina.com` / `password`

## Troubleshooting

**Full reset**
```bash
docker compose down -v && docker compose build --no-cache && docker compose up
```

**Check if admin user was created**
```bash
docker compose exec -e RAILS_ENV=development web rails runner "puts Spina::User.all.map(&:email)"
```