//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract Bank {

    mapping(address => uint) private balances;

    event Deposit(address indexed owner, uint amount);
    event Withdraw(address indexed owner, uint amount);
    event Transfer(address indexed from, address indexed to, uint indexed amount);
    event Buy      (address indexed buyer, string itemName, uint indexed quantity);

    function deposit(address _account, uint _number) public payable {
        balances[_account] += _number;
        emit Deposit(_account, _number);
    }

    function withdraw(address _account, uint _number) public payable {
        require(balances[_account] > 0, "You're broke!");
        balances[_account] -= _number;
        emit Withdraw(_account, _number);
    }

    function transfer(address _from, address _to, uint _number) public payable {
        require(balances[_from] >= _number, "You do not have enough funds for this transaction");
        balances[_from] -= _number;
        balances[_to] += _number;
        emit Transfer(_from, _to, _number);
    }

    function buyToken(address _buyer, string memory _tokenName, uint _quantity) public payable {
        require(balances[_buyer] >= _quantity, "Insufficient balance for purchase");
        balances[_buyer] -= _quantity;
        emit Purchase(_buyer, _tokenName, _quantity);
    }

    function getBalance(address _address) public view returns(uint) {
        return balances[_address];
    } 
}
