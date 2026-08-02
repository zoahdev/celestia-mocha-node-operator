#!/usr/bin/env bash
set -euo pipefail

STORE="${CELESTIA_STORE:-/home/nodeops/.celestia-light-mocha-4}"
CELESTIA="${CELESTIA_BIN:-/usr/local/bin/celestia}"

systemctl is-active --quiet celestia-node.service
runuser -u nodeops -- env HOME=/home/nodeops "$CELESTIA" header network-head --node.store "$STORE" >/dev/null
runuser -u nodeops -- env HOME=/home/nodeops "$CELESTIA" p2p peers --node.store "$STORE" >/dev/null

echo "Celestia Mocha health check passed at $(date --iso-8601=seconds)"
