require("@nomicfoundation/hardhat-toolbox");

task("accounts", "Print the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: process.env.STAGING_QUICK_NODE,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};
