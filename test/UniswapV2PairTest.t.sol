// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "./mocks/ERC20Mintable.sol";
import "./utils/Utils.sol";
import {UniswapV2Pair} from "../src/UniswapV2Pair.sol";

contract UniswapV2PairTest is Test {
    ERC20Mintable public token0;
    ERC20Mintable public token1;
    UniswapV2Pair public pair;
    

    Utils public utils;

    address[] internal users;
    address user1;
    address user2;

    function setUp() public {
        utils = new Utils();
        users = utils.createUsers(2);

        user1 = users[0];
        user2 = users[1];

        token0 = new ERC20Mintable("Token A", "TKNA");
        token1 = new ERC20Mintable("Token B", "TKNB");
        pair = new UniswapV2Pair(address(token0), address(token1));

        token0.mint(10 ether, address(this));
        token1.mint(10 ether, address(this));
    }

    function testIncrement() public {}

    function testSetNumber(uint256 x) public {}
}
