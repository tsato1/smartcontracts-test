// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract CoinFlip {
  enum CoinSide { HEADS, TAILS }
  enum FlipResult { WIN, LOSE }

  /**
  This event will be emitted when the coin is flipped
  Logs address of the player, side that they chose, and if they were correct on their choice on to the block chain
   */
  event Result(address indexed player, CoinSide chosenSide, FlipResult result);

  function flipCoin(CoinSide chosenSide) public {
    /**
    Generates the combination of currenct block timestamps and address of the caller of this function,
    and use modulo %2 to store 0 or 1 as a random number
     */
    uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 2;

    CoinSide result = CoinSide(randomNumber);

    FlipResult flipResult = (chosenSide == result) ? FlipResult.WIN : FlipResult.LOSE;

    /** 
    Emits the result to the block chain 
    msg.sender: the caller of this function
    */
    emit Result(msg.sender, chosenSide, flipResult);
  }
}