# Claude Code Devcontainer (Azure AI Foundry)

Run [Claude Code](https://claude.ai/code) in an isolated devcontainer, configured for [Azure AI Foundry](https://ai.azure.com).

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- JetBrains IDE with Docker support

## Setup

**1. Copy the example env file and fill in your credentials:**

```bash
cp .devcontainer/.env.example .devcontainer/.env
```

Edit `.devcontainer/.env` with your Azure AI Foundry details:
- `ANTHROPIC_FOUNDRY_BASE_URL` — your Azure resource endpoint (e.g. `https://your-resource.services.ai.azure.com/anthropic`)
- `ANTHROPIC_FOUNDRY_API_KEY` — your Azure API key
- `ANTHROPIC_DEFAULT_SONNET_MODEL` — the model deployment name

**2. Create a workspace directory:**

```bash
mkdir data
```

Files placed in `data/` are available at `/workspace` inside the container.

**3. Open in devcontainer:**

In JetBrains: go to the .devcontainer folder, right click the devcontainer.json and choose Create Devcontainer and Mount sources.
The container will start building and open a new backend client for your container environment.
Accept the prompt to use the devcontainer configuration.

Claude Code either starts automatically when the container opens. to access, open terminal and type `claude`

## Notes

- `DISABLE_TELEMETRY=1` is set by default.
- Your `.claude/` settings folder is bind-mounted from the host, so configuration and session history persist between container restarts.
- `.devcontainer/.env` is gitignored — never commit it.
