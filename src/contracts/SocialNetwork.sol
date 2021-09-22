pragma solidity ^0.5.0;

contract SocialNetwork {
    string public name;
    uint256 public postCount = 0;

    mapping(uint256 => Post) public posts;

    struct Post {
        uint256 id;
        string content;
        uint256 tipAmount;
        address payable author;
    }

    event PostCreated(
        uint256 id,
        string content,
        uint256 tipAmount,
        address payable author
    );

    event PostTripped(
        uint256 id,
        string content,
        uint256 tipAmount,
        address payable author
    );

    constructor() public {
        name = "My Di Social";
    }

    function createPost(string memory _content) public {
        require(bytes(_content).length > 0);
        postCount++;
        posts[postCount] = Post(postCount, _content, 0, msg.sender);
        emit PostCreated(postCount, _content, 0, msg.sender);
    }

    function tipPost(uint256 _id) public payable {
        require(_id > 0 && _id <= postCount);
        Post memory _post = posts[_id];
        address payable _author = _post.author;
        address(_author).transfer(msg.value);
        _post.tipAmount = _post.tipAmount + msg.value;
        posts[_id] = _post;
        emit PostTripped(_id, _post.content, _post.tipAmount, _author);
    }
}
