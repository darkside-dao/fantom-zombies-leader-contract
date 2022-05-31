require("dotenv").config();
const hre = require("hardhat");

const collectionSize = process.env.COLLECTION_SIZE;

async function main() {
  const LeaderZombies = await hre.ethers.getContractFactory("LeaderZombies");
  const leaderZombies = await LeaderZombies.deploy(collectionSize);
  await leaderZombies.deployed();

  console.log("Contract deployed to address:", leaderZombies.address);
  console.log("Collection size:", collectionSize);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
