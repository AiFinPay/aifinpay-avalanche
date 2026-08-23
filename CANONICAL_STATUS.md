# Canonical release status

> **LEGACY / UNVERIFIED PAYMENT ROUTE**

This repository is retained as chain-specific source and audit history. It is
not a payment-live route for the current AiFinPay release unless a later
release record explicitly supplies all evidence listed below.

## Canonical economics

| Route | Payer total | Merchant/provider | AiFinPay | Creator/referral |
|---|---:|---:|---:|---:|
| AIFP-1 | exact quoted gross | 99% | 1% | 0% |
| AIFP-2 / x402 | provider price | 100% | 0% | 0% |

Network gas is separate. Fee-on-top and a 0.01% creator/referral default are
not compatible with the current model.

## Required before activation

- reviewed implementation of the current route ABI/program interface;
- canonical deployment/program address and chain ID;
- exact runtime/code hash pinned independently in backend and SDK;
- verified on-chain BPS/profile values;
- merchant/provider target and asset binding;
- clean unit/integration tests and controlled paid E2E;
- final audit with no unresolved Critical/High fund-loss issue.

Until every item is present, backend/SDK/MCP must treat `aifinpay-avalanche` as disabled
or legacy. An address, explorer page, historical transaction, logo or merged
source tree is not production-readiness evidence.
