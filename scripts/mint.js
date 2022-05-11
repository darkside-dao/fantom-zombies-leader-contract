require("dotenv").config();
const hre = require("hardhat");
const LeaderZombies = require("../artifacts/contracts/LeaderZombies.sol/LeaderZombies.json");

const contractAddress = process.env.CONTRACT_ADDRESS;

async function main() {
  const accounts = await hre.ethers.getSigners();
  const contract = new hre.ethers.Contract(
    contractAddress,
    LeaderZombies.abi,
    accounts[0]
  );

  const mint = await contract.give(accounts[1].address, 5);
  await mint.wait();

  const numberMinted = await contract.balanceOf(accounts[1].address);
  console.log(numberMinted);

  const totalMinted = await contract.totalSupply();
  console.log(totalMinted);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
