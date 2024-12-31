FROM node:22.6.0-slim

# Set Playwright skip flags globally
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1 \
    PLAYWRIGHT_SKIP_DEPS_INSTALL=1

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    python3 \
    make \
    g++ \
    curl \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install specific pnpm version
RUN npm install -g pnpm@9.15.2

# Copy package files
COPY package.json ./

# Install dependencies with specific flags for Playwright
RUN pnpm install \
    && pnpm rebuild \
    && pnpm store prune

# Copy application code
COPY . .

# Copy environment variables
COPY .env .

# Start command
CMD ["pnpm", "start", "--character=characters/drsoon.character.json"]