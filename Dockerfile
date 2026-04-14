FROM node:25-slim

# Install system dependencies Claude might need for git/file operations
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Mac's default UID (usually 501) to avoid "Permission Denied" errors on your files. To check run `id -u` on your mac
ARG USER_ID
RUN useradd -m -u ${USER_ID} claude
USER claude

# Set the workspace
WORKDIR /workspace

# Default command launches the interactive CLI
ENTRYPOINT ["claude"]