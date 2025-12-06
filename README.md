🧱 PersonalMessageWall – Smart Contract

A simple, secure, and immutable smart contract designed to record messages on-chain.
Each wallet can send up to 5 messages, with a maximum size of 200 bytes per message.
No funds are ever stored or transferred — users pay only the network gas fee.

✨ Features

🔒 Maximum of 5 messages per wallet
Prevents spam and keeps usage under control.

📝 Messages up to 200 bytes
Perfect for short text interactions or immutable on-chain notes.

📢 NewMessage event emitted for each message
Easy integration with front-ends and indexers (e.g., The Graph).

💸 Financially risk-free
The contract cannot receive, hold, or send ETH/tokens.
It only logs events on the blockchain.

🛡️ Security

This contract was intentionally designed with simplicity and safety as priorities:

No payable functions
➝ Impossible to accidentally send funds to the contract.

No ERC-20 approvals, transfers, or balance manipulation
➝ Zero risk of fund loss or unauthorized access.

All critical values are constant and immutable
➝ No parameters can be modified after deployment.

No loops or expensive computations
➝ Gas-efficient and resistant to denial-of-service style attacks.

Logic depends solely on msg.sender
➝ No one can send messages on behalf of another user.

The only action performed is emitting an event with the message — nothing more.

🔧 How It Works
1. Send a message
function leaveMessage(string memory _message) external;


Internal checks:

Message cannot be empty

Message length ≤ 200 bytes

Wallet must not exceed 5 messages total

After submission, the contract emits:

event NewMessage(address indexed sender, string message, uint256 count);


count represents how many messages that wallet has sent so far.

🧪 Deployment

The contract uses Solidity 0.8.30, making it compatible with:

Remix

Hardhat

Foundry

Any EVM-compatible network (Mainnet, Testnet, ARC, etc.)

🔌 Example Interaction (JavaScript / Ethers.js)
const contract = new ethers.Contract(address, abi, signer);

await contract.leaveMessage("Hello blockchain!");

📂 Contract Structure Overview
uint256 public constant MAX_MESSAGES = 5;
uint256 public constant MAX_MESSAGE_LENGTH = 200;

mapping(address => uint256) private messageCount;


Straightforward, efficient, and minimalistic.

🧭 Project Purpose

This contract is ideal for:

Web3 front-end testing

Educational dApps

On-chain interaction exercises

Public message walls

Immutable micro-records

🛠️ License

This project is released under the MIT License — free to use and modify.
