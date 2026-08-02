# Celestia Mocha Node Operator

Public, reproducible operations record for a Celestia Mocha light node.

## Current deployment

| Item | Value |
| --- | --- |
| Network | Celestia Mocha (`mocha-4`) |
| Node type | Data Availability Light Node |
| Version | `v0.31.4-mocha` |
| Commit | `275faa430d54848f63f8e3bda7bcb27702fb4d10` |
| Peer ID | `12D3KooWHAEjYnCRCyrsb4yB3j1zBPaYAsAXPTui8xtDBb5vrStB` |
| Runtime | Ubuntu 24.04 / systemd |
| RPC exposure | localhost only (`127.0.0.1:26658`) |

The node follows the live network head, performs Data Availability Sampling (DAS), and catches up its local header store. At the first published snapshot it was connected to 20 peers and the health check passed.

## Operations design

- systemd process supervision and automatic restart
- five-minute health checks
- five-minute snapshots of local height, network height, lag, peer count, and disk usage
- RPC bound to localhost
- node process runs as a dedicated unprivileged Linux user
- node keys and authentication tokens are excluded from this repository

The sanitized health and snapshot scripts are in [`scripts/`](scripts/). A point-in-time, non-secret operating record is in [`status/node-status.csv`](status/node-status.csv).

## Verification boundary

The public Peer ID identifies the libp2p node, but it is not a wallet address, validator identity, governance right, uptime guarantee, or proof of earnings. This is a testnet light-node deployment and does not promise rewards.

## Roadmap

1. Publish seven days of uptime and operating snapshots.
2. Complete and document one version-upgrade drill.
3. Move the service from a laptop to a 24/7 Linux VPS.
4. Add Prometheus/Grafana monitoring and external alerts.
5. Evaluate a Mocha bridge node, then validator operations, against documented hardware and capital requirements.

## Official references

- [Mocha testnet](https://docs.celestia.org/operate/networks/mocha-testnet/)
- [Light node quick start](https://docs.celestia.org/operate/data-availability/light-node/quickstart/)
- [Install celestia-node](https://docs.celestia.org/operate/data-availability/install-celestia-node/)
- [v0.31.4-mocha release](https://github.com/celestiaorg/celestia-node/releases/tag/v0.31.4-mocha)
