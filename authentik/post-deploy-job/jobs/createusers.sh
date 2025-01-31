#!/bin/bash

echo ".......... Installing Required Packages ............"
apt-get update
apt-get install --no-install-recommends --no-install-suggests curl jq ca-certificates -y

# --- Global variables
AUTHENTIK_URL="https://auth.moerman.online/api/v3"
# API_TOKEN is passed in environment variable

# --- Common functions

# Function to make API requests
make_request() {
  local method=$1
  local endpoint=$2
  local data=$3
  curl -v -s -X "$method" "$AUTHENTIK_URL/$endpoint" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -H "Authorization: Bearer $API_TOKEN" \
    -d "$data"
}

# Function to create a group
create_group() {
  local name=$1
  local parent_id=$2
  make_request "POST" "core/groups/" '{"name": "$name", "parent": "$parent_id"}'
  group_id=$(echo $response | jq -r '.id')
  echo $group_id
}

echo ".......... Creating Groups ............"

# familie_group_id=$(create_group "Familie" "")
grafana_group_id=$(create_group "GrafanaAdmin" "")
# echo "Familie group ID: $familie_group_id"
echo "Grafana group ID: $grafana_group_id"