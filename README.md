# Claude Code Docker Setup

Run [Claude Code](https://claude.ai/code) in an isolated Docker container.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) with Docker Compose
- An Anthropic API key **or** Azure AI Foundry credentials

## Setup

**1. Copy the example env file and fill in your credentials:**

```bash
cp .env.example .env
```

Edit `.env`:

**2. Build and run:**

```bash
docker compose up --build --remove-orphans -d && docker compose exec -it claude claude
```

This drops you into an interactive Claude Code session inside the container.

## Usage

On subsequent runs (after the image is built):

```bash
docker compose up -d --build && docker compose exec -it claude claude
```

Place any files you want Claude to work with inside the `data/` directory — they will be available at `/workspace` inside the container.

## Notes

- `DISABLE_TELEMETRY=1` is set by default to prevent usage data from being sent.
- The `USER_ID` build arg ensures file permissions in the mounted `data/` volume match your host user. Run `id -u` on your machine to get the correct value.
