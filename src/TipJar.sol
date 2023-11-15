// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
Anyone can add a tip to the tipjar. Only the owner of the jar can withdraw the tip
 */

contract TipJar {
  address public owner; /** Whoever deploys this contract is the owner */

  /** Emits the address of the tipper and adds the amount that was tipped */
  event TipReceived(address indexed tipper, uint256 amount);
  /** Emits the address of the owner and total amount to be withdrawn */
  event TipWithdrawn(address indexed owner, uint256 amount);

  /** Runs only once when this contract gets deployed */
  constructor() {
    /** 
    msg.sender is the person who is executing the transaction
    Whoever deploying this contract becomes the owner
     */
    owner = msg.sender; 
  }

  /**
  modifier is used to change the behavior of the functions created within our solidity file

  onlyOwner function will check that this wallet address who is calling the function is the owner wallet address.
  We want to add this function to the withdraw function to make it so that only the owner can call it.
   */
  modifier onlyOwner() {
    require(msg.sender == owner, "Only the owner can call this function");
    _;
  }

  /**
  payable: needed to send the crypto currency

  Upon emit, the value will be sent to the smart contract. The smart contract can hold the crypto currency.
   */
  function tip() public payable {
    /** msg.value is the tip amount. Requiring the tip to be greater than 0 */
    require(msg.value > 0, "The amount of the tip has to be greater than 0.");
    /** msg.sender is the person who is executing the tip() function - tipper in this case. */
    emit TipReceived(msg.sender, msg.value);
  }

  /**
  Only owner can call this function (guaranteed by the modifier defined as onlyOwner)

  Upon emit, the tip will be transferred from the smart contract to the wallet of the tipjar owner.
   */
  function withdrawTips() public onlyOwner {
    /** Get the address of the smart contract and then get the balance that's held in it. */
    uint256 contractBalance = address(this).balance;
    require(contractBalance > 0, "There is no tip to withdraw.");

    /** Creates a payable to the owner and transfers the contract balance. */
    payable(owner).transfer(contractBalance);

    emit TipWithdrawn(owner, contractBalance);
  }

  /** Just reads the balance on the contract. Returns the balacne in uint256 */
  function getBalance() public view returns(uint256) {
    return address(this).balance;
  }
}