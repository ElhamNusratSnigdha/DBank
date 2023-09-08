// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Dbank{
    mapping (address=>uint) private balance;
    event deposited(address depositor, uint amount);
    event withdrawed(address withdrawer, uint amount);
    event transferred(address from, address to, uint amount);

    function deposit() public payable {
        require(msg.value>0 ether, "Insufficient amount");
        balance[msg.sender] += msg.value;
        emit deposited(msg.sender,msg.value);
    }

    function getBalance() public view returns(uint){
        return balance[msg.sender];
    }

    function withdraw(uint amount) external{ //extrernal=> does not allow other function to call it inside the same class
        require(amount>0,"Zero amount not possible");
        require(amount<=balance[msg.sender],"Insufficient Balance");
        balance[msg.sender] -= amount;
        payable (msg.sender).transfer(amount);
        emit withdrawed(msg.sender,amount);
    }

    function transferTo(address _to, uint amount) external{
        require(amount<=balance[msg.sender],"Insufficient funds");
        require(_to!=address(0),"Address invalid");
        balance[msg.sender] -= amount;
        balance[_to] += amount;
        payable (_to).transfer(amount);
        emit transferred(msg.sender, _to, amount);
    }
}