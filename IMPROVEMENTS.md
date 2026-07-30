# 🚀 Productionizing the Docker Example Voting App

This project is a production-ready implementation of Docker's **Example Voting App**. The original sample application was enhanced by applying containerization, security, and DevOps best practices commonly used in production environments.

The objective was not to change the application's functionality but to improve its **security, maintainability, scalability, and deployment readiness**.

---

# 🏗️ Architecture

```
                           Browser
                              │
                     http://localhost
                              │
                     Nginx Reverse Proxy
                 ┌────────────┴────────────┐
                 │                         │
          Vote Service              Result Service
              │                           │
              └─────────────┬─────────────┘
                            │
                     Redis & PostgreSQL
                            │
                      Worker Service
```

---

# ✨ Improvements Summary

| Original Application | Production Improvements |
|----------------------|-------------------------|
| Single-stage Dockerfiles | Multi-stage Docker builds |
| Root user containers | Non-root user execution |
| Development volume mounts | Immutable production images |
| Debug ports exposed | Production-only configuration |
| Direct service access | Nginx Reverse Proxy |
| Large Docker build context | Optimized `.dockerignore` |
| Custom health scripts | Native health checks |
| No centralized routing | Reverse proxy with URL routing |

---

# 🔒 Security Improvements

## Non-root Containers

All application containers now execute using dedicated non-root users.

**Benefits**

- Reduced attack surface
- Limits privilege escalation
- Follows container security best practices

---

## Minimal Runtime Images

Multi-stage Docker builds remove unnecessary build dependencies from runtime images.

Benefits include:

- Smaller runtime footprint
- Fewer packages to maintain
- Lower vulnerability count

---

## Production Configuration

Removed development-only features including:

- Volume mounts
- Nodemon
- Debug ports
- Development entrypoints

Production containers are immutable and self-contained.

---

# ⚡ Performance Improvements

## Multi-stage Docker Builds

Each application now follows a builder/runtime pattern.

Benefits:

- Cleaner production images
- Smaller runtime layers
- Better Docker layer caching

---

## Docker Layer Optimization

Dockerfiles were restructured to maximize cache reuse.

Dependency installation is separated from application source.

This significantly speeds up rebuilds during development.

---

## Optimized Build Context

Added `.dockerignore` files for every service.

Excluded:

- IDE files
- Build artifacts
- Logs
- Git metadata
- Python cache
- .NET build output
- Node modules

Benefits:

- Faster builds
- Smaller build context
- Better cache efficiency

---

# 🌐 Nginx Reverse Proxy

Introduced an Nginx reverse proxy as the application's single entry point.

Features:

- Centralized routing
- URL rewriting
- Reverse proxy
- Health-aware startup ordering

Current routes:

```
/        → Result Service
/vote/   → Vote Service
```

---

# ❤️ Health Checks

Replaced custom health scripts with native commands.

| Service | Health Check |
|----------|--------------|
| Redis | `redis-cli ping` |
| PostgreSQL | `pg_isready` |

Benefits:

- Simpler configuration
- Faster startup validation
- More reliable container orchestration

---

# 📦 Docker Image Optimization

Implemented:

- Multi-stage builds
- Alpine/slim base images
- Layer optimization
- Build cache improvements

Final image sizes:

| Service | Image Size |
|----------|-----------:|
| Vote | **232 MB** |
| Result | **261 MB** |
| Worker | **296 MB** |

## 📦 Container Image Comparison

| Service | Original Image | Optimized Image | Improvement |
|----------|---------------:|----------------:|------------:|
| Vote | 230 MB | 232 MB | Comparable size with improved security |
| Result | 321 MB | 261 MB | **Reduced by ~60 MB (≈19%)** |
| Worker | 288 MB | 296 MB | Comparable size with improved security |

### Key Takeaways

- The **Result** service achieved the largest reduction by switching to an Alpine-based runtime and using a multi-stage Docker build.
- The **Vote** and **Worker** services were already based on lightweight runtime images, so the primary improvements were in security, image cleanliness, and maintainability rather than dramatic size reduction.

---

# 📂 Project Structure

```
example-voting-app/

├── vote/
│   ├── Dockerfile
│   └── .dockerignore
│
├── result/
│   ├── Dockerfile
│   └── .dockerignore
│
├── worker/
│   ├── Dockerfile
│   └── .dockerignore
│
├── nginx/
│   └── nginx.conf
│
├── docker-compose.yml
├── README.md
├── IMPROVEMENTS.md
└── docs/
```

---

# 🛠️ Challenges Encountered

One of the most interesting challenges during this project was implementing **path-based routing** using Nginx.

The applications were originally designed to run from the root path (`/`).

Introducing:

```
/vote/
/result/
```

caused issues including:

- Missing CSS
- Missing JavaScript
- Static asset failures
- Socket.IO routing issues

The issue was investigated by analysing:

- Docker networking
- Docker DNS
- Express routing
- Flask routing
- Nginx URI rewriting
- `proxy_pass` behaviour
- Browser network requests

The final implementation uses:

- URL rewriting
- Static asset routing
- HTML response rewriting (`sub_filter`)

This closely mirrors the type of troubleshooting required in production reverse proxy deployments.

---

# 🚀 Running the Project

Build images

```bash
docker compose build
```

Start

```bash
docker compose up -d
```

View logs

```bash
docker compose logs -f
```

Stop

```bash
docker compose down
```

---

# 📚 Lessons Learned

During this project I gained practical experience with:

- Docker multi-stage builds
- Docker layer caching
- Non-root containers
- Docker networking
- Docker DNS
- Production Dockerfiles
- Reverse proxies
- Nginx routing
- URL rewriting
- Static asset proxying
- Health checks
- OCI image labels
- Container security best practices

---

# 🛣️ Roadmap

Upcoming enhancements include:

- [ ] Custom Domains
- [ ] HTTPS with self-signed certificates
- [ ] Kubernetes deployment
- [ ] GitHub Actions CI/CD

---

# 🎯 Goal

The objective of this project is to progressively transform a simple Docker sample application into a production-grade deployment by applying modern DevOps engineering practices.

Each enhancement reflects techniques commonly used in real-world environments and serves as a foundation for the next stage of the project—deploying the application on Kubernetes with Helm and GitOps.