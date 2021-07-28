pragma solidity ^0.6.10;
// SPDX-License-Identifier: MIT

contract MyContract
{
    address owner;
    uint time = block.timestamp;
    address constant myAddress = 0x583031D1113aD414F02576BD6afaBfb302140225;
    uint amount = 50 ether;
    address payable kinAddress = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148;
    
    modifier only_owner()
    {
        require(msg.sender==owner);
        _;
    }
    
    modifier time_validation()
    {
        require(block.timestamp >= time);
        _;
    }
    
    constructor()
    public
    {
        owner = msg.sender;
    }
    
    function Time_Left()
    public view returns(uint , string memory, uint, string memory)
    {
        return ((time-block.timestamp)/(60*60*24*365), "year(s)", (time-block.timestamp), "second(s)");
    }
    
    function Get_Balance() 
    public only_owner view returns (uint256) 
    {
        return myAddress.balance;
    }
    
    function Increment_Time()
    public only_owner
    {
        time += 31556926;
    }
    
    function Transfer_Status()
    public view returns(string memory)
    {
        if(block.timestamp>=time)
        {
            return "You can transfer the funds now.";
        }
        else
        {
            return "You can NOT transfer the funds now.";
        }
    }
    
    function Tranfer_Funds() 
    payable public time_validation
    {
        require(msg.value <= amount);
        kinAddress.transfer(msg.value);
    }
}
