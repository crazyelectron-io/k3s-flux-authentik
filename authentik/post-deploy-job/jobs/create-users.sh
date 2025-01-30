#!/bin/bash

echo ".......... Installing Required Packages ............"
apt-get update
apt-get install --no-install-recommends --no-install-suggests curl jq ca-certificates -y

# Global variables
AUTHENTIK_URL="https://auth.moerman.online/api/v3"
ADMIN_USERNAME="akadmin"
ADMIN_PASSWORD="${SECRET_AUTHENTIK_BOOTSTRAP_PASSWORD}"

# --- Common functions
make_request() {
  local method=$1
  local endpoint=$2
  local data=$3
  local token=$4
  curl -v -s -X "$method" "$AUTHENTIK_URL/$endpoint" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    ${token:+-H "Authorization: Bearer $token"} \
    -d "$data"
}

echo ".......... Creating API Token ............"

# Token details
TOKEN_NAME="FluxAPIToken"
# Get an authentication token
auth_response=$(make_request "POST" "auth/token/" '{"username": "$ADMIN_USERNAME", "password": "$ADMIN_PASSWORD"}')
echo "Response: $auth_response"
auth_token=$(echo $auth_response | jq -r '.token')
echo "Bearer token: $auth_token"
