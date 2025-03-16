// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Testament
 * @dev A simple inheritance contract that allows users to create a testament.
 */
 
contract Testament {
    address private _manager; // Address of the contract manager (set to deployer)
    mapping(address => address) private _heir; // Maps an owner to their designated heir
    mapping(address => uint) private _balance; // Maps an owner to their testament amount (ETH)
    mapping(address => uint) private _createdAt; // Records the timestamp when a testament is created

    event Create(address indexed owner, address indexed heir, uint amount, uint timestamp); // Event when testament is created
    event Report(address indexed owner, address indexed heir, uint amount, uint timestamp); // Event when death is reported and funds transferred

    constructor() {
        _manager = msg.sender;
    }

    function create(address heir) public payable {
        require(msg.value > 0, "Please send some ETH"); // Must deposit ETH
        require(_balance[msg.sender] == 0, "Testament already exists"); // Prevent duplicate testaments
        require(heir != address(0), "Invalid heir address"); // Heir must be a valid address

        _heir[msg.sender] = heir;
        _balance[msg.sender] = msg.value;
        _createdAt[msg.sender] = block.timestamp;

        emit Create(msg.sender, heir, msg.value, block.timestamp);
    }

    function getTestament(address owner) public view returns (address heir, uint amount, uint createdAt) {
        return (_heir[owner], _balance[owner], _createdAt[owner]);
    }

    function reportOfDeath(address owner) public {
        require(msg.sender == _manager, "Only manager can do this"); // Only the manager can execute
        require(_balance[owner] > 0, "No testament exists"); // Ensure there is a valid testament

        address heir = _heir[owner];
        uint amount = _balance[owner];

        // Reset state before transferring funds (prevents re-entrancy)
        _balance[owner] = 0;
        _heir[owner] = address(0);
        _createdAt[owner] = 0;

        emit Report(owner, heir, amount, block.timestamp);

        (bool success, ) = payable(heir).call{value: amount}("");
        require(success, "Transfer to heir failed");
    }
}