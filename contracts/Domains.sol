// SPDX-License-Identifiier: UNLICENSED

pragma solidity ^0.8.10;

import "hardhat/console.sol";

contract Domains {
    //mapping for domains
    mapping(string => address) public domains;
    //mapping for records
    mapping(string => address) public records;

    constructor(){
        console.log("contract... nice");
    }

    //register function
    function register(string calldata name) public {
        //check if name exists
        require(domains[name] == address(0));
        domains[name] = msg.sender;
        console.log("%s has registered a domain!", msg.sender);
    }

    //domain owners address
    function getAddress(string calldata name) public view returns (address) {
        return domains[name];
    }

    function setRecord(string calldata name, string calldata record) public {
        //check owner is transaction sender
        require(domains[name] == msg.sender);
        records[name] = record;
    }

    function getRecord(string calldata name) public view returns(string memory){
        return records[name];
    }
}