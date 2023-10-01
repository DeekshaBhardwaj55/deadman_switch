pragma solidity ^0.8.0;

contract DeadmansSwitch {
    address public owner;
    address public Recipient;
    uint256 public Block;

    constructor(address _recipient) {
        owner = msg.sender;
        Recipient = _recipient;
       Block = block.number;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyRecipient() {
        require(msg.sender == Recipient, "Only the designated recipient can call this function");
        _;
    }

    function stillAlive() external onlyOwner {
        Block = block.number;
    }

    function withdrawFunds() external onlyOwner {
        require(block.number - Block >= 10, "The owner is still alive.");
        uint256 contractBalance = address(this).balance;
        payable(owner).transfer(contractBalance);
    }
}
