#!/bin/bash

echo ".......... Installing Required Packages ............"
apt-get update
apt-get install --no-install-recommends --no-install-suggests curl jq ca-certificates -y
