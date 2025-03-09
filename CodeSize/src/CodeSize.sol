// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CodeSize {
    /**
     * The challenge is to create a contract whose runtime code (bytecode) size is greater than 1kb but less than 4kb
     */
    address public x;
    address public y;
    uint256 public a;
    uint256 public b;
    mapping(address => uint256) public balances;

    constructor() {
        balances[address(0)] = 1 ether;
        balances[msg.sender] = 1 ether;
        x = msg.sender;
        y = msg.sender;
        a = 999999999999999999999999;
        b = 9999999999999999999999999;
    }

    function asdasdasd() external view returns (uint256) {
        return a;
    }

    function asdaasdasdasdsdasd() external view returns (uint256) {
        return a;
    }

    function asdasdasdasdasdasd() external view returns (uint256) {
        return a;
    }

    function asdasasdasdasddasd() external view returns (uint256) {
        return a;
    }

    function asdasasdaasdasdasdsdasddasd() external view returns (uint256) {
        return a;
    }

    function asdasasasdasddasdasddasd() external view returns (uint256) {
        return a;
    }

    function asdasasdasdasasdasdasdddasd() external view returns (uint256) {
        return a;
    }

    function asdasasdasdasasdaasdasdasdssdasdddasd() external view returns (uint256) {
        return a;
    }
}
