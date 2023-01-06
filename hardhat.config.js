require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: "0.8.10",
  networks: {
    mumbai: {
      url: "https://neat-capable-knowledge.matic-testnet.discover.quiknode.pro/177e1ab37a8d8f54af0459756ee1d220cafd73ae/",
      accounts: ["YOUR_TEST_WALLET_PRIVATE_KEY"],
    }
  }
};