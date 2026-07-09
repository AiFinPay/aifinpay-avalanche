# Roadmap

> This repository is the public record for the RETRO9000 grant submission. The items
> below describe the direction of the AiFinPay protocol on Avalanche; active
> maintenance happens in the canonical AiFinPay EVM monorepo.

## Done
- Full protocol deployed and verified on Avalanche C-Chain mainnet.
- Live payment flow proven on-chain (Pyth-priced settlement + mSECCO minting).

## Near-term
- Move the treasury from the deployer wallet to a Gnosis Safe multisig.
- Publish a test suite covering the settlement math and Passport spend limits.
- Add a batch-payment path for high-frequency agent calls.

## Later
- Third-party security review of the settlement and splitter logic.
- SDK + MCP integration examples targeting the Avalanche deployment.
- Cross-chain settlement receipts shared with the other AiFinPay deployments.
