# Stage 1 — Build
FROM python:3.11-slim as build

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements first for caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2 — Production
FROM python:3.11-slim

# Install curl
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*
    
WORKDIR /app

# Copy installed dependencies from build stage
COPY --from=build /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=build /usr/local/bin /usr/local/bin

# Copy application code
COPY . .

# non-root user setup
RUN groupadd -g 1001 appgroup && \
    useradd -u 1001 -g appgroup -M -s /usr/sbin/nologin appuser && \
    chown -R 1001:1001 /app
USER 1001
# Expose port
EXPOSE 80

# Set environment variable for production
ENV PYTHONUNBUFFERED=1
ENV ENV=production

# Start Uvicorn via Gunicorn for production
# CMD ["gunicorn", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "app:app", "-b", "0.0.0.0:80", "--timeout", "120"]
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80", "--log-file", "-", "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]
