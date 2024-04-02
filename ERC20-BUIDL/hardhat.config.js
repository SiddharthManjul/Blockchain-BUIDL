require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-ignition");
require("dotenv").config();

const AMOY_URL = process.env.AMOY_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.7",
  networks: {
    amoy : {
      url: AMOY_URL,
      accounts: [PRIVATE_KEY]
    }
  }
};
