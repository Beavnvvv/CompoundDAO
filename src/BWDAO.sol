// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "./BWDERC20.sol";
contract BWDAO {
    address public Owner;
    address BWD = 0x408ea061DEF5E8E57Bd2569C9ca7d4Ce400860e0;
    mapping(address => bool) public Admin;
    mapping(address => bool) public memberlisted;
    mapping(address => uint) public contributions;

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

    function fundDAO() external payable{
        require(msg.value > 0.01 ether, "Donations are too small");
        require(memberlisted[msg.sender] == true, "You are not DAOMember");
        contributions[msg.sender] += msg.value;
        BWDERC20(BWD).mint(msg.sender, msg.value);
    }

}

