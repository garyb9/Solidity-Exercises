// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */
    struct Deposit {
        uint256 balance;
        uint256 depositBlock;
    }

    mapping(address => Deposit) public deposits;

    function balanceOf(address user) public view returns (uint256) {
        // return the user's balance in the contract
        return deposits[user].balance;
    }

    function depositEther() external payable {
        /// add code here
        uint256 lastBalance = this.balanceOf(msg.sender);
        Deposit memory newDeposit = Deposit(lastBalance + msg.value, block.timestamp);
        deposits[msg.sender] = newDeposit;
    }

    function withdrawEther(uint256 amount) external {
        /// add code here
        require(balanceOf(msg.sender) >= amount, "Cannot withdraw amount");
        require(deposits[msg.sender].depositBlock + 1 weeks <= block.timestamp, "Cannot withdraw yet");

        uint256 lastBalance = this.balanceOf(msg.sender);
        Deposit memory updatedDeposit = Deposit(lastBalance - amount, block.timestamp);
        deposits[msg.sender] = updatedDeposit;
        (bool success,) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
    }
}
