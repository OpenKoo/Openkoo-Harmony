// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract Owned {
    address payable public owner;
    address private pendingOwner;

    event OwnershipTransferRequested(
        address indexed from,
        address indexed to
    );
    event OwnershipTransferred(
        address indexed from,
        address indexed to
    );

    constructor() {
        owner = msg.sender;

    }
    function transferOwnership(address _to)
        external
        onlyOwner()
        {
            pendingOwner = _to;
            
            emit OwnershipTransferRequested(owner, _to);

        }
    function acceptOwnership()
        external
        {
            require(msg.sender == pendingOwner, "Must be proposed owner");

            address oldOwner = owner;
            owner = msg.sender;
            pendingOwner = address(0);

            emit OwnershipTransferred(oldOwner, msg.sender);
            
        }

        modifier onlyOwner() {
            require(msg.sender == owner, "Only callable by owner");
            _;
        }
}