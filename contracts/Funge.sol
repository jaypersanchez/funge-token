// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;

// This is just a simple example of a coin-like contract.
// It is not ERC20 compatible and cannot be expected to talk to other
// coin/token contracts.

contract Funge {

	string public constant name = "Funge";
    string public constant symbol = "FNG";
    uint8 public constant decimals = 18;
	address public minter;
	uint256 totalSupply_;
	mapping (address => uint) public balances;

	event Sent(address from, address to, uint amount);
	event Mint(address receiver, uint amount);

	constructor(uint256 total) {
		minter = msg.sender;
		totalSupply_= total;
		balances[msg.sender] = totalSupply_;
	}

	function mint(address receiver, uint amount) public {
		require(msg.sender == minter);
		balances[receiver] += amount;
		emit Mint(receiver, amount);
	}

	function send(address receiver, uint amount) public {
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		emit Sent(msg.sender, receiver, amount);
	}
}
