#!/usr/bin/env bash
set -euo pipefail

STORE="${CELESTIA_STORE:-/home/nodeops/.celestia-light-mocha-4}"
OUT_DIR="${CELESTIA_OPS_DIR:-/home/nodeops/ops}"
CSV="$OUT_DIR/node-status.csv"
LATEST="$OUT_DIR/latest-status.txt"
CELESTIA="${CELESTIA_BIN:-/usr/local/bin/celestia}"

install -d -o nodeops -g nodeops -m 0750 "$OUT_DIR"
service_state="$(systemctl is-active celestia-node.service || true)"
timestamp="$(date --iso-8601=seconds)"
disk_bytes="$(du -sb "$STORE" | awk '{print $1}')"
network_json="$(runuser -u nodeops -- env HOME=/home/nodeops "$CELESTIA" header network-head --node.store "$STORE")"
local_json="$(runuser -u nodeops -- env HOME=/home/nodeops "$CELESTIA" header local-head --node.store "$STORE")"
peers_json="$(runuser -u nodeops -- env HOME=/home/nodeops "$CELESTIA" p2p peers --node.store "$STORE")"
network_height="$(jq -r '.result.header.height // 0' <<<"$network_json")"
local_height="$(jq -r '.result.header.height // 0' <<<"$local_json")"
peer_count="$(jq -r '.result.peers | length' <<<"$peers_json")"
lag="$((network_height - local_height))"

if [[ ! -f "$CSV" ]]; then
  echo 'timestamp,service,local_height,network_height,lag,peers,disk_bytes' >"$CSV"
fi
echo "$timestamp,$service_state,$local_height,$network_height,$lag,$peer_count,$disk_bytes" >>"$CSV"
printf 'timestamp=%s\nservice=%s\nlocal_height=%s\nnetwork_height=%s\nlag=%s\npeers=%s\ndisk_bytes=%s\n' \
  "$timestamp" "$service_state" "$local_height" "$network_height" "$lag" "$peer_count" "$disk_bytes" >"$LATEST"
chown nodeops:nodeops "$CSV" "$LATEST"
chmod 0640 "$CSV" "$LATEST"
