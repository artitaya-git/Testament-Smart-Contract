# Testament Smart Contract

## What is this?
This is a simple smart contract called "Testament" written in Solidity. It lets you create a testament (like a will) on the blockchain by sending Ethereum (ETH), choosing an heir, and having a manager send the ETH to the heir later. I made it to practice Solidity.

## Where did I learn this?
I learned the basics from the Udemy course "Blockchain & Smart Contract with Solidity: Build Real-World Project" by KongRuksiam. I adjusted the code with help from Grok to add features.

## What does it do?
- Create a Testament: Send ETH and pick an heir.
- Check Details: See the heir, amount, and creation time.
- Report Death: The manager (contract creator) sends ETH to the heir.

## Features
- Tracks when the testament was created (timestamp).
- Makes ETH transfers safe (checks if they fail).
- Only the manager can send ETH to the heir.

## How to use it?
1. Open `Testament.sol` in Remix.
2. Deploy on a testnet (like Sepolia).
3. Try it:
   - Send ETH to create a testament with an heir.
   - Check details with `getTestament`.
   - Use the manager account to report a death and send ETH.

## Code Details
- Solidity Version: 0.8.0 or higher.
- License: MIT (free to use).
- Files: `Testament.sol`.

## Why I made it?
I'm learning Solidity by building small projects. This beginner contract helps me understand blockchain basics.

## Thanks
- KongRuksiam for the Udemy course.
- Grok for helping me improve the code.
