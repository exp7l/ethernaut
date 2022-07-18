// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface Victim {
    function pwn() external;
}

contract Pwn is Script {

    address _instance = 0xC6f58E269279c172E8B1110B08B375CD031a3271;

    function run()
        public
    {
        vm.startBroadcast();
        Victim(_instance).pwn();
        vm.stopBroadcast();        
    }
}
