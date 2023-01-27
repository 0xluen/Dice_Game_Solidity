pragma solidity ^0.8.0;

contract DiceGame {

    address public owner;
    mapping(address => uint) public playerBalances;


    function rollDice() public payable {
        require(msg.value > 0, "You must send a positive value to roll the dice.");
        require(playerBalances[msg.sender] >= msg.value, "You do not have enough balance to roll the dice.");
        uint roll = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % 6 + 1;
        if (roll < msg.value) {
            playerBalances[msg.sender] += msg.value * 2;
        } else {
            playerBalances[msg.sender] -= msg.value;
        }
    }

    function getBalance() public view returns (uint) {
        return playerBalances[msg.sender];
    }

    function withdraw() public {
        msg.sender.transfer(address(this).balance);
    }
}