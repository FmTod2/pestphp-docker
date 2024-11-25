#!/usr/bin/env bash

# Exit on errors
set -e

# Default Pest version
PEST_VERSION="3-latest"

# Check if composer.json exists
if [ -f "composer.json" ]; then
    echo "composer.json found. Detecting Pest version..."
    
    # Extract the Pest version from composer.json
    PEST_VERSION_DETECTED=$(grep -Po '"pestphp/pest":\s*"\^?\K[0-9]+' composer.json | head -n 1)
    
    if [ -n "$PEST_VERSION_DETECTED" ]; then
        PEST_VERSION="$PEST_VERSION_DETECTED-latest"
        echo "Detected Pest version: $PEST_VERSION_DETECTED"
    else
        echo "Pest version not found in composer.json. Using default: $PEST_VERSION"
    fi
else
    echo "No composer.json found. Using default Pest version: $PEST_VERSION"
fi

# Parse options, including combined ones like -it and -ti
DOCKER_OPTIONS=""
PEST_ARGS=""
while [[ "$1" == -* ]]; do
    case "$1" in
        -*i*t*|-*t*i*) DOCKER_OPTIONS="$DOCKER_OPTIONS -it" ;;  # Handle combined -it or -ti
        -*i*) DOCKER_OPTIONS="$DOCKER_OPTIONS -i" ;;            # Handle -i in combined or alone
        -*t*) DOCKER_OPTIONS="$DOCKER_OPTIONS -t" ;;            # Handle -t in combined or alone
        *) PEST_ARGS="$PEST_ARGS $1" ;;                         # Collect other arguments for Pest
    esac
    shift
done

# Collect any remaining arguments as Pest arguments
PEST_ARGS="$PEST_ARGS $@"

# Run the Docker container with the determined Pest version and options
echo "Running Pest in Docker with version: $PEST_VERSION"
docker run --rm $DOCKER_OPTIONS -v "$(pwd):/app" "fmtod/pestphp:$PEST_VERSION" $PEST_ARGS