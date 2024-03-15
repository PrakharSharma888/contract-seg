// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract ScheduleDropMint is Ownable {
    uint256 public startDropTime;
    uint256 public endDropTime;
    uint256 public scheduledTotalSupply;
    uint256 public scheduledMintedTokens;

    /**
     * @dev Abstract function to mint tokens during the scheduled drop.
     * Must be implemented by inheriting contracts to define actual minting logic.
     * @param to The address that will receive the minted tokens.
     * @param amount The amount of tokens to mint.
     */
    function _mintScheduledDrop(address to, uint256 amount) internal virtual;

    /**
     * @dev Sets the schedule for a token drop and the total supply for that drop.
     * Can only be called by the contract owner.
     * @param _startDropTime The start time of the token drop.
     * @param _endDropTime The end time of the token drop.
     * @param _scheduledTotalSupply The total supply of tokens available for this drop.
     */
    function setScheduleDropMintTime(
        uint256 _startDropTime,
        uint256 _endDropTime,
        uint256 _scheduledTotalSupply
    ) external onlyOwner {
        require(_startDropTime < _endDropTime, "Invalid time range");
        require(block.timestamp < _startDropTime, "Start time must be in the future");

        startDropTime = _startDropTime;
        endDropTime = _endDropTime;
        scheduledTotalSupply = _scheduledTotalSupply;
        scheduledMintedTokens = 0; // Reset the minted tokens for the new schedule
    }

    /**
     * @dev Checks if the current time is within the scheduled drop period.
     * @return bool Returns true if within the drop period, otherwise false.
     */
    function isDropActive() public view returns (bool) {
        return block.timestamp >= startDropTime && block.timestamp <= endDropTime;
    }
}