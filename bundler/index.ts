const ethers = require('ethers');
const fs = require('fs');
const parsed = JSON.parse(fs.readFileSync("./bundler/abi/Entrypoint.json"));
const EntryABI = parsed.abi;
const parsed_factory = JSON.parse(fs.readFileSync("./bundler/abi/Factory.json"));
const FactoryABI = parsed_factory.abi;
const AddressZero = ethers.constants.AddressZero;

const provider = new ethers.providers.JsonRpcProvider("http://localhost:8545");
const signer = new ethers.Wallet("0x57b6fb301e43cc933259624449df08cd32ee9855fb6ff3928d37e4ac6a5746cb", provider);
const address = signer.getAddress()

const entrypointAddress = "0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789"
const simpleAccountFactory = "0x9406Cc6185a346906296840746125a0E44976454"

const accountFactory = new ethers.Contract(simpleAccountFactory, FactoryABI, signer);
const AA = new ethers.Contract(entrypointAddress, EntryABI, signer);

const UserOperation = {
  sender: AddressZero,
  nonce: 0,
  initCode: '0x',
  callData: '0x',
  callGasLimit: 0,
  verificationGasLimit: 150000, // default verification gas. will add create2 cost (3200+200*length) if initCode exists
  preVerificationGas: 21000, // should also cover calldata cost.
  maxFeePerGas: 0,
  maxPriorityFeePerGas: 1e9,
  paymasterAndData: '0x',
  signature: '0x'
}

async function main() {
  const test = await AA.SIG_VALIDATION_FAILED()
  console.log(test)
}

main();
//console.log(EntryABI)