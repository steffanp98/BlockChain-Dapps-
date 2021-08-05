// SPDX-License-Identifier: MIT
// declare the version of solidity 
pragma solidity ^0.5.16;
//declare the smart contract
contract Election {
    //candidate struct for candidate attributes
    struct Candidate{
    uint id;
    string name;
    uint voteCount;
    }

    //map accounts which have voted
    mapping(address => bool) public voters;
    //store and fetch candidate 
    mapping(uint => Candidate) public candidates;

    //store  count number for each candidate
    uint public candidateCount;

    //vote event - links to the js func
    //NOTE: removes console error 
    event votedEvent(
        uint indexed _candidateid
    );
   
    constructor()public{
        //state var - accessible inside of the contract
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }  

    function addCandidate(string memory _name) private {
        candidateCount ++;
        candidates[candidateCount] = Candidate(candidateCount,_name,0);
    } 

    function vote(uint _candidateid) public{
        //requires a candidate that hasnt voted before 
        require(!voters[msg.sender]);
        //requires a valid candidate
        require(_candidateid > 0 && _candidateid <= candidateCount);
        //records the candidates vote 
        // if bool set to true then candidate has voted before
        voters[msg.sender] = true;
        //update the candidate count
        candidates[_candidateid].voteCount++;
        //trigger the voting event for
        emit votedEvent(_candidateid);

    }
}
