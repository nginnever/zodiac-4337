// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import "./MultisendEncoder.sol";

contract MockOZ is EIP712 {
    mapping(address => bool) public hasVoted;
    string internal name = "test";
    /// @dev Functions restricted to `onlyGovernance()` are only callable by `owner`.
    address public owner;
    /// @dev Address of the multisend contract that this contract should use to bundle transactions.
    address public multisend;
    /// @dev Address that this module will pass transactions to.
    address public target;

    bytes32 public constant BALLOT_TYPEHASH = keccak256("Ballot(uint256 proposalId,uint8 support)");

    constructor(
        address _owner,
        address _target,
        address _multisend
    ) EIP712(name, version()) {
        owner = _owner;
        target = _target;
        multisend = _multisend;
    }

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