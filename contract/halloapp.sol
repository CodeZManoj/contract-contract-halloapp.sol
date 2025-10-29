// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
 * @title HelloApp
 * @dev A beginner-friendly Blockchain-based savings account
 *      where users can deposit, withdraw fixed amounts, and
 *      view their transaction history.
 */

contract HelloApp {

    struct Transaction {
        string txType;   // "Deposit" or "Withdraw"
        uint amount;     // in wei
        uint timestamp;  // time of transaction
    }

    mapping(address => uint) public balances;
    mapping(address => Transaction[]) private transactions;

    uint public fixedDepositAmount = 0.01 ether;
    uint public fixedWithdrawAmount = 0.005 ether;

    // Deposit Ether (no argument needed)
    function deposit() public payable {
        require(msg.value == fixedDepositAmount, "Send exact deposit amount");
        balances[msg.sender] += msg.value;

        transactions[msg.sender].push(Transaction("Deposit", msg.value, block.timestamp));
    }

    // Withdraw a fixed amount (no argument)
    function withdraw() public {
        require(balances[msg.sender] >= fixedWithdrawAmount, "Insufficient balance");
        balances[msg.sender] -= fixedWithdrawAmount;

        payable(msg.sender).transfer(fixedWithdrawAmount);
        transactions[msg.sender].push(Transaction("Withdraw", fixedWithdrawAmount, block.timestamp));
    }

    // View your current balance
    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }

    // View your transaction history
    function getMyTransactions() public view returns (Transaction[] memory) {
        return transactions[msg.sender];
    }
}
