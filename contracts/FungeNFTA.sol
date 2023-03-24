// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
/*
* Goerli contract address: 
* 0xCe8771D0b27a3e9aA7FEC79A8b7fdC95927ac567 
* Owned:0xeBd44c4Bb5d3334990D3398747631c7d6C36a53D
* Test Account: 0xd31ABCf1d67dc1FB764aF1B2639115cff0fE1f95
* 
*/

contract FungeNFTA is ERC1155, Ownable {
    constructor() ERC1155("https://api.mysite.com/tokens/{id}.json") {}

    function setURI(string memory nemuri) public onlyOwner {
        _setURI(nemuri);
    }

    function mint(address account, uint256 id, uint256 amount, bytes calldata data) public onlyOwner {
        _mint(account, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes calldata data) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }
}