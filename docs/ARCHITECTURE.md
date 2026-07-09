# Architecture

AiFinPay is a non-custodial payment rail for autonomous AI agents. An agent holds
its own wallet and pays for services per call; settlement happens on-chain and funds
are never held by the protocol. This document describes the Avalanche C-Chain
deployment.

## Contracts

| Contract | Responsibility |
|---|---|
| **AiFinPayCore** | Entry point for agent payments. Reserves a seat, prices the payment against the Pyth AVAX/USD feed, settles via `B2BSplitter`, and mints mSECCO credit. |
| **AgentPassport** | Soulbound (non-transferable) ERC-721 identity for each agent. Enforces per-agent daily spend limits. |
| **B2BSplitter** | Atomic on-chain payment splitter (e.g. 99% merchant / 1% treasury). Splits happen in a single transaction; no intermediate custody. |
| **MSECCOToken** | Non-transferable ERC-20 compute-credit token (mSECCO). Minted by the Core when an agent tops up. |

Supporting code:

- `contracts/interfaces/IPyth.sol` — minimal Pyth Pull Oracle interface used by the Core.
- `contracts/errors/Errors.sol` — shared custom errors (gas-cheaper than revert strings).
- `contracts/mocks/MockPyth.sol` — deterministic oracle stub for local tests.

## Payment flow

```
Agent wallet
   │  sends AVAX with a service request
   ▼
AiFinPayCore.reserveSeat / topUp
   │  1. read AVAX/USD from Pyth Pull Oracle
   │  2. convert the AVAX amount to USD cents
   │  3. settle the split via B2BSplitter (merchant / treasury)
   │  4. mint mSECCO credit to the agent
   ▼
On-chain state: totalSeats, totalUsdCents, mSECCO balance
```

Every payment burns AVAX in gas — real, recurring on-chain activity for the
Avalanche ecosystem.

## Trust & custody

- **Non-custodial:** the protocol never holds user funds. `B2BSplitter` forwards
  each share to its recipient inside the same call.
- **Soulbound identity:** the Passport NFT cannot be transferred, so an agent's
  reputation and spend limits stay bound to its wallet.
- **Oracle:** prices come from the Pyth Pull Oracle. Callers submit a fresh price
  update; the Core rejects stale prices.

## Ownership & upgradeability

- `MSECCOToken` and `AgentPassport` accept a single privileged caller — the Core —
  wired once at deploy time via `setCore(...)`.
- The treasury address is set at deploy and is intended to migrate to a multisig
  (Gnosis Safe). See the deploy config `config/avalanche.json`.

## Deployment

`scripts/deploy.ts` deploys in dependency order —
`MSECCOToken → AgentPassport → B2BSplitter → AiFinPayCore` — then wires
`msecco.setCore(core)` and `passport.setCore(core)`. Network and oracle/token
addresses are read from `config/avalanche.json`. See the top-level
[`README.md`](../README.md) for live mainnet addresses and proof transactions.
