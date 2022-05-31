const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  let leaderZombies, accounts;
  beforeEach(async function () {
    const LeaderZombies = await ethers.getContractFactory("LeaderZombies");
    leaderZombies = await LeaderZombies.deploy();
    await leaderZombies.deployed();
    accounts = await ethers.getSigners();
  });

  it("Check token uri", async function () {
    const tx = await leaderZombies.give(accounts[0].address, 2);
    await tx.wait();

    const tx1 = await leaderZombies.setTokenURI(1, "kinash");
    await tx1.wait();

    expect(await leaderZombies.tokenURI(1)).to.be.equal("kinash");
    expect(await leaderZombies.tokenURI(2)).to.be.equal("");
  });
});
