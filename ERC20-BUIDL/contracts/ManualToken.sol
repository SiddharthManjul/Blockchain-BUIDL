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
    mapping(address => uint256) public balanceOf;

    // Address allowing another address to spend in terms of int.
    mapping(address => mapping(address => uint256)) allowance;

    // Events.

    // Notifying about the Transfer.
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Notifying about the Approval from owner to Spender.
    event Approve(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    // Notifying clients about the amount burned.
    event Burn(address indexed from, uint256 value);

    /**
     * Constructor.
     * @dev Initializing contract with initial supply tokens to the contract.
     * @param initialSupply - Update total supply with the decimal amount.
     * @param tokenName - Set the name of Token for Display Purpose and Definition.
     * @param tokenSymbol - Set the Symbol of Token for Display and Definition Purpose.
     */
    constructor(
        uint256 initialSupply,
        string memory tokenName,
        string memory tokenSymbol
    ) {
        totalSupply = initialSupply * 10 ** uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
        name = tokenName;
        symbol = tokenSymbol;
    }

    /**
     * @dev _transfer function - for internal transfer, can be called by contract only.
     * @param _from - Sender address.
     * @param _to - Receiver address.
     * @param _value - Amount to send.
     */
    function _transfer(address _from, address _to, uint256 _value) internal {
        
        // Prevent trasnfer to 0x0(Genesis/Null) address. Use burn().
        require(_to != address(0x0));

        // Check if the sender has enough amount.
        require(balanceOf[_from] >= _value);

        // Check overflows.
        require(balanceOf[_to] + _value >= balanceOf[_to]);

        // Save balance for future assertion.
        uint256 previousBalances = balanceOf[_from] + balanceOf[_to];

        // Subtract the sent amount from sender.
        balanceOf[_from] -= _value;

        // Add the same to the receiver.
        balanceOf[_to] += _value;

        // Transfer Event.
        emit Transfer(_from, _to, _value);

        /**
         * @dev Asserting whether the current balance is equal to previousBalances or not.
         * Assert are used to use static analysis to find bugs in code. They should never fail.
         */

        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }

    /**
     * @dev Transfer "_value" tokens to "_to" from your account.
     * @param _to - Address of receiver.
     * @param _value - Amount to Send.
     */
    function transfer(address _to, uint256 _value) public returns (bool success) {
        _transfer(msg.sender, _to, _value);
        return true;
    }

    /**
     * @dev Transfer tokend from other address. Send "_value" tokens to "_to" on behalf of "_from".
     * @param _from - Address of Sender.
     * @param _to - Address of Receiver.
     * @param _value - Amount to Send.
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {

        // Check Allowance.
        require(_value <= allowance[_from][msg.sender]); 

        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

}
