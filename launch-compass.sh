#!/usr/bin/env bash

source ./secrets.sh

COMPASS_PATH="/Applications/MongoDB Compass Beta.app/Contents/MacOS/MongoDB Compass Beta"

# The cluster we are going to lookup in Bitwarden
CLUSTER="Atlas Cluster Demo"

# Do we want to hide the connection string from the user?
PROTECT_CONNECTION_STRING=true

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

PROTECT_CONNECTION_STRING_ARG=""
if $PROTECT_CONNECTION_STRING; then PROTECT_CONNECTION_STRING_ARG="--protectConnectionStrings"; fi

echo "Launching Compass"
"$COMPASS_PATH" $URI --username $USER --password $PASSWORD $PROTECT_CONNECTION_STRING_ARG #2>/dev/null &

# Lock vault
echo "Locking Bitwarden vault"
bw lock

