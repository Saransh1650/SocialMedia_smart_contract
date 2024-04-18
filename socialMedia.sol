// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SocialMedia {
    struct Post {
        uint256 postId;
        uint256 tipNo;
        string content;
        string ipfsUrl;
        uint256 tipTotal;
        address payable creatorAddress;
    }

    Post[] public posts;
    event creatorAddress(address creator);

    function createPost(string memory _content, string memory _ipfs) public {
        uint256 newPostId = posts.length;
        posts.push(
            Post({
                postId: newPostId,
                tipNo: 0,
                content: _content,
                ipfsUrl: _ipfs,
                creatorAddress: payable (msg.sender),
                tipTotal: 0
            })
        );
    }

    function tipPost(uint amount, uint id) public payable{
        require(msg.sender.balance> amount, "Insufficient Balance");
        require(amount > 0, "Tip amount must be greater than 0");
        address payable creator = posts[id].creatorAddress;
        creator.transfer(msg.value);
        emit creatorAddress(creator);
        posts[id].tipTotal += amount;
        posts[id].tipNo ++;
    }

    function viewAllPosts() public view returns(Post[] memory)  {
        return posts;
    }
}
