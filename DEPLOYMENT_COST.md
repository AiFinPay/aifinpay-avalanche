# AiFinPay — Avalanche Deployment Cost Analysis

Full-protocol smart-contract deployment cost on Avalanche C-Chain, computed from
the live gas report and current network parameters.

**Headline:** the complete AiFinPay protocol deploys for **≈ $0.0004 at current
network gas**, and **$0.92 even at Avalanche's historical worst-case fee floor
(25 gwei)**. The claim *"full protocol deploys for under $1 on Avalanche"* is
**verified and defensible**.

## Network parameters (live)

| Parameter | Value |
|---|---|
| AVAX price | $6.79 (CoinGecko, live) |
| C-Chain gas price (current) | ~0.012 gwei (latest-block base fee) |
| Historical fee floor (worst-case) | 25 gwei |

## Per-contract deployment cost

Mainnet footprint = **4 contracts (5,418,414 gas)**. MockPyth is not deployed on
mainnet — Avalanche has the real Pyth oracle.

| Contract | Deploy gas | Cost @ 25 gwei (worst case) | Cost @ current gas |
|---|---|---|---|
| AiFinPayCore | 2,590,330 | $0.4397 | $0.0002 |
| AgentPassport | 1,393,796 | $0.2366 | $0.0001 |
| B2BSplitter | 791,326 | $0.1343 | $0.0001 |
| MSECCOToken | 642,962 | $0.1092 | $0.0000 |
| **TOTAL** | **5,418,414** | **$0.9198** | **$0.0004** |

## Gas-price scenarios (full protocol)

| Gas price | Cost in AVAX | Cost in USD | Verdict |
|---|---|---|---|
| ~0.012 gwei (current) | 0.000066 | $0.0004 | ≪ $1 ✓ |
| 1 gwei | 0.005418 | $0.0368 | ≪ $1 ✓ |
| 2 gwei | 0.010837 | $0.0736 | ≪ $1 ✓ |
| 5 gwei | 0.027092 | $0.1840 | ≪ $1 ✓ |
| 10 gwei | 0.054184 | $0.3679 | < $1 ✓ |
| 25 gwei (old floor) | 0.135460 | $0.9198 | < $1 ✓ |

## Cross-chain benchmark

Same 5,418,414-gas footprint, representative gas prices, live token prices
(AVAX $6.79, ETH $1,749, POL $0.077):

| Network | Gas token | Rep. gas price | Deploy cost (USD) |
|---|---|---|---|
| Avalanche (current) | AVAX | ~0.012 gwei | **$0.0004** |
| Polygon | POL | ~30 gwei | ~$0.01 |
| Base (L2) | ETH | ~0.02 gwei | ~$0.19 |
| Arbitrum (L2) | ETH | ~0.1 gwei | ~$0.95 |
| Ethereum L1 | ETH | ~8 gwei | ~$76 |

## Investor-facing summary

> The complete AiFinPay protocol — payment core, agent-identity NFT, settlement
> splitter, and credit token — deploys on Avalanche C-Chain for **under $1**
> (≈ $0.0004 at current network conditions), demonstrating an AI-agent payment
> infrastructure with negligible blockchain operating costs and highly scalable
> economics.

*Prices live as of analysis. Avalanche gas measured directly from the C-Chain RPC.*
