# Next-stage operator plan

This plan separates what can be done on the current laptop from work that requires a paid 24/7 host or meaningful capital.

## Current stage: Mocha light node

The current node is a public testnet light-node operations record. It is useful for learning peer operations, DAS behavior, health checks, upgrade hygiene, and incident response. It is not a validator identity and does not create mainnet governance power.

## VPS migration gate

Do not migrate until the host has:

1. Linux `amd64` or `arm64` support.
2. A persistent SSD-backed filesystem and enough headroom for the node store.
3. systemd, automatic security updates, and a non-root service user.
4. A backup path that never copies the node key directory into a public repository.
5. A firewall policy that exposes only the required P2P port; RPC remains private or protected.

The migration should be a second instance, verified against this laptop node, before the laptop service is retired.

## Bridge-node gate

The bridge phase should start on Mocha, using the official Mocha consensus RPC and documented community bridge endpoints. It adds block storage and a larger operational surface than a light node. Measure disk growth, file-descriptor pressure, peer stability, and restart recovery for at least seven days before considering a paid production host.

## Validator gate

A validator requires a consensus node, validator key custody, testnet funding, public reliability, and explicit operational risk acceptance. Do not create or fund a validator key from this laptop workflow. First prove the light/bridge runbook, then rehearse consensus operations on a disposable testnet environment.

## Official references

- [Mocha network details and endpoints](https://docs.celestia.org/operate/networks/mocha-testnet/)
- [Bridge node guide](https://docs.celestia.org/operate/data-availability/bridge-node/)
- [Node upgrade process](https://docs.celestia.org/operate/maintenance/network-upgrades/)
- [Node installation and supported architectures](https://docs.celestia.org/operate/data-availability/install-celestia-node/)
