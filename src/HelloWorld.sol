// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract HelloWorld {
    /**
    public: anyone can view / execute it VS private: value is accessible by the contract only
     */
    string public message;

    /** 
    constructor runs once when the contract is deployed
     */
    constructor() {
        message = "Hello World!";
    }

    /**
    view: only retreives data on the smart contract and won't change the state of the block chain
    memory: returned string is temporary and only exists in the instances of running this function
    */
    function getMessage() public view returns (string memory) {
        return message;
    }
}

/**
Upon deploy:
Normally, you will have to use the private key of your wallet to deploy your smart contracts, but it's a security risk.
Thirdweb takes the contract and uploads metadata of ipfs, allowing you to deploy that contract on dashboard,
at which point you can use any wallet that is connected to the browser.
 */