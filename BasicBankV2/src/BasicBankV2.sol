// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract BasicBankV2 {
    /// used to store the balance of users
    ///     USER    =>  BALANCE
    mapping(address => uint256) public balances;

    /// @notice deposit ether into the contract
    /// @dev it should work properly when called multiple times
    function addEther() external payable {
        balances[msg.sender] = msg.value;
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    /// @notice used to withdraw ether from the contract
    /// @param amount of ether to remove. Cannot execeed balance i.e users cannot withdraw more than they deposited
    function removeEther(uint256 amount) external payable {
        require(balances[msg.sender] >= amount, "Insufficient balance for user");
        uint256 balance = balances[msg.sender];
        balances[msg.sender] = balance - amount;
        (bool success,) = payable(address(msg.sender)).call{value: amount}("");
        require(success, "Transfer failed");
    }
}
