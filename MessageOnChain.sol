// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract PersonalMessageWall {
    uint256 public constant MAX_MESSAGES = 5;
    uint256 public constant MAX_MESSAGE_LENGTH = 200;

    mapping(address => uint256) private messageCount;

    event NewMessage(address indexed sender, string message, uint256 count);

    function leaveMessage(string memory _message) external {
        require(bytes(_message).length > 0, "Message cannot be empty");
        require(bytes(_message).length <= MAX_MESSAGE_LENGTH, "Message too long");
        require(messageCount[msg.sender] < MAX_MESSAGES, "Max 5 messages per wallet");

        messageCount[msg.sender]++;
        emit NewMessage(msg.sender, _message, messageCount[msg.sender]);
    }
}
