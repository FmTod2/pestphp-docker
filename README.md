# PestPHP Docker Image

This repository provides a Docker environment for running [PestPHP](https://pestphp.com/) tests on different projects.

## Usage

To run the PestPHP tests in your project, you can use the following command:

```sh
bash <(curl -fsSL https://fmtod.com/pest.php)
```

You can pass additional arguments to the `run.sh` script to customize the behavior:

```sh
bash <(curl -fsSL https://fmtod.com/pest.php) --help
```

### Test Coverage

To generate a code coverage report, run the following command:

```sh
bash <(curl -fsSL https://fmtod.com/pest.php) --coverage
```

To generate code coverage in HTML format run the following command

```sh
bash <(curl -fsSL https://fmtod.com/pest.php) --coverage-html "build/coverage" ./tests/
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
