# PestPHP Docker Image

This repository provides a Docker environment for running [PestPHP](https://pestphp.com/) tests on different projects.

## Usage

```sh
wget -O - https://raw.githubusercontent.com/FmTod2/pestphp-image/refs/heads/main/run.sh | bash
```

## Development

### Prerequisites

- Docker
- Docker Compose (optional)

### Build the Docker Image

To build the Docker image, you can use the provided GitHub Actions workflow or build it manually.

#### Using GitHub Actions

The GitHub Actions workflow is configured to build and push the Docker image to DockerHub. You can trigger the build manually or on release.

#### Manually

To build the Docker image manually, run the following command:

```sh
docker build -t fmtod/pestphp:latest .
```

### Entrypoint Script

The `entrypoint.sh` script is used as the entry point for the Docker container. It installs the composer dependencies and determines which Pest binary to use (local or global).
