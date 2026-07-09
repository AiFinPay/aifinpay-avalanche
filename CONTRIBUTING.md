# Contributing

Thanks for your interest in AiFinPay on Avalanche.

> **Note:** This repository is the public record for the RETRO9000 grant submission
> and is **unmaintained**. The canonical, maintained contract code lives in the
> AiFinPay EVM monorepo. Issues here are welcome but may not receive active support.

## Getting started

```bash
npm install
npx hardhat compile
npx hardhat test
```

Requires Node 20+.

## Ground rules

- **Never commit secrets.** Private keys and RPC keys belong in `.env` (gitignored).
  Use `.env.example` as the template.
- **Match the existing style.** Solidity is formatted with Prettier (`npm run format`
  if configured) and follows the layout of the existing contracts.
- **Keep contracts minimal and audited-friendly** — favour clarity over cleverness.
- **One logical change per pull request.** Describe what and why.

## Reporting bugs

Open an issue using the templates under `.github/ISSUE_TEMPLATE/`. For anything
security-sensitive, follow [`SECURITY.md`](./SECURITY.md) instead of filing a public
issue.

## Pull requests

1. Fork and branch from `main`.
2. Make your change; ensure `npx hardhat compile` and `npx hardhat test` pass.
3. Open a PR against `main` using the pull request template.
