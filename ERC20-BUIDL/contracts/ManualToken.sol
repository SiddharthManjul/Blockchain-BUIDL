// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Uncomment this line to use console.log
import "hardhat/console.sol";

interface tokenRecipent {
    function receiveApproval(
        address _from,
        address _to,
        address _token,
        bytes calldata _extraData
    ) external;
}

contract BrooklynTokenBLT {

    // State or Public Variables of the Token.
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;

    // Mappings.

    // Balance in terms of int, finding against an address.
    mapping (address => uint256) public balanceOf;

    // Address allowing another address to spend in terms of int.
    mapping (address => mapping (address => uint256)) allowance;

    // Events.

    // Notifying about the Transfer.
    event Transfer(address indexed from, address indexed to, uint256 value); 

    // Notifying about the Approval from owner to Spender.
    event Approve(address indexed _owner, address indexed _spender, uint256 _value); 

    // Notifying clients about the amount burned.
    event Burn(address indexed from, uint256 value); 
}
