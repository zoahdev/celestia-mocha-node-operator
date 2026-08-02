# Public status record

`node-status.csv` is a sanitized time series emitted by the local operations snapshot service and periodically published to this repository.

Columns:

- `timestamp`: Asia/Shanghai timestamp with offset
- `service`: systemd service state
- `local_height`: local header height
- `network_height`: observed Mocha network head
- `lag`: `network_height - local_height`
- `peers`: connected libp2p peer count
- `disk_bytes`: node-store size in bytes

This record contains no private keys, wallet material, authentication tokens, IP addresses, or RPC credentials.
