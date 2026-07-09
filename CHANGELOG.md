# Changelog

All notable changes to this repository are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.0.0]

### Added
- Full AiFinPay protocol deployed and **verified on Avalanche C-Chain mainnet**
  (chain ID `43114`): AiFinPayCore, AgentPassport, B2BSplitter, MSECCOToken.
- Live on-chain proof transactions (seat reservation + three top-ups) settled
  through the full flow — native AVAX payment → Pyth AVAX/USD price → on-chain
  settlement → mSECCO credit. See `README.md`.
- Hardhat build + deploy pipeline (`hardhat.config.ts`, `scripts/deploy.ts`),
  Routescan/Snowtrace verification config.
- `config/avalanche.json` — chain, oracle, and stablecoin addresses.
- `docs/ARCHITECTURE.md` — protocol design and payment flow.
- `DEPLOYMENT_COST.md` — full-protocol deploy cost breakdown (~$0.009).
- Repository health: CI (compile + test), CodeQL, Dependabot, issue/PR templates,
  CODEOWNERS, SECURITY policy, contribution guide.
