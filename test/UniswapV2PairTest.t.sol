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

    uint256 constant MINIMUM_LIQUIDITY = 1000;

    function setUp() public {
        utils = new Utils();
        users = utils.createUsers(2);

        user1 = users[0];
        user2 = users[1];

        token0 = new ERC20Mintable("Token A", "TKNA");
        token1 = new ERC20Mintable("Token B", "TKNB");
        pair = new UniswapV2Pair(address(token0), address(token1));

        token0.mint(1000 ether, user1);
        token1.mint(1000 ether, user1);
        token0.mint(10 ether, user2);
        token1.mint(10 ether, user2);

    }

    function assertReserves(
        uint112 expectedReserve0,
        uint112 expectedReserve1
    ) internal {
        (uint112 reserve0, uint112 reserve1, ) = pair.getReserves();
        assertEq(reserve0, expectedReserve0, "unexpected reserve0");
        assertEq(reserve1, expectedReserve1, "unexpected reserve1");
    }

    function testMintBootstrap() public {
        vm.startPrank(user1);
        token0.transfer(address(pair), 1 ether);
        token1.transfer(address(pair), 1 ether);

        pair.mint();

        assertEq(pair.balanceOf(user1), 1 ether - MINIMUM_LIQUIDITY);
        assertReserves(1 ether, 1 ether);
        assertEq(pair.totalSupply(), 1 ether);
    }

    function testMintWhenTheresLiquidity() public {
        vm.startPrank(user1);
        token0.transfer(address(pair), 1 ether);
        token1.transfer(address(pair), 1 ether);

        pair.mint();

        token0.transfer(address(pair), 2 ether);
        token1.transfer(address(pair), 2 ether);

        pair.mint();

        assertEq(pair.balanceOf(user1), 3 ether - 1000);
        assertEq(pair.totalSupply(), 3 ether);
        assertReserves(3 ether, 3 ether);
    }

    function testMintUnbalanced() public {
        vm.startPrank(user1);
        token0.transfer(address(pair), 1 ether);
        token1.transfer(address(pair), 1 ether);

        pair.mint(); // + 1 LP
        assertEq(pair.balanceOf(user1), 1 ether - 1000);
        assertReserves(1 ether, 1 ether);

        token0.transfer(address(pair), 2 ether);
        token1.transfer(address(pair), 1 ether);

        pair.mint(); // + 1 LP
        assertEq(pair.balanceOf(user1), 2 ether - 1000);
        assertReserves(3 ether, 2 ether);
    }

    function testSwap() public {
        vm.startPrank(user1);
        token0.transfer(address(pair), 100 ether);
        token1.transfer(address(pair), 100 ether);
        pair.mint();
        vm.stopPrank();

        vm.prank(user2);
       pair.swap(0 ether, 2 ether, address(user2));

    }
}
