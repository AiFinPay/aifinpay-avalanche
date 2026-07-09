import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";

dotenv.config();

const PRIVATE_KEY = process.env.PRIVATE_KEY ?? "";

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.35",
    settings: {
      optimizer: { enabled: true, runs: 200 },
    },
  },
  networks: {
    avalanche: {
      url: process.env.AVALANCHE_RPC ?? "https://api.avax.network/ext/bc/C/rpc",
      chainId: 43114,
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : [],
    },
  },
  // Snowtrace is powered by Routescan — verification goes through its Etherscan-
  // compatible endpoint, NOT the generic Etherscan index.
  etherscan: {
    apiKey: {
      avalanche: "verifyContract",
    },
    customChains: [
      {
        network: "avalanche",
        chainId: 43114,
        urls: {
          apiURL: "https://api.routescan.io/v2/network/mainnet/evm/43114/etherscan",
          browserURL: "https://snowtrace.io",
        },
      },
    ],
  },
};

export default config;
