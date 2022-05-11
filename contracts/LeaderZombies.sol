// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
pragma abicoder v2;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract LeaderZombies is ERC721A, Ownable, ReentrancyGuard {
    using Strings for uint256;
    
    uint256 public immutable collectionSize;

    string public defaultBaseURI;

    constructor(uint256 _collectionSize, string memory _defaultBaseURI) ERC721A("Fantom Zombies Leader", "LEADERZOMBIES") {
        collectionSize = _collectionSize;
        defaultBaseURI = _defaultBaseURI;
    }

    function give(address to, uint256 quantity) external onlyOwner {
        require(_totalMinted() < collectionSize, "Limit reached.");
        _safeMint(to, quantity);
    }

    function withdraw() external onlyOwner nonReentrant {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Withdraw failed.");
    }

    function tokenURI(uint256 tokenId) public view override(ERC721A) returns (string memory) {
        return string(abi.encodePacked(_baseURI(), tokenId.toString(), ".json"));
    }

    function _baseURI() internal view override(ERC721A) returns (string memory) {
        return defaultBaseURI;
    }
}