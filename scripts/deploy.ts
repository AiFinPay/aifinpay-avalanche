/**
 * Deploys the full AiFinPay protocol to Avalanche C-Chain.
 *
 * Order:  MSECCOToken → AgentPassport → B2BSplitter → AiFinPayCore
 * Wiring: msecco.setCore(core) · passport.setCore(core)
 *
 * Network + oracle/token addresses are read from config/avalanche.json.
 * Treasury defaults to the deployer unless a real address is set in the config.
 *
 * Usage:
 *   npx hardhat run scripts/deploy.ts --network avalanche
 */
import { ethers, network } from "hardhat";
import * as fs from "fs";
import * as path from "path";

async function main() {
  const cfg = JSON.parse(
    fs.readFileSync(path.join(__dirname, "..", "config", "avalanche.json"), "utf8")
  );

  const [deployer] = await ethers.getSigners();
  const owner = await deployer.getAddress();

  // Use the configured treasury if it is a real address, otherwise the deployer.
  const treasury = ethers.isAddress(cfg.treasury) ? cfg.treasury : owner;

  console.log(`Network:   ${network.name} (chainId ${cfg.chainId})`);
  console.log(`Deployer:  ${owner}`);
  console.log(`Treasury:  ${treasury}`);
  console.log("");

  const MSECCO = await ethers.getContractFactory("MSECCOToken");
  const msecco = await MSECCO.deploy(owner);
  await msecco.waitForDeployment();
  console.log(`MSECCOToken   ${await msecco.getAddress()}`);

  const Passport = await ethers.getContractFactory("AgentPassport");
  const passport = await Passport.deploy(owner);
  await passport.waitForDeployment();
  console.log(`AgentPassport ${await passport.getAddress()}`);

  const Splitter = await ethers.getContractFactory("B2BSplitter");
  const splitter = await Splitter.deploy(owner, treasury);
  await splitter.waitForDeployment();
  console.log(`B2BSplitter   ${await splitter.getAddress()}`);

  const Core = await ethers.getContractFactory("AiFinPayCore");
  const core = await Core.deploy(
    owner,
    await msecco.getAddress(),
    await passport.getAddress(),
    treasury,
    cfg.pyth,
    cfg.usdc,
    cfg.usdt,
    cfg.nativeUsdId
  );
  await core.waitForDeployment();
  console.log(`AiFinPayCore  ${await core.getAddress()}`);

  // Wire the credit token and passport to the core so only the core can mint.
  await (await msecco.setCore(await core.getAddress())).wait();
  await (await passport.setCore(await core.getAddress())).wait();
  console.log("\nWired: MSECCO.setCore + Passport.setCore → AiFinPayCore");

  console.log("\nDeployment complete. Verify with:");
  console.log(`  npx hardhat verify --network avalanche <address> <constructor args>`);
}

main().catch((e) => {
  console.error(e);
  process.exitCode = 1;
});
