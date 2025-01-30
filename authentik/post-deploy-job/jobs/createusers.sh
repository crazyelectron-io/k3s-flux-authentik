#!/bin/bash

echo ".......... Installing Required Packages ............"
apt-get update
apt-get install --no-install-recommends --no-install-suggests curl jq ca-certificates -y

# Global variables
AUTHENTIK_URL="https://auth.moerman.online/api/v3"
# API_TOKEN is passed in environment variable

# --- Common functions