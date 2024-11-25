#!/usr/bin/env sh

# Ensure we exit on errors
set -e

# Define paths
LOCAL_PEST="./vendor/bin/pest"
GLOBAL_PEST=$(command -v pest)

# Install composer dependencies if composer.json is present
if [[ -f "composer.json" ]]; then
    echo "composer.json found. Installing dependencies..."
    composer install --no-interaction --no-progress --optimize-autoloader
else
    echo "No composer.json found. Skipping dependency installation."
fi

# Determine which Pest binary to use
if [[ -x "$LOCAL_PEST" ]]; then
    echo "Using local Pest binary."
    PEST_BINARY="$LOCAL_PEST"
elif [[ -n "$GLOBAL_PEST" ]]; then
    echo "Local Pest binary not found. Using global Pest binary."
    PEST_BINARY="$GLOBAL_PEST"
else
    echo "Error: Pest binary not found."
    exit 1
fi

# Execute Pest with any arguments passed to the script
exec "$PEST_BINARY" "$@"

