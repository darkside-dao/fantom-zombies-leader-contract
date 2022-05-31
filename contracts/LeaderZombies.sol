//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
pragma abicoder v2;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract LeaderZombies is ERC721URIStorage, ERC721Enumerable, ERC721Burnable, ERC721Pausable, ReentrancyGuard, Ownable {
    using Counters for Counters.Counter;

    uint256 immutable public collectionSize;

    Counters.Counter private _tokenIds;

    mapping(uint256 => string) private _tokenURIs;

    constructor(uint256 _collectionSize) ERC721("Fantom Zombies: Leaders", "LEADERZ") {
        collectionSize = _collectionSize;
        _tokenIds.increment();
    }

    function give(address to, uint256 quantity) external onlyOwner {
        uint256 tokenId = _tokenIds.current();
        require((tokenId - 1) + quantity < collectionSize, "Collection size reached");
        for (uint256 i; i < quantity; i++) {
            _safeMint(to, tokenId + i);
        }
    }

    function setTokenURI(uint256 tokenId, string calldata _tokenURI) public onlyOwner {
        _setTokenURI(tokenId, _tokenURI);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        require(_exists(tokenId), "URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        if (bytes(base).length == 0) {
            return _tokenURI;
        }

        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        return super.tokenURI(tokenId);
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal override(ERC721URIStorage) {
        require(_exists(tokenId), "URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable, ERC721Pausable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}