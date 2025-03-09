// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */

    address public highestBidder;
    uint256 public highestBid = 0;
    uint256 public endTime;

    function bet() public payable {
        // your code here
        if (msg.value > highestBid) {
            highestBid = msg.value;
            highestBidder = msg.sender;
            endTime = block.timestamp + 3600;
        }
    }

    function claimPrize() public {
        require(msg.sender == highestBidder, "Not the highest bidder");
        require(block.timestamp >= endTime, "Not ended yet");
        (bool success,) = payable(highestBidder).call{value: address(this).balance}("");
        require(success, "Failed to send Ether");
    }
}
