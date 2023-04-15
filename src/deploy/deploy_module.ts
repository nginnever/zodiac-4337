import { formatBytes32String } from "ethers/lib/utils";
import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";

const FirstAddress = "0x0000000000000000000000000000000000000001";

const deploy: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre;
  const { deployer } = await getNamedAccounts();
  const { deploy } = deployments;
  const chainId = 1;
  const args = [
    FirstAddress,
    FirstAddress,
    FirstAddress,
    "0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789",
    "0x0000000000000000000000000000000000000000",
  ];

  await deploy("DAOValidator", {
    from: deployer,
    args,
    log: true,
    deterministicDeployment: true,
  });
};

deploy.tags = ["daovalidator-module"];
export default deploy;
