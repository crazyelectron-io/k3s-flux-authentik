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
  curl -v -s -X "$method" "$AUTHENTIK_URL/core/$endpoint/" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -H "Authorization: Bearer $API_TOKEN" \
    -d "$data"
}

echo ".......... Creating Groups ............"

response=$(make_request POST groups '{"name": "Familie", "parent": null}')
echo "Response: $response"
familie_group_id=$(echo $response | jq -r '.pk')
response=$(make_request POST groups '{"name": "GrafanaAdmin", "parent": null}')
echo "Response: $response"
grafana_group_id=$(echo $response | jq -r '.pk')
echo "Familie group ID: $familie_group_id"
echo "Grafana group ID: $grafana_group_id"

echo ".......... Creating Users ............"

response=$(make_request POST users "{\"username\": \"ronmoerman\",\"name\": \"Ron\",\"is_active\": true,\"last_login\": null,\"groups\": [\"$familie_group_id\",\"$grafana_group_id\"],\"email\": \"ron@moerman.online\",\"attributes\": {},\"path\": \"users\",\"type\": \"internal\"}")
echo "Response: $response"
user1_id=$(echo $response | jq -r '.pk')
response=$(make_request POST users/:$user1_id/set-password/ '{"password": "${USER1_PASSWORD}"}')
echo $reponse
response=$(make_request POST users "{\"username\": \"arnielmoerman\",\"name\": \"Arniël\",\"is_active\": true,\"last_login\": null,\"groups\": [\"$familie_group_id\"],\"email\": \"arniel@moerman.online\",\"attributes\": {},\"path\": \"users\",\"type\": \"internal\"}")
echo "Response: $response"
user1_id=$(echo $response | jq -r '.pk')
response=$(make_request POST users/:$user2_id/set-password/ "{\"password\": \"${USER2_PASSWORD}\"}")
echo $reponse

response=$(make_request POST users "{\"username\": \"mennomoerman\",\"name\": \"Menno\",\"is_active\": true,\"last_login\": null,\"groups\": [\"$familie_group_id\"],\"email\": \"mennonm20@gmail.com\",\"attributes\": {},\"path\": \"users\",\"type\": \"internal\"}")
echo "Response: $response"
user1_id=$(echo $response | jq -r '.pk')
