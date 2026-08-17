# AiFinPay Avalanche — historical deployment record

> ⚠️ **LEGACY / NON-CANONICAL / NOT FOR PRODUCTION DEPLOYMENT.**
>
> This repository is preserved as the public historical record used for the RETRO9000 grant submission and earlier Avalanche experiments. It is **not** the source of truth for the current AiFinPay AIFP-1/AIFP-2 payment release.
>
> Canonical EVM settlement development: **https://github.com/AiFinPay/evm-contract** (`B2BSplitterV13`).
> Canonical SDK/MCP: **https://github.com/AiFinPay/sdk**.

## Historical evidence

Earlier AiFinPayCore / AgentPassport / MSECCOToken contracts were deployed on Avalanche C-Chain and test/operator transactions were recorded on-chain. Those historical deployments are useful evidence that the older protocol code executed on mainnet; they are **not evidence that the current v1.3 AIFP-1/AIFP-2 route is production-live**.

Historical addresses retained for auditability:

| Component | Historical address |
|---|---|
| AiFinPayCore | `0x147d8fF8c027E24303b5B99CbC8843e1D3dF94cC` |
| AgentPassport | `0x271870ABb6e6756D97191eBdb27C1873911bb587` |
| MSECCOToken | `0xeE92807decAa3A02F1e165dd7Efcd92ab9aA83CB` |

Historical operator transactions:

- Reserve seat: `0xd8e17d7fd8abc5ad3e8643a5190af5199d544d738b4efe253d3b3bbf047ab03e`
- Top-up #1: `0x4ee94162fb4600d00f9949cbc6c27554f2949b252566e2bc994bf61f07bc42149f0`
- Top-up #2: `0xbcace889257c1fa37b07e3576519cf7cf01577b3262e62ec3b5c61d3d7be13d6`
- Top-up #3: `0x3e4fa84c0693971913a49910f698ef0a54b26efc69db3fcb40d30dc11fcfb071`

The historical deployments were operated from `0x1D5eF769A024B3157c76884fbd10302d8d83fAB9`. The current release must not infer that this legacy EOA is acceptable production governance.

## Current release semantics

The current AiFinPay payment release is intentionally different from the legacy architecture recorded here:

- AIFP-1 is gross-inclusive: merchant 99%, AiFinPay treasury 1%, creator 0%.
- AIFP-2/x402: provider 100%, AiFinPay 0%, creator 0%.
- EVM economics are represented by separate immutable v1.3 route deployments.
- AIFP-3 uses one global Agent Identity with verified wallet bindings; the legacy chain-local Passport NFT is not the canonical identity model.
- A network is not considered production-live merely because a historical contract address exists. Current activation requires reviewed source, a fresh deployment/evidence bundle, trusted pins and paid E2E.

## Do not use this repository to

- deploy a new production AiFinPay settlement contract;
- derive current contract addresses or trusted pins;
- claim that the current AiFinPay v1.3 payment route is live on Avalanche;
- restore the historical owner/treasury/deployer model;
- treat historical seat/top-up activity as current AIFP-1/AIFP-2 paid E2E.

For current EVM code and deployment preparation, use **AiFinPay/evm-contract** and the active release handoff/evidence in **AiFinPay/knowledge-vault**.
