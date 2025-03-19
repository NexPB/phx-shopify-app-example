#!/bin/bash

# Navigate to the phoenix directory
cd ./../phx

# Available environment variables
# https://shopify.dev/docs/apps/build/cli-for-apps/migrate-to-latest-cli#provided-variables
echo "[start.sh] Served from: '$HOST'"
echo "[start.sh] Enabled API scopes: '$SCOPES'"

# Start the Phoenix server
mix phx.server
