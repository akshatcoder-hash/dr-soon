FROM node:20-alpine

WORKDIR /app

COPY package.json package-lock.json ./

# Install specific pnpm version
RUN npm install -g pnpm@9.5.0

# Use pnpm to install dependencies
COPY pnpm-lock.yaml ./
RUN pnpm install

COPY . .

COPY .env .

# Updated command with the character parameter
CMD ["pnpm", "start", "--character=characters/dukeofducats.character.json"]