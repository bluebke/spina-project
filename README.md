# Spina CMS — Docker Developer Environment

A Dockerized local development environment for [Spina CMS](https://spinacms.com), built on Ruby on Rails and PostgreSQL. On first boot the environment bootstraps itself automatically — no manual Rails or Spina setup required.

---

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running

No local Ruby, Rails, or PostgreSQL installation is needed.

---

## Project Structure

```
spina-docker/
├── Dockerfile            # Ruby 3.3 image with required system dependencies
├── docker-compose.yml    # Defines the web and db services
├── bootstrap.sh          # First-boot setup script (Rails app generation, Spina install)
├── Gemfile               # Rails 7.1 + Spina dependencies
└── .dockerignore
```

---

## Setup & Usage

### First-time setup

**1. Build the image**
```bash
docker compose build
```

**2. Start the services**
```bash
docker compose up
```

On first boot, `bootstrap.sh` will automatically:
- Generate a new Rails app
- Install Spina CMS
- Create the database and run migrations
- Create an admin user

This takes approximately 2-3 minutes. The app is ready when you see Puma start in the logs:
```
* Listening on http://0.0.0.0:3000
```

**3. Access the app**

| URL | Description |
|-----|-------------|
| http://127.0.0.1:3000 | Spina front-end |
| http://127.0.0.1:3000/admin | Spina admin panel |

**Default credentials**
- Email: `admin@example.com`
- Password: `password`

### Subsequent starts

```bash
docker compose up
```

Bootstrap only runs once. Subsequent starts go straight to the Rails server.

### Stopping the app

```bash
docker compose down
```

---

## Troubleshooting

### Changes to bootstrap.sh aren't taking effect
`bootstrap.sh` is baked into the Docker image at build time. After editing it you need to rebuild before the changes take effect:
```bash
docker compose build
docker compose down -v
docker compose up
```

### Starting fresh / full reset
To wipe everything (database, generated app, bootstrap flag) and start over:
```bash
docker compose down -v
docker compose build --no-cache
docker compose up
```

### Checking whether the admin user was created
```bash
docker compose exec -e RAILS_ENV=development web rails runner "puts Spina::User.all.map(&:email)"
```

### Opening a shell inside the web container
```bash
docker compose exec web bash
```