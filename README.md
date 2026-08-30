### Hexlet tests and linter status:
[![Actions Status](https://github.com/dobro10k2/devops-engineer-from-scratch-project-74/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/dobro10k2/devops-engineer-from-scratch-project-74/actions)
[![CI/CD Pipeline](https://github.com/dobro10k2/devops-engineer-from-scratch-project-74/actions/workflows/push.yml/badge.svg)](https://github.com/dobro10k2/devops-engineer-from-scratch-project-74/actions/workflows/push.yml)

# Fastify Blog - Docker & CI/CD Infrastructure

This project demonstrates a complete containerization and Continuous Integration (CI) pipeline for a Node.js (Fastify) blog application. The infrastructure is managed using Docker Compose, providing a seamless transition from local development to a production-ready container registry.

## 🚀 Key Features & Architecture

* **Containerization:** The application is fully containerized using optimized Dockerfiles for both development and production (layer caching, `npm ci`).
* **Reverse Proxy:** Integrated **Caddy** server to provide automatic HTTPS (self-signed for local development), traffic routing, and `zstd` compression out of the box.
* **Database:** Connected to a **PostgreSQL** database running as a Docker Compose service with automated health checks (`pg_isready`).
* **Make Automation:** Streamlined developer experience using a `Makefile` to wrap complex Docker Compose commands.
* **CI/CD Pipeline:** Automated **GitHub Actions** workflow that triggers on `push`. It runs the test suite and, upon success, builds and pushes a production-ready image.
* **GitHub Container Registry (GHCR):** Instead of Docker Hub, this project utilizes GitHub Packages (`ghcr.io`) for secure, integrated, and seamless Docker image storage.

## 🛠 Technology Stack

* **Application:** Node.js (v22.12.0), Fastify
* **Database:** PostgreSQL
* **Web Server / Proxy:** Caddy
* **Infrastructure:** Docker, Docker Compose (v2)
* **CI/CD:** GitHub Actions, GitHub Container Registry

## 📂 Project Structure

* `Dockerfile` - Used for local development and testing.
* `Dockerfile.production` - Optimized multi-layer build for the production environment.
* `docker-compose.yml` - Base configuration containing the app (production image target) and database services. Used primarily for testing and CI.
* `docker-compose.override.yml` - Development configuration that mounts local volumes, exposes ports, and adds the Caddy reverse proxy.
* `.github/workflows/push.yml` - GitHub Actions pipeline configuration.
* `Makefile` - Helper commands for easy project management.

## ⚙️ Local Development Setup

### 1. Prerequisites
Ensure you have **Docker**, **Docker Compose (v2)**, and **Make** installed on your system.

### 2. Environment Variables
Create a `.env` file in the root directory based on the database configuration:

```env
DATABASE_HOST=db
DATABASE_NAME=postgres
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=password

```

### 3. Install Dependencies

Run the following command to install Node.js dependencies via Docker:

```bash
make setup

```

### 4. Start the Application

To start the local development environment (App + PostgreSQL + Caddy):

```bash
make dev

```

Once the containers are up, the application will be accessible at https://localhost (Caddy handles the reverse proxy and SSL termination).

*Note: Your browser may warn you about a self-signed certificate. This is expected for local development. Proceed to the site.*

### 5. Run Tests

To execute the test suite in an isolated Docker environment:

```bash
make test

```

## 🔄 Continuous Integration (CI)

This repository is configured with a GitHub Actions workflow. On every push to the main branch, the pipeline will:

1. Checkout the code.
2. Run the application test suite using `make ci`.
3. Authenticate with GitHub Container Registry (ghcr.io) using the built-in GITHUB_TOKEN.
4. Build the production image using `Dockerfile.production`.
5. Push the image to GHCR tagged as latest.

To use the pushed image, you can pull it directly from the registry:

```bash
docker pull ghcr.io/<YOUR_USERNAME>/<YOUR_REPOSITORY>:latest

```
