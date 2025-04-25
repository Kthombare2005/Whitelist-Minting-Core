const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying WhitelistNFT contract from:", deployer.address);

  // Deploy WhitelistNFT contract
  const WhitelistNFT = await hre.ethers.getContractFactory("WhitelistNFT");
  const whitelistNFT = await WhitelistNFT.deploy();

  await whitelistNFT.deployed();

  console.log("✅ WhitelistNFT contract deployed at:", whitelistNFT.address);

  // Example: Add some addresses to the whitelist (you can change these)
  const usersToWhitelist = [
    "0xAddress1", // Replace with actual user addresses
    "0xAddress2",
    "0xAddress3"
  ];

  // Add users to the whitelist
  const addToWhitelistTx = await whitelistNFT.addToWhitelist(usersToWhitelist);
  await addToWhitelistTx.wait();

  console.log("✅ Users added to whitelist");
}

main().catch((error) => {
  console.error("❌ Deployment failed:", error);
  process.exitCode = 1;
});
