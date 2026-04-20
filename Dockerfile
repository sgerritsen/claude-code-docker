FROM node:25-slim

RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Create the claude user — devcontainer remaps the UID to match your host user automatically
RUN useradd -m -s /bin/bash claude
USER claude

WORKDIR /workspace

ENTRYPOINT ["claude"]