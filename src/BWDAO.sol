// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "./BWDERC20.sol";
contract BWDAO {
    address public Owner;
    address BWD = 0x408ea061DEF5E8E57Bd2569C9ca7d4Ce400860e0;
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

    function isDaoAdmin(address _address) public view returns(bool){
        return Admin[_address];
    }

    function addMember(address _member) external onlyAdmin onlyOwner{
        require(memberlisted[msg.sender] == false ,"He has been a member");
        memberlisted[_member] = true;
    }

}

