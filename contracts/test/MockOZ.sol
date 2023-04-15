// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.12;

contract MockOZ {
    mapping(address => bool) public hasVoted;

    function castVote(
        uint256 proposalId,
        address account,
        uint8 support,
        string memory reason
    ) public {
        hasVoted[msg.sender] = true;
    }
}