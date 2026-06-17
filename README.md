# AiFinPay on Avalanche C-Chain

**AiFinPay is the payment rail for autonomous AI agents — "Stripe for AI agents."**
Agents hold their own wallet and pay for services per call, settled on-chain,
non-custodial. This repository contains the AiFinPay protocol deployment for the
**Avalanche C-Chain** (chain ID `43114`).

> Part of AiFinPay's multichain rollout — already live on **Polygon** and **Solana**
> mainnet, with a **Casper** testnet deployment. Avalanche brings the full protocol
> to a high-throughput, low-cost L1 that's ideal for high-frequency agent payments.
> Site: [aifinpay.io](https://aifinpay.io)

---

## Why Avalanche

The complete AiFinPay protocol deploys on Avalanche C-Chain for **under $1** —
making it one of the cheapest networks in the world to stand up a full AI-agent
payment stack.

| Gas price | Full-protocol deploy cost |
|---|---|
| **Current (~0.012 gwei)** | **≈ $0.0004** |
| 5 gwei | $0.18 |
| 25 gwei (historical worst-case floor) | $0.92 |

*(5,418,414 gas footprint · AVAX live price · full breakdown in [`DEPLOYMENT_COST.md`](./DEPLOYMENT_COST.md).)*
Every AiFinPay agent payment burns AVAX in transaction fees — contributing real,
sustained on-chain activity to the Avalanche ecosystem.

---

## Architecture

Four contracts make up the protocol:

| Contract | Role |
|---|---|
| **AiFinPayCore** | Main protocol — seat reservation, x402 settlement, agent credits |
| **AgentPassport** | Soulbound ERC-721 — on-chain agent identity + daily spend limits |
| **B2BSplitter** | Atomic on-chain payment splitter (merchant / treasury / IP creator) |
| **MSECCOToken** | Non-transferable compute-credit token (mSECCO) |

- **Oracle:** Pyth Pull Oracle (AVAX/USD) — `0x4305FB66699C3B2702D4d05CF36551390A4c69C6`
- **Settlement:** atomic 99 / 1 split, non-custodial — funds never held by the protocol
- **Identity:** every agent carries a soulbound Passport NFT with enforced spend limits

---

## Network configuration

| | |
|---|---|
| Network | Avalanche C-Chain |
| Chain ID | `43114` |
| Native token | AVAX |
| RPC | `https://api.avax.network/ext/bc/C/rpc` |
| Explorer | [snowtrace.io](https://snowtrace.io) |
| USDC | `0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E` |
| USDT | `0xc7198437980c041c805A1EDcbA50c1Ce5db95118` |
| Pyth | `0x4305FB66699C3B2702D4d05CF36551390A4c69C6` |

Full config in [`config/avalanche.json`](./config/avalanche.json).

---

## Deployed addresses

> 🟡 **Deployment in progress.** Contract addresses will be published here and
> verified on Snowtrace immediately upon mainnet deployment.

| Contract | Address |
|---|---|
| AiFinPayCore | _coming on deploy_ |
| AgentPassport | _coming on deploy_ |
| B2BSplitter | _coming on deploy_ |
| MSECCOToken | _coming on deploy_ |

---

## Build

```bash
bun install
bun run hardhat compile
bun run hardhat run scripts/deploy.ts --network avalanche
```

Stack: Solidity 0.8.35 · Hardhat · OpenZeppelin · Pyth Pull Oracle.

---

## Links

- **Site:** [aifinpay.io](https://aifinpay.io)
- **SDK + MCP:** [github.com/AiFinPay/sdk](https://github.com/AiFinPay/sdk)
- **Polygon deployment:** [github.com/AiFinPay/aifinpay-polygon](https://github.com/AiFinPay/aifinpay-polygon)
