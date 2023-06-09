// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    uint256 seed;
    mapping (address => uint256) lastWavedAt ;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    constructor() payable {
        console.log("contract creation msg");
        seed = (block.difficulty + block.timestamp + seed) % 100;
    }

    function wave(string memory _message) public {
        require(
                lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
                "Wait 30 seconds "
        );
        lastWavedAt[msg.sender] = block.timestamp ;
        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);
        waves.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generaded %d", seed);
        if (seed < 50) {
            console.log("%d is won", msg.sender);
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "trying to withdraw more money that the contract has"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract");
        }
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}
