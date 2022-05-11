require("dotenv").config();
const hre = require("hardhat");

const collectionSize = process.env.COLLECTION_SIZE;
const metadataURI = process.env.METADATA_URI;

async function main() {
  const LeaderZombies = await hre.ethers.getContractFactory("LeaderZombies");
  const leaderZombies = await LeaderZombies.deploy(collectionSize, metadataURI);
  await leaderZombies.deployed();

  console.log("Contract deployed to address:", leaderZombies.address);
  console.log("Collection size:", collectionSize);
  console.log("Metadata URI:", metadataURI);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
