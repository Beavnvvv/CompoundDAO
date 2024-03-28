// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BWDAO {
    address public Owner;
    mapping(address => bool) public Admin;
    mapping(address => bool) public memberlisted;

    modifier onlyOwner {
        require(msg.sender == Owner, "You are not Owner");
        _;
    }

    modifier onlyAdmin {
        require(Admin[msg.sender] == true, "You are not Admin");
        _;
    }

    constructor (address _owner) {
        Owner = _owner;
    }
 
    function setAdmin(address _addr) external onlyOwner{
        Admin[_addr] = true;
    }

    function addMember(address _member) external onlyAdmin onlyOwner{
        require(memberlisted[msg.sender] == false ,"He has been a member");
        memberlisted[_member] = true;
    }

}

