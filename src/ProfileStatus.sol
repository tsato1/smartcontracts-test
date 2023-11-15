// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ProfileStatus {
  struct Status {
    string statusMessage;
    bool exists;
  }

  /**
  When you provide this mapping a wallet address, it's going to check the status scturct of that wallet address,
  and it's going to return the statusMessage and bool if it exists or not.
  */
  mapping(address => Status) public userStatus;

  /** Called when a new status is created */
  event StatusCreated(address indexed wallet, string status);
  /** Called when an existing is updated */
  event StatusUpdated(address indexed wallet, string newStatus);

  function createStatus(string memory initialStatus) public {
    require(!userStatus[msg.sender].exists, "Status already exists.");

    userStatus[msg.sender] = Status ({
      statusMessage: initialStatus,
      exists: true
    });

    emit StatusCreated(msg.sender, initialStatus);
  }

  function updateStatus(string memory newStatus) public {
    require(userStatus[msg.sender].exists, "Status doesn't exist.");

    userStatus[msg.sender].statusMessage = newStatus;

    emit StatusUpdated(msg.sender, newStatus);
  }

  function getStatus(address wallet) public view returns(string memory) {
    require(userStatus[wallet].exists, "Status doesn't exist");

    return userStatus[wallet].statusMessage;
  }
}