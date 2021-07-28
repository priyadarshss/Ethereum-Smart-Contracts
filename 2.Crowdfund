pragma solidity ^0.7.0;
//SPDX-License-Identifier: MIT

contract Projects{
    address[] public deployedProjects;
    
    function createProject(uint minimum) public{
        address newProject = address(new Crowdfund(minimum, msg.sender));
        deployedProjects.push(newProject);
    }
    
    function allDeployedProjects()public view returns(address[] memory){
        return deployedProjects;
    }
}

contract Crowdfund{
    
    struct Request{
        string description;
        uint value;
        address payable recipient;
        bool complete;
        uint votes;
        mapping(address => bool)voters;
    }
    
    address public fundraiser;
    uint public minAmount;
    mapping(address => bool) backers;
    uint public backersCount;

    modifier owner(){
        require(msg.sender==fundraiser);
        _;
    }
    
    constructor(uint min, address creator){
        fundraiser=creator;
        minAmount=min;
    }
    
    function contribute() public payable{
        require(msg.value>=minAmount);
        backers[msg.sender]=true;
        backersCount++;
    }
    
    uint numRequests;
    mapping (uint => Request) public requests;
    
    function createRequest (string memory description, uint value, address payable recipient) public owner{
                Request storage r = requests[numRequests++];
                r.description = description;
                r.value = value;
                r.recipient = recipient;
                r.complete = false;
                r.votes = 0;
    }
    
    function approveRequest(uint index) public{
        require(backers[msg.sender]);
        require(!requests[index].voters[msg.sender]);

        requests[index].voters[msg.sender]=true;
        requests[index].votes++;
    }
    
    function finalizeRequest(uint index) public owner payable{
        require(!requests[index].complete);
        require(requests[index].votes>=backersCount/2);
        
        requests[index].recipient.transfer(requests[index].value);
        requests[index].complete=true;
        
    }
    
    function contractBalance() public view returns(uint) {
        return address(this).balance;
    }
    
}
