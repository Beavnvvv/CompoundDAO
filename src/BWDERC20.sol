// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

contract BWDERC20 is ERC20, ERC20Permit, ERC20Votes {
    address public owner;
    mapping(address => bool) public daoMembers;
    mapping(address => uint) public contributions;

    constructor()
        ERC20("BWinDAO", "BWD")
        ERC20Permit("BWinDAO")
    {
        owner = msg.sender;
        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    modifier onlyDaoMembers {
        require(daoMembers[msg.sender] == true, "You are not daoMember");
        _;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "You are not owner");
        _;
    }

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Votes)
    {
        super._update(from, to, value);
    }

    function nonces(address owner)
        public
        view
        override(ERC20Permit, Nonces)
        returns (uint256)
    {
        return super.nonces(owner);
    }

    function setDaoMembers(address _dao) external onlyOwner{
        daoMembers[_dao] = true;
    }

    function mintDao() external payable onlyDaoMembers {
        require(msg.value > 0.01 ether, "Donations are too small");
        require(daoMembers[msg.sender] == true, "You are not DAOMember");
        contributions[msg.sender] += msg.value;
        _mint(msg.sender, msg.value);
    }
}
