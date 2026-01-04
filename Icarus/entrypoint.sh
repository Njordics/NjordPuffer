#!/bin/bash
set -euo pipefail

# Environment variables (can be provided via `docker run -e ...`)
STEAM_USER=${STEAM_USER:-anonymous}
STEAM_PASS=${STEAM_PASS:-}
BRANCH=${BRANCH:-public}
SERVER_NAME=${SERVER_NAME:-"Icarus Server"}
SERVER_PASSWORD=${SERVER_PASSWORD:-}
SAVE_NAME=${SAVE_NAME:-Persistent}
MAX_PLAYERS=${MAX_PLAYERS:-8}
PORT=${PORT:-17777}
QUERY_PORT=${QUERY_PORT:-27015}
BEACON_PORT=${BEACON_PORT:-15000}

ROOT=/opt/icarus
mkdir -p "$ROOT"

# Download/install Icarus (Windows build) via steamcmd forcing Windows platform
/opt/steamcmd/steamcmd.sh +login "$STEAM_USER" "$STEAM_PASS" +force_install_dir "$ROOT" +@sSteamCmdForcePlatformType windows +app_update 2089300 -beta "$BRANCH" validate +quit

# Ensure correct permissions
chown -R root:root "$ROOT"

echo "Starting Icarus server with Wine..."

CMD_ARGS=(
  -log
  -SteamServerName="$SERVER_NAME"
  -SteamServerPassword="$SERVER_PASSWORD"
  -SaveName="$SAVE_NAME"
  -SessionName="$SAVE_NAME"
  -PORT=$PORT
  -QueryPort=$QUERY_PORT
  -BeaconPort=$BEACON_PORT
  -SteamMaxPlayers=$MAX_PLAYERS
)

exec wine "$ROOT/Icarus/Binaries/Win64/IcarusServer-Win64-Shipping.exe" "${CMD_ARGS[@]}"
