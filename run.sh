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

# Run the Docker container with the determined Pest version
echo "Running Pest in Docker with version: $PEST_VERSION"
docker run --rm -it -v "$(pwd):/app" "fmtod/pestphp:$PEST_VERSION" "$@"

