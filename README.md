# contract-contract-halloapp.sol
Blockchain-based savings account with transaction history.
# 👋 HalloApp - Blockchain-Based Savings Account with Transaction History

**HalloApp** is a beginner-friendly **Solidity smart contract** that allows users to **save Ether**, **withdraw funds**, and **view their transaction history** — directly on the blockchain.  

Think of it as your **decentralized savings account**, where you’re your own bank.

---

## 🧩 Features

- 💰 **Deposit Ether** securely into your HalloApp account  
- 💸 **Withdraw funds** anytime  
- 🧾 **Automatic transaction history** (with timestamp & type)  
- 🔐 **User-specific balance tracking**  
- 🧠 Simple and beginner-friendly Solidity codebase  

---

## ⚙️ Tech Stack

| Component | Description |
|------------|-------------|
| **Language** | Solidity v0.8.x |
| **IDE** | Remix Ethereum IDE |
| **Blockchain** | Ethereum Virtual Machine (EVM) compatible |
| **License** | MIT |

---

## 📜 Smart Contract Code — `HalloApp.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title HalloApp - A Blockchain-based Savings Account with Transaction History
/// @notice Allows users to deposit, withdraw, and view their transaction history.
/// @dev Beginner-friendly Solidity project.

contract HalloApp {

    // Structure to store each transaction
    struct Transaction {
        uint256 amount;
        string txnType; // "Deposit" or "Withdraw"
        uint256 timestamp;
    }

    // Mapping of user address to balance
    mapping(address => uint256) public balances;

    // Mapping of user address to their transaction history
    mapping(address => Transaction[]) private transactionHistory;

    /// @notice Deposit Ether into your HalloApp savings account
    function deposit() external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");

        balances[msg.sender] += msg.value;

        transactionHistory[msg.sender].push(
            Transaction(msg.value, "Deposit", block.timestamp)
        );
    }

    /// @notice Withdraw Ether from your HalloApp account
    /// @param amount The amount to withdraw (in wei)
    function withdraw(uint256 amount) external {
        require(amount > 0, "Withdrawal amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

        transactionHistory[msg.sender].push(
            Transaction(amount, "Withdraw", block.timestamp)
        );
    }

    /// @notice View your current balance
    /// @return Balance in wei
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    /// @notice Get your transaction history
    /// @return Array of all transactions
    function getTransactionHistory()
        external
        view
        returns (Transaction[] memory)
    {
        return transactionHistory[msg.sender];
    }
}
