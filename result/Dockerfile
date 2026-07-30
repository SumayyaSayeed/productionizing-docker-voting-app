# syntax=docker/dockerfile:1.7

###############################
# Build Stage
###############################
FROM node:22.17.0-alpine3.22 AS builder

# OCI Labels
LABEL org.opencontainers.image.title="my-node-app" \
      org.opencontainers.image.description="Production Node.js Application" \
      org.opencontainers.image.version="1.0.0"

WORKDIR /app

# Copy dependency files first for layer caching
COPY package*.json ./

# Install all dependencies (including dev dependencies)
RUN --mount=type=cache,target=/root/.npm \
    npm ci

# Copy application source
COPY --link . .



###############################
# Runtime Stage
###############################
FROM node:22-alpine

WORKDIR /app

RUN apk add --no-cache tini

COPY --from=builder /app .

RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup && \
    chown -R appuser:appgroup /app

USER appuser
ENV PORT=80
EXPOSE 80

ENTRYPOINT ["/sbin/tini","--"]

CMD ["node","server.js"]