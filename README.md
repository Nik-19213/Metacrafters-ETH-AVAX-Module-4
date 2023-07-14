# Degen(DGN) Token - Smart Contract

The DegenToken contract is an ERC20 token smart contract that enables Rewards system using crypto token and various other functionalities for players in the Degen Gaming platform. The contract is designed to provide the following features:

- Minting new tokens: The platform owner can create new tokens and distribute them as rewards to players. Only the contract owner has the authority to mint tokens.

- Transferring tokens: Players can transfer their tokens to others. They can initiate token transfers to any address by specifying the recipient and the amount of tokens they wish to transfer.

- Redeeming tokens: Players can redeem their tokens for items in the in-game store. The contract provides a list of available items that can be redeemed using the corresponding token values.

- Checking token balance: Players can check their token balance at any time by calling the `checkBalance` function. It returns the balance of tokens held by the caller's address.

- Burning tokens: Any token holder can burn their own tokens if they are no longer needed. The `burnTokens` function allows token holders to burn a specific amount of tokens from their own balance.

- Banning and Unbanning accounts: The platform owner can Ban an account due to suspicious activity or unethical behaviour, and only owner can also un-ban an account.

## Guide to connect

Welcome to the guide on connecting to Avalanche, a high-performance blockchain platform, using Hardhat, a popular development environment for Ethereum smart contracts. This guide will walk you through the necessary steps to get started, deploy smart contracts, and interact with the Avalanche ecosystem.

## Prerequisites

Before you begin, ensure you have the following prerequisites:

1. Node.js installed (version X.X.X or higher)
2. Basic knowledge of Ethereum and smart contracts
3. Familiarity with the command line interface (CLI)

## Folder Structure

Before we dive into the setup process, let's take a look at the recommended folder structure for your Avalanche project:

```
├── contracts/            # Contains your smart contracts
├── scripts/              # Deployment and interaction scripts
├── test/                 # Test cases for your smart contracts
├── hardhat.config.js     # Hardhat configuration file
├── README.md             # Project documentation
└── ...
```

This structure helps organize your project and separates the different components of your Avalanche development workflow.

## Setup and Configuration

### Step 1: Project Setup

1. Create a new folder for your project and navigate into it:

```shell
$ mkdir my-avalanche-project
$ cd my-avalanche-project
```

2. Initialize the project and install Hardhat as a development dependency:

```shell
$ npm init -y
$ npm install --save-dev hardhat
```

3. Initialize your Hardhat project:

```shell
$ npx hardhat
```

- Select the option  
`❯ Create a JavaScript project.`
- This will generate a Hardhat config file (e.g. `hardhat.config.js`).

4. Install the Hardhat Toolbox plugin:

```shell
$ npm i --save-dev @nomicfoundation/hardhat-toolbox
```

### Step 2: Project Configuration

Modify your `hardhat.config.js` file to include Avalanche configurations:

> When using the hardhat network, you may choose to fork Fuji or Avalanche Mainnet. This will allow you to debug contracts using the hardhat network while keeping the current network state. To enable forking, turn one of these booleans on, and then run your tasks/scripts using --network hardhat

```javascript
require("@nomicfoundation/hardhat-toolbox");

const FORK_FUJI = false;
const FORK_MAINNET = false;
let forkingData = undefined;

if (FORK_MAINNET) {
  forkingData = {
    url: "https://api.avax.network/ext/bc/C/rpcc",
  };
}
if (FORK_FUJI) {
  forkingData = {
    url: "https://api.avax-test.network/ext/bc/C/rpc",
  };
}

module.exports = {
  solidity: "0.8.18",
  networks: {
    hardhat: {
      gasPrice: 225000000000,
      chainId: !forkingData ? 43112 : undefined,
      forking: forkingData
    },
    fuji: {
      url: 'https://api.avax-test.network/ext/bc/C/rpc',
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: [
        // YOUR PRIVATE KEY HERE
      ]
    },
    mainnet: {
      url: 'https://api.avax.network/ext/bc/C/rpc',
      gasPrice: 225000000000,
      chainId: 43114,
      accounts: [
        // YOUR PRIVATE KEY HERE
      ]
    }
  }
}
```
- url: The URL specifies the endpoint to connect to the Fuji testnet. It is set to 'https://api.avax-test.network/ext/bc/C/rpc'.

- gasPrice: The gas price determines the cost of executing transactions on the network. For Fuji, it is set to 225000000000.

- chainId: The chain ID uniquely identifies the Fuji testnet on Avalanche. It is set to 43113.

- accounts: This is where you need to provide your private key. Add your private key as a string within the array. Private keys are used to sign transactions and prove ownership of accounts.


**Note**: Replace `YOUR PRIVATE KEY HERE` with your actual private key for the desired network.

## Deploying Smart Contracts


1. In the `scripts/` directory, create a deployment script, e.g., `deploy.js`. Use the following template:

```javascript
const hre = require("hardhat");

async function main() {
	
  const contractName == "YOUR CONTRACT NAME" 
  const contract = await hre.ethers.deployContract(contractName);

  await contract.waitForDeployment();

  console.log(`Contract Deployed to address ${await contract.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
```

> To deploy our smart contract, we need to get some Testnet AVAX from the Faucet. You can get that here: https://faucet.avax.network/.

2. Write the deployment logic within the `main()` function, using Hardhat's deployment APIs.

3. Run the deployment script on the desired network


```shell
$ npx hardhat run scripts/deploy.js --network fuji
```

**Note**: Replace `fuji` with the desired network name. 
> You need to have some AVAX tokes in your account before deploying the contract on Avalanche

## Verifying Smart Contracts

1. To verify your deployed smart contracts using hardhat  on Avalanche, you'll need an API key from [Snowtrace](https://snowtrace.io/). Sign up on their website and obtain your API key.

2. Add this to your `hardhat.config.js` after generating your API key and modify the `etherscan` section:

```javascript

module.exports = {
  // ...rest of the config...
  etherscan: {
    apiKey: "YOUR_API_KEY",
  },
};
```

3. Once configured, you can use the following command to verify your smart contracts:

```shell
$ npx hardhat verify <contract_address> --network fuji
```

> Generally you can run this command to verify your contract `npx hardhat verify <contract address> <arguments> --network <network>`


**Note**: Replace `<contract_address>` with the actual address of your deployed smart contract.

## Conclusion

Congratulations! You have successfully connected to Avalanche using Hardhat and deployed your contract, now you can interact with your contract in Remix IDE by selecting the injected provider-metamask, and providing the contracts deployement address in `At Address` column.

For detailed usage instructions and additional functionalities, refer to the Hardhat, openzeppelin and Avalanche documentation.

## License

This project is licensed under the [MIT License](LICENSE).

---
