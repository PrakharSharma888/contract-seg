// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract PresaleToken is Ownable {
    uint256 public preSaleTime;
    uint256 public presaleTotalSupply;
    uint256 public presaleMintedTokens;

    /**
     * @dev Abstract function to mint tokens during the presale.
     * Must be implemented by inheriting contracts to define actual minting logic.
     * @param to The address that will receive the minted tokens.
     * @param amount The amount of tokens to mint.
     */
    function _mintPresale(address to, uint256 amount) internal virtual;

    /**
     * @dev Sets the presale time and the total supply for the presale.
     * Can only be called by the contract owner.
     * @param _preSaleTime The start time of the presale.
     * @param _presaleTotalSupply The total supply of tokens available for the presale.
     */
    function setPresaleTime(uint256 _preSaleTime, uint256 _presaleTotalSupply) external onlyOwner {
        require(_preSaleTime > block.timestamp, "Presale time must be in the future");
        preSaleTime = _preSaleTime;
        presaleTotalSupply = _presaleTotalSupply;
        presaleMintedTokens = 0; // Reset the minted tokens for the new presale
    }

    /**
     * @dev Checks if the current time allows for presale minting.
     * @return bool Returns true if presale minting is currently allowed, otherwise false.
     */
    function isPresaleActive() public view returns (bool) {
        return block.timestamp >= preSaleTime && presaleMintedTokens < presaleTotalSupply;
    }
}