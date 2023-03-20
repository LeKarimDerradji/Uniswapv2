// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "solmate/tokens/ERC20.sol";

interface IERC20 {
    function balanceOf(address) external returns (uint256);

    function transfer(address to, uint256 amount) external;
}

contract UniswapV2Pair is ERC20("UniswapV2", "UNIV2", 18) {
    uint256 private reserve0;
    uint256 private reserve1;

    function mint() external {}
}
