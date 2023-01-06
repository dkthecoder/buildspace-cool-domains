// SPDX-License-Identifiier: UNLICENSED

pragma solidity ^0.8.10;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import {StringUtils} from "./libraries/StringUtils.sol";
// We import another help function
import "@openzeppelin/contracts/utils/Base64.sol";
import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract Domains is ERC721URIStorage {
    // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    //domain top-level
    string public tld;

    // We'll be storing our NFT images on chain as SVGs
    string svgPartOne ='<svg xmlns="http://www.w3.org/2000/svg" width="270" height="270" fill="none"><path fill="url(#a)" d="M0 0h270v270H0z"/><defs><filter id="b" color-interpolation-filters="sRGB" filterUnits="userSpaceOnUse" height="270" width="270"><feDropShadow dx="0" dy="1" stdDeviation="2" flood-opacity=".225" width="200%" height="200%"/></filter></defs><path style="fill:#8ce16e" d="M53.988 9.779c-2.085.95-5.921 3.061-9.694 7.034l-13.887-.03S39.349 5.75 53.852 8.721c.532.108.633.831.138 1.057z"/><path style="fill:#7dc86e" d="M36.859 16.795c5.577-6.168 14.151-7.423 17.406-7.678.076.247.007.531-.276.661-2.085.95-5.921 3.061-9.694 7.034l-7.435-.017zM34.383 1.4l.96 11.53h4.309l.96-11.53A1.293 1.293 0 0 0 39.327 0h-3.655a1.293 1.293 0 0 0-1.288 1.4z"/><path style="fill:#8ce16e" d="M21.012 9.779c2.085.95 5.921 3.061 9.694 7.034l13.887-.03S35.651 5.75 21.15 8.721c-.532.108-.633.831-.138 1.057z"/><path style="fill:#7dc86e" d="M38.141 16.795c-5.577-6.168-14.151-7.423-17.406-7.678-.076.247-.007.531.276.661 2.085.95 5.921 3.061 9.694 7.034l7.435-.017z"/><path style="fill:#ff5050" d="M37.5 75c3.861 0 6.306-1.838 9.053-5.063 6.466-7.595 15.518-29.097 15.518-36.702-.001-8.858-7.76-17.717-24.571-17.717s-24.57 8.859-24.57 17.718c0 7.606 9.053 29.109 15.518 36.702C31.194 73.162 33.641 75 37.5 75z"/><path style="fill:#c84146" d="M36.558 72.456a2.692 2.692 0 0 0-.03-2.195c-5.379-11.729-10.666-28.683-10.666-35.76 0-5.688 2.178-11.36 6.688-15.46.483-.44.706-1.095.549-1.728-.214-.861-1.048-1.443-1.926-1.306-12.426 1.936-18.243 9.572-18.243 17.229 0 7.606 9.053 29.109 15.518 36.702 1.408 1.655 2.744 2.936 4.229 3.793 1.419.819 3.236.232 3.881-1.273z"/><path style="fill:#ffdc64" d="M32.328 41.379a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zm10.344 0a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293a1.292 1.292 0 0 1-1.293 1.293zm10.346 0a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293z"/><path style="fill:#ffc850" d="M21.982 41.379a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293a1.292 1.292 0 0 1-1.293 1.293z"/><path style="fill:#ffdc64" d="M32.328 28.447a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zm10.344 0a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293a1.292 1.292 0 0 1-1.293 1.293zm10.346 0a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293z"/><path style="fill:#ffc850" d="M21.982 28.447a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293a1.292 1.292 0 0 1-1.293 1.293z"/><path style="fill:#ffdc64" d="M37.5 47.844a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zm10.344 0a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zm-20.689 0a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zm5.173 6.466a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zm10.344 0a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293a1.292 1.292 0 0 1-1.293 1.293zm10.346 0a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293z"/><path style="fill:#ffc850" d="M21.982 54.311a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293a1.292 1.292 0 0 1-1.293 1.293zm10.346 12.93a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293z"/><path style="fill:#ffdc64" d="M42.672 67.242a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293a1.292 1.292 0 0 1-1.293 1.293zM37.5 60.776a1.293 1.293 0 0 1-1.293-1.293V58.19a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zm10.344 0a1.293 1.293 0 0 1-1.293-1.293V58.19a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293z"/><path style="fill:#ffc850" d="M27.156 60.776a1.293 1.293 0 0 1-1.293-1.293V58.19a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293z"/><path style="fill:#ffdc64" d="M37.5 73.707a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zm0-38.793a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293z"/><path style="fill:#ffc850" d="M16.811 34.914a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293z"/><path style="fill:#ffdc64" d="M47.844 34.914a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zm10.344 0a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zm-31.034 0a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zM37.5 21.982a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zm10.344 0a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293z"/><path style="fill:#ffc850" d="M27.156 21.982a1.293 1.293 0 0 1-1.293-1.293v-1.293a1.293 1.293 0 1 1 2.586 0v1.293c0 .714-.579 1.293-1.293 1.293zm.207 22.024c-.071-.012-.134-.042-.207-.042-.714 0-1.293.579-1.293 1.293v1.293c0 .714.579 1.293 1.293 1.293.446 0 .821-.24 1.053-.584a110.118 110.118 0 0 1-.846-3.253zm-10.608 3.827c.019.002.038.011.057.011.714 0 1.293-.579 1.293-1.293v-1.293a1.293 1.293 0 0 0-2.479-.512c.351 1.008.729 2.042 1.129 3.085zM36.537 70.28a1.275 1.275 0 0 0-.327.839v1.293c0 .174.038.339.099.491.095-.14.183-.286.254-.447a2.694 2.694 0 0 0-.024-2.175z"/><path style="fill:#ffdc64" d="M58.189 43.966c-.714 0-1.293.579-1.293 1.293v1.293c0 .714.579 1.293 1.293 1.293.019 0 .038-.011.057-.011a105.501 105.501 0 0 0 1.129-3.085 1.29 1.29 0 0 0-1.187-.782z"/><defs><linearGradient id="a" x1="0" y1="0" x2="270" y2="270" gradientUnits="userSpaceOnUse"><stop stop-color="#eb3000"/><stop offset="1" stop-color="#0cd7e4" stop-opacity=".99"/></linearGradient></defs><text x="32.5" y="231" font-size="22" fill="#fff" filter="url(#b)" font-family="Plus Jakarta Sans,DejaVu Sans,Noto Color Emoji,Apple Color Emoji,sans-serif" font-weight="bold">mortal.strawberry';
    string svgPartTwo = "</text></svg>";

    //mapping for domains and records
    mapping(string => address) public domains;
    mapping(string => string) public records;

    constructor(string memory _tld) payable ERC721("Strawberry Name Service", "SNS"){
        tld = _tld;
        console.log("%s name service deployed", _tld);
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
        require(domains[name] == address(0));

        uint256 _price = price(name);
        require(msg.value >= _price, "Not enough Matic paid");

        // Combine the name passed into the function  with the TLD
        string memory _name = string(abi.encodePacked(name, ".", tld));
        // Create the SVG (image) for the NFT with the name
        string memory finalSvg = string(abi.encodePacked(svgPartOne, _name, svgPartTwo));
        uint256 newRecordId = _tokenIds.current();
        uint256 length = StringUtils.strlen(name);
        string memory strLen = Strings.toString(length);

        console.log("Registering %s.%s on the contract with tokenID %d", name, newRecordId);

        // Create the JSON metadata of our NFT. We do this by combining strings and encoding as base64
        string memory json = Base64.encode(
            abi.encodePacked('{"name": "', _name, '", "description": "A domain on the Strawberry name service", "image": "data:image/svg+xml;base64,',
                Base64.encode(bytes(finalSvg)), '","length":"', strLen, '"}'
            )
        );

        string memory finalTokenUri = string(abi.encodePacked("data:application/json;base64,", json));

        console.log("\n--------------------------------------------------------");
        console.log("Final tokenURI", finalTokenUri);
        console.log("--------------------------------------------------------\n");

        //Mint NFT to newRecordId
        _safeMint(msg.sender, newRecordId);
        //set NFT data
        _setTokenURI(newRecordId, finalTokenUri);
        domains[name] = msg.sender;

        _tokenIds.increment();
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
