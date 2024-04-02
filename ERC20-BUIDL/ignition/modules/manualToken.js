const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("ManualTokenModule", (m) => {
  const ManualToken = m.contract("ManualToken", [100, "Brooklyn", "BLT"]);

  return { ManualToken };
});
// Deployed Address - 0xBbA54435876aD15916348880cE7A9F0826c12727