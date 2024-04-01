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

contract ManualToken {
    uint256 initialSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // transfer tokens.
    // Subtract "from" address amount and add to "to" address.

    function _transfer(address from, address to, uint256 amount) public {
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
    }

    function _transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        // implement taking fun from the user.
        require(_value <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] -= _value;
        allowance[_to][msg.sender] += _value;
        _transfer(_from, _to, _value);
        return true;
    }
}
