// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./ERC20.sol";


contract MY_TOKEN is ERC20 {
    address public owner;
    // Constructor del Smart Contract
    constructor(address _owner) ERC20("Rather", "RTH") {
        owner = _owner;
    }

     modifier onlyOwner() {
        require(msg.sender == owner, "You're not the owner");
        _;
    }

    // Creacion de nuevos Tokens
    function crearTokens() public onlyOwner {
        _mint(msg.sender, 100e18);
    }

    function burnTokens(address account, uint amount) public onlyOwner {
        _burn(account,amount);
    }
}