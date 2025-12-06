// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract PersonalMessageWall {
    uint256 public maxMessagesPerUser = 5;
    uint256 public constant MAX_MESSAGE_LENGTH = 200;
    address public owner;

    struct Message {
        address sender;
        string content;
        uint256 timestamp;
    }

    Message[] private messages;
    mapping(address => uint256) private messageCount;
    mapping(address => Message[]) private userMessages;

    error EmptyMessage();
    error MessageTooLong();
    error MaxMessagesReached();
    error InvalidCharacters();

    event NewMessage(address indexed sender, string message, uint256 count, uint256 timestamp);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function setMaxMessages(uint256 _newLimit) external onlyOwner {
        require(_newLimit > 0, "Limit must be greater than 0");
        maxMessagesPerUser = _newLimit;
    }

    function _isValidMessage(string memory _message) private pure returns (bool) {
        bytes memory messageBytes = bytes(_message);
        for (uint256 i = 0; i < messageBytes.length; i++) {
            if (
                uint8(messageBytes[i]) < 32 ||  // Caracteres de controle
                uint8(messageBytes[i]) == 60 || // '<'
                uint8(messageBytes[i]) == 62 || // '>'
                uint8(messageBytes[i]) == 38    // '&'
            ) {
                return false;
            }
        }
        return true;
    }

    function leaveMessage(string memory _message) external {
        if (bytes(_message).length == 0) revert EmptyMessage();
        if (bytes(_message).length > MAX_MESSAGE_LENGTH) revert MessageTooLong();
        if (messageCount[msg.sender] >= maxMessagesPerUser) revert MaxMessagesReached();
        if (!_isValidMessage(_message)) revert InvalidCharacters();

        Message memory newMessage = Message({
            sender: msg.sender,
            content: _message,
            timestamp: block.timestamp
        });

        messages.push(newMessage);
        userMessages[msg.sender].push(newMessage);
        messageCount[msg.sender]++;

        emit NewMessage(msg.sender, _message, messageCount[msg.sender], block.timestamp);
    }

    function getMessages() external view returns (Message[] memory) {
        return messages;
    }

    function getUserMessages(address _user) external view returns (Message[] memory) {
        return userMessages[_user];
    }

    function getUserMessageCount(address _user) external view returns (uint256) {
        return messageCount[_user];
    }
}
