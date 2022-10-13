#!/usr/bin/env bash

source ./secrets.sh

COMPASS_PATH="/Applications/MongoDB Compass Dev.app/Contents/MacOS/MongoDB Compass Dev"

# The cluster we are going to lookup in Bitwarden
CLUSTER="Atlas Cluster Demo"

# Login to bitwarden
echo "Logging in with Bitwarden"
bw login --apikey
# Get a session id

echo "Unlocking Bitwarden vault"
export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)

# Get URI, Username and Password from vault
echo "Getting credentials"
URI=$(bw get uri $CLUSTER)
USER=$(bw get username $CLUSTER)
PASSWORD=$(bw get password $CLUSTER)

# Build the connection string by replacing <user> and <password>
# placeholders in the URI
CONNECTION_STRING=${URI//<user>/$USER}
CONNECTION_STRING=${CONNECTION_STRING//<password>/$PASSWORD}

echo "Launching Compass"
"$COMPASS_PATH" $CONNECTION_STRING &

# Lock vault
echo "Locking Bitwarden vault"
bw lock

