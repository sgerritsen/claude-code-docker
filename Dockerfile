FROM node:25-slim

# Install system dependencies, register the Sury PHP repo, and install Docker CLI
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    tar \
    unzip \
    zsh \
    lsb-release \
    apt-transport-https \
    gnupg2 \
    && curl -sSLo /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
       https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
       | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update && apt-get install -y \
           docker-ce-cli \
           docker-compose-plugin \
           php8.5-cli \
           php8.5-common \
           php8.5-mysql \
           php8.5-xml \
           php8.5-mbstring \
           php8.5-curl \
           php8.5-zip \
           php8.5-intl \
        && rm -rf /var/lib/apt/lists/*

# Install Composer globally (It will automatically bind to the default php8.5 binary)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install pnpm globally
RUN npm install -g pnpm@latest

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Create the claude user and explicitly set its default shell to ZSH
RUN useradd -m -s /bin/zsh claude

# Switch to the claude user to install Oh My Zsh in the correct home directory
USER claude
WORKDIR /workspace

# Install Oh My Zsh using the '--unattended' flag to prevent the script from blocking the build
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Default to zsh so the Dev Container backend spins up the right environment
CMD ["zsh"]