pragma solidity ^0.6.10;
// SPDX-License-Identifier: MIT

contract MyContract
{
    address owner;
    uint time = block.timestamp;
    string y;
    address constant myAddress = 0xcCF29f1482a193f8490Ad2CA7F60e89016BDf76f;
    
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
    
    function Tranfer_Funds(address payable receiver) 
    payable external time_validation
    {
        uint256 amount = msg.value;
        receiver.transfer(amount);  
    }
}
