// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

// A simple NFT whitelist minting contract
contract WhitelistNFT is ERC721URIStorage {
    uint256 public tokenId;
    address public owner;

    mapping(address => bool) public whitelisted;

    constructor() ERC721("WhitelistNFT", "WLNFT") {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // Add addresses to whitelist
    function addToWhitelist(address[] memory users) public onlyOwner {
        for (uint256 i = 0; i < users.length; i++) {
            whitelisted[users[i]] = true;
        }
    }

    // Mint NFT if whitelisted
    function mint(string memory uri) public {
        require(whitelisted[msg.sender], "Not whitelisted");
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, uri);
        tokenId++;
    }
}
