// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract BasicBank {
    /// @notice deposit ether into the contract
    /// @dev it should work properly when called multiple times
    function addEther() external payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    /// @notice used to withdraw ether from the contract (No restriction on withdrawals)
    function removeEther(uint256 amount) external payable {
        require(address(this).balance >= amount, "Cannot remove more than amount");
        (bool success,) = payable(address(msg.sender)).call{value: amount}("");
        require(success, "Transfer failed");
    }
}
