const Funge = artifacts.require("FungeToken");

module.exports = function(deployer) {
  deployer.deploy(Funge,500000000);
};
