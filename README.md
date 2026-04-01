# Spina CMS Dockerized

Local development environment for [Spina CMS](https://spinacms.com). Bootstraps automatically on first boot — no local Ruby, Rails, or PostgreSQL needed, just Docker.

## Prerequisites

Docker Engine with the Compose plugin installed. [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Mac/Windows) includes both. Linux users can follow the [Docker Engine install guide](https://docs.docker.com/engine/install/).

## Setup

```bash
docker compose build
docker compose up
```

First boot takes ~2-3 minutes. The app is ready when you see `* Listening on http://0.0.0.0:3000` in the logs.

| | URL |
|--|--|
| Homepage | http://127.0.0.1:3000 |
| Admin Page | http://127.0.0.1:3000/admin |

Default login: `admin@spina.com` / `password`

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
docker compose exec -e RAILS_ENV=development web rails runner "puts Spina::User.all.map(&:email)"
```
