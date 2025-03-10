// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Distribute {
    /*
        This exercise assumes you know how to sending Ether.
        1. This contract has some ether in it, distribute it equally among the
           array of addresses that is passed as argument.
        2. Write your code in the `distributeEther` function.
    */

    constructor() payable {}

    function distributeEther(address[] memory addresses) public {
        uint256 share = address(this).balance / addresses.length;
        for (uint8 i = 0; i < addresses.length; i++) {
            address payable addr = payable(addresses[i]);
            (bool success,) = addr.call{value: share}("");
            require(success, "Failed to send Ether");
        }
    }
}
