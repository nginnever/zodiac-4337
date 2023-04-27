// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";

contract MockOZ is EIP712 {
    mapping(address => bool) public hasVoted;
    string internal name = "test";

    bytes32 public constant BALLOT_TYPEHASH = keccak256("Ballot(uint256 proposalId,uint8 support)");

    constructor() EIP712(name, version()) {}

    function castVote(
        uint256 proposalId,
        address account,
        uint8 support,
        string memory reason
    ) public {
        hasVoted[account] = true;
    }

    function castVoteBySig(
        uint256 proposalId,
        uint8 support,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public {
        address voter = ECDSA.recover(
            _hashTypedDataV4(keccak256(abi.encode(BALLOT_TYPEHASH, proposalId, support))),
            v,
            r,
            s
        );
        castVote(proposalId, voter, support, "");
    }

    function version() public view virtual returns (string memory) {
        return "1";
    }
}