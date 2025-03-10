// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;

    // supporting only one buyer at a time
    struct BuyOrder {
        uint256 balance;
        uint256 timestamp;
        bool activeEscrow;
    }

    mapping(address => BuyOrder) public balances;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */
    constructor() {
        seller = msg.sender;
    }

    /**
     * creates a buy order between msg.sender and seller
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        require(!balances[msg.sender].activeEscrow, "Escrow already exists");
        balances[msg.sender] = BuyOrder(msg.value, block.timestamp, true);
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        require(balances[buyer].activeEscrow, "Escrow doesnt exists");
        require(balances[buyer].timestamp + 3 days <= block.timestamp, "Not enough time has passed");
        uint256 amount = balances[buyer].balance;
        balances[buyer] = BuyOrder(0, block.timestamp, false);
        (bool success,) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
    }

    /**
     * allows buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        require(balances[msg.sender].activeEscrow, "Escrow doesnt exists");
        require(balances[msg.sender].timestamp + 3 days > block.timestamp, "Escrow time has passed");
        uint256 amount = balances[msg.sender].balance;
        balances[msg.sender] = BuyOrder(0, block.timestamp, false);
        (bool success,) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        return balances[buyer].balance;
    }
}
