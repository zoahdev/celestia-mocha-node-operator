# Upgrade drill

This is a reversible Mocha testnet drill. It documents the operator behavior without touching wallet material or changing the network.

## Before the change

```bash
systemctl is-active celestia-node.service
/usr/local/bin/celestia version
/usr/local/sbin/celestia-health
journalctl -u celestia-node.service -n 50 --no-pager
```

Record the binary version, service state, peer count, local/network heights, and lag in the public status record.

## Configuration hygiene

Before a version change, use the documented configuration update path and inspect the resulting config. Do not delete the node store or key directory as part of a normal binary upgrade.

```bash
/usr/local/bin/celestia light config-update --p2p.network mocha
systemctl daemon-reload
systemctl restart celestia-node.service
```

## After the change

```bash
systemctl is-active celestia-node.service
/usr/local/sbin/celestia-health
journalctl -u celestia-node.service -n 100 --no-pager
```

Confirm that the node reconnects to peers, tracks the network head, and continues DAS sampling. If the service fails, restore the previous binary, restart, and preserve the journal for the incident record.

Celestia’s documented operator sequence is to test upgrades on Arabica, then Mocha, then Mainnet Beta. This repository is currently at the Mocha rehearsal stage.

Reference: [official network upgrade process](https://docs.celestia.org/operate/maintenance/network-upgrades/)
