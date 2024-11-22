# **Pest PHP Docker Image**

A lightweight, flexible, and optimized Docker image for running the [Pest PHP Testing Framework](https://pestphp.com). This image supports both Pest v2 and v3, making it ideal for use in CI/CD pipelines and local development environments.



## **Features**
- **Base Image:** `serversideup/php:8.2-cli-alpine` for minimal and fast builds.
- **Support for Pest Versions:** 
  - `latest`, `3`: Pest v3
  - `2`: Pest v2
- **PHP Extensions:** Pre-installed extensions commonly used for testing:
  - `bcmath`, `mbstring`, `pdo_mysql`, `pcntl`, `gd`, `intl`, `soap`, `exif`, `gd`, `imagick`, `igbinary`, `redis`, `opcache`, `zip`.
- **Pre-configured PHP Development Environment:**
  - Uses `php.ini-development` as the default configuration.
  - Enables `XDEBUG_MODE=coverage,debug` by default.
- **CI/CD Ready:** Built for seamless integration with GitHub Actions and other CI tools.



## **Tags**
The Docker image is available on Docker Hub under the repository: **`myorg/pest-php`**

Tag:

  `latest`: Default, supports Pest v3
  `3`: Specifically for Pest v3
  `2`: Specifically for Pest v2



## **Quick Start**

### **Run Tests Locally**
Run your Pest tests locally with the following command:

```bash
docker run --rm -v $(pwd):/app -w /app myorg/pest-php:latest php artisan test
```

### **Switching Pest Versions**
To use Pest v2 instead of v3:

```bash
docker run --rm -v $(pwd):/app -w /app myorg/pest-php:2 php artisan test
```



## **Using in CI/CD Pipelines**

### **GitHub Actions Workflow Example**

Here’s an example workflow to run Pest tests using this Docker image:

```yaml
name: "🐋 Build and Push Pest PHP Docker Image"

on:
  workflow_dispatch:  # Permite ejecución manual
  release:
    types: [published, prereleased, released, created]  # Se ejecuta al publicar una release

concurrency:
  group: ci-release-build
  cancel-in-progress: true

permissions:
  contents: write  # Permisos necesarios para manejar releases
  packages: write  # Permisos para publicar en DockerHub

jobs:
  build:
    name: 'Build and Push Docker Image for Pest PHP'
    runs-on: ubuntu-latest
    steps:
      # Metadatos para las etiquetas de la imagen
      - name: Docker Meta
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: |
            myorg/pest-php
          tags: |
            type=ref,event=branch
            type=semver,pattern={{version}}
            type=semver,pattern={{major}}.{{minor}}
            type=semver,pattern={{major}}
            latest

      # Clonar el código fuente
      - name: Checkout Code
        uses: actions/checkout@v4

      # Configurar soporte para QEMU (para soportar arquitecturas cruzadas)
      - name: Set up QEMU
        uses: docker/setup-qemu-action@v2

      # Configurar Docker Buildx (para mejorar el proceso de build)
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      # Iniciar sesión en DockerHub
      - name: Login to DockerHub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      # Construir y subir la imagen a DockerHub
      - name: Build and Push Docker Image
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          cache-from: type=gha
          cache-to: type=gha,mode=max
```

### **Custom PHP Extensions**
If additional extensions are needed for specific workflows, you can extend this image in your CI pipeline or modify the Dockerfile directly.



## **Building the Image**

### **Build Locally**
To build the image locally with a specific Pest version:

```bash
docker build --build-arg PEST_VERSION=2 -t myorg/pest-php:2 .
docker build --build-arg PEST_VERSION=3 -t myorg/pest-php:3 .
```

### **Run Tests Locally**
Use the built image to run your tests:

```bash
docker run --rm -v $(pwd):/app -w /app myorg/pest-php:3 php artisan test
```
