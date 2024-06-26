// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.20;
interface TimelockInterface {
    function delay() external view returns (uint);
    function queuedTransactions(bytes32 hash) external view returns (bool);
    function GRACE_PERIOD() external view returns (uint);
    function queueTransaction(address target, uint value, string calldata signature, bytes calldata data, uint eta) external returns (bytes32);
    function cancelTransaction(address target, uint value, string calldata signature, bytes calldata data, uint eta) external;
    function executeTransaction(address target, uint value, string calldata signature, bytes calldata data, uint eta) external payable returns (bytes memory);
}