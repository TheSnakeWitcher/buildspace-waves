require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

task("accounts", "Print the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: process.env.STAGING_QUICK_NODE,
      accounts: [process.env.PRIVATE_KEY],
    },
    // mainnet: {
    // chainId: 1,
    //   url: process.env.PROD_QUICKNODE_KEY,
    //   accounts: [process.env.PRIVATE_KEY],
    // },
  },
};
