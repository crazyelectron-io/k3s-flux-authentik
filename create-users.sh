#!/bin/bash

echo ".......... Installing Required Packages ............"
apt-get update
apt-get install --no-install-recommends --no-install-suggests curl jq ca-certificates -y

# Global variables
AUTHENTIK_URL="https://auth.moerman.online/api/v3"
ADMIN_USERNAME="akadmin"
ADMIN_PASSWORD="${SECRET_AUTHENTIK_BOOTSTRAP_PASSWORD}"

# --- Common functions

# Function to make API requests
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

# # Function to create a group
# create_group() {
#   local name=$1
#   local parent_id=$2
#   make_request "POST" "core/groups/" '{"name": "$name", "parent": "$parent_id"}' "$API_TOKEN"
#   group_id=$(echo $response | jq -r '.id')
#   echo $group_id
# }

# # Function to create a user, add it to multiple groups and return the user_id
# create_user() {
#   local username=$1
#   local name=$2
#   local email=$3
#   shift 3
#   local groups=("@")
#   echo "... Creating user: $username ..."
#   groups_json=$(printf '%s\n' "${groups[@]}" | jq -R . | jq -s .)
#   make_request "POST" "core/users/" '{
#     "username": "$username",
#     "name": "$name",
#     "is_active": true,
#     "last_login": "",
#     "groups": $groups_json,
#     "email": "$email",
#     "attributes": {},
#     "path": "users",
#     "type": "internal"
#   }' "$API_TOKEN"
#   user_id=$(echo $response | jq -r '.id')
#   echo $user_id
# }

echo ".......... Creating API Token ............"

# Token details
TOKEN_NAME="FluxAPIToken"

# Get an authentication token
auth_response=$(make_request "POST" "auth/token/" '{"username": "$ADMIN_USERNAME", "password": "$ADMIN_PASSWORD"}')
auth_token=$(echo $auth_response | jq -r '.token')
echo "Bearer token: $auth_token"

# # Create the API token
# create_response=$(make_request "POST" "core/tokens/" '{"name": "$TOKEN_NAME", "expires": ""}' "$auth_token")
# API_TOKEN=$(echo $create_response | jq -r '.key')
# echo "API token created: $API_TOKEN"

# echo ".......... Creating Groups ............"

# familie_group_id=$(create_group "Familie" "")
# grafana_group_id=$(create_group "GrafanaAdmin" "")
# echo "Familie group ID: $familie_group_id"
# echo "Grafana group ID: $grafana_group_id"

# echo ".......... Creating Users ............"

# user1_id=$(create_user "ronmoerman" "Ron" "ron@moerman.online" "$familie_group_id" "$grafana_group_id")
# user2_id=$(create_user "arnielmoerman" "Arniël" "arniel@moerman.online" "$familie_group_id")
# user3_id=$(create_user "mennomoerman" "Menno" "mennonm20@gmail.com" "$familie_group_id")
