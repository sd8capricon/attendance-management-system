var Owned = artifacts.require("Owned");
var AttendanceSheet = artifacts.require("AttendanceSheet");
module.exports = function (deployer) {
      deployer.deploy(Owned);
      deployer.deploy(AttendanceSheet);
}