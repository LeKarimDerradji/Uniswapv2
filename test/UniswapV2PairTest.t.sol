// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "./mocks/ERC20Mintable.sol";
import {UniswapV2Pair} from "../src/UniswapV2Pair.sol";

contract UniswapV2PairTest is Test {
    ERC20Mintable public token0;
    ERC20Mintable public token1;
    UniswapV2Pair public pair;

    function setUp() public {
        testUser = new TestUser();

        token0 = new ERC20Mintable("Token A", "TKNA");
        token1 = new ERC20Mintable("Token B", "TKNB");
        pair = new UniswapV2Pair(address(token0), address(token1));

        token0.mint(10 ether, address(this));
        token1.mint(10 ether, address(this));
    }

    function testIncrement() public {}

    function testSetNumber(uint256 x) public {}
}
