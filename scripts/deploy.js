require("dotenv").config();
const hre = require("hardhat");

async function main() {
  const LeaderZombies = await hre.ethers.getContractFactory("LeaderZombies");
  const leaderZombies = await LeaderZombies.deploy();
  await leaderZombies.deployed();

  console.log("Contract deployed to address:", leaderZombies.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
