// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {
    ERC20Burnable,
    ERC20
} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/*
 * @title DecentralizedStableCoin
 * @author Rahul Gupta
 * @Collateral: Exogenous (ETH & BTC)
 * @Minting: Algorithmic
 * @Relativity Stability: Pegged to USD
 *
 * This is the contract meant to be governed by DSCEngine. This contract is just the ERC20 implementation of our stabeCOin System.
 *
 */

contract DecentralizedStabelCoin is ERC20Burnable, Ownable {
    error DecentralizedStabelCoin_MustBeMoreThanZero();
    error DecentralizedStabelCoin_BurnAmountExceedBalance();
    error DecentralizedStabelCoin_NotZeroAddress();

    constructor() ERC20("DecentralizedStabelCoin", "DSC") Ownable(msg.sender) {}

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if (_amount <= 0) {
            revert DecentralizedStabelCoin_MustBeMoreThanZero();
        }

        if (balance < _amount) {
            revert DecentralizedStabelCoin_BurnAmountExceedBalance();
        }

        super.burn(_amount);
    }

    function mint(
        address _to,
        uint256 _amount
    ) external onlyOwner returns (bool) {
        if (_to == address(0)) {
            revert DecentralizedStabelCoin_NotZeroAddress();
        }

        if (_amount <= 0) {
            revert DecentralizedStabelCoin_MustBeMoreThanZero();
        }

        _mint(_to, _amount);
        return true;
    }
}
