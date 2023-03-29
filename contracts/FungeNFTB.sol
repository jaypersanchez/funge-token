// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
/*
* Goerli contract address: 
* 0xAB0199069C72D2F02c8F2AA2Eb117D918Cb9Bbaf 
* Owned:0xd31ABCf1d67dc1FB764aF1B2639115cff0fE1f95
* Test Account: 0xeBd44c4Bb5d3334990D3398747631c7d6C36a53D
* 
* Mumbai Deployed: 0x238b8a1B9E8Bd079A54ece2b76D91f6E20100b62
* Owned: 0x1eeaa3A034725fd932EeD8165A20b5F43AE631a1
*/

contract FungeNFTB is ERC1155, Ownable {
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