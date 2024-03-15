// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract AirdropToken is IERC20, Ownable {
    uint256 public mintedTokens;

    /**
     * @dev Allows the contract owner to airdrop tokens to multiple recipients.
     * @param recipients An array of addresses that will receive the tokens.
     * @param amounts An array of amounts of tokens each address will receive.
     */
    function airdropTokens(address[] memory recipients, uint256[] memory amounts)
        external
        onlyOwner
    {
        require(
            recipients.length == amounts.length,
            "AirdropToken: Arrays length mismatch"
        );

        for (uint256 i = 0; i < recipients.length; i++) {
            mintedTokens += amounts[i];
            _mint(recipients[i], amounts[i]);
        }
    }

    /**
     * @dev Abstract function to mint tokens. This needs to be implemented by the inheriting contract.
     * @param account The address that will receive the minted tokens.
     * @param amount The amount of tokens to mint.
     */
    function _mint(address account, uint256 amount) internal virtual;
}