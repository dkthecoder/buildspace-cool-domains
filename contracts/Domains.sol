// SPDX-License-Identifiier: UNLICENSED

pragma solidity ^0.8.10;

// Don't forget to add this import
import {StringUtils} from "./libraries/StringUtils.sol";
import "hardhat/console.sol";

contract Domains {
    //domain top-level
    string public tld;

    //mapping for domains and records
    mapping(string => address) public domains;
    mapping(string => string) public records;

    constructor(string memory _tld) payable {
        tld = _tld;
        console.log("contract... nice");
    }

    //price based on length function
    function price(string calldata name) public pure returns (unit) {
        uint256 len = StringUtils.strlen(name);
        require(len > 0);
        if (len == 3) {
            return 5 * 10**17; // 5 MATIC = 5 000 000 000 000 000 000 (18 decimals). We're going with 0.5 Matic cause the faucets don't give a lot
        } else if (len == 4) {
            return 3 * 10**17; // To charge smaller amounts, reduce the decimals. This is 0.3
        } else {
            return 1 * 10**17;
        }
    }

    //register function
    function register(string calldata name) public payable {
        // Check if name exists
        require(domains[name] == address(0));
        unit _price = price(name);

        // check if enough matic
        require(msg.value >= _price, "Not enough matic paid");

        domains[name] = msg.sender;
        console.log("%s has registered a domain!", msg.sender);
    }

    //domain owners address
    function getAddress(string calldata name) public view returns (address) {
        return domains[name];
    }

    function setRecord(string calldata name, string calldata record) public {
        // check owner is transaction owner
        require(domains[name] == msg.sender);
        records[name] = record;
    }

    function getRecord(string calldata name)
        public
        view
        returns (string memory)
    {
        return records[name];
    }
}
