// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract TestSea is ERC721Enumerable, Ownable {
    uint256 public maxSupply = 500;
    using Strings for uint256;
    mapping(uint256 => string) private _tokenURIs;
    string public message;
    string public uri;

    constructor() ERC721("TestSea", "TS") {}

    // multiple mint function
    function Bulkmint(address to, uint256 _amount) public onlyOwner {
        for (uint i = 0; i < _amount; i++) {
            require(totalSupply() < maxSupply, "over maxSupply mint");
            uint mintIndex = totalSupply();
            _safeMint(to, mintIndex);
        }
    }

    // empty Id token can mint (once satogaeri Id or new Id)
    function mint(address to, uint256 tokenId) public onlyOwner {
        require(totalSupply() < maxSupply, "over maxSupply mint");
        _mint(to, tokenId);
    }

    // specific Id token back to Contract
    function satogaeri(uint256 tokenId) public onlyOwner {
        _burn(tokenId);
    }

    function setMaxSupply(uint256 _value) public onlyOwner {
        maxSupply = _value;
    }

    // set URIs
    function setURI(string memory newuri) public onlyOwner {
        uri = newuri;
    }

    // refer URIs
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return string(abi.encodePacked(uri, tokenId.toString(), ".json"));
    }

    // engrave the message into blockchain
    function setMessage(string memory newMessage) public onlyOwner {
        message = newMessage;
    }

    // call engraved message on blockchain
    function getMessage() public view virtual returns (string memory) {
        return message;
    }


    // to avoid renounce to undefined address
    function renounceOwnership() public override onlyOwner {
        _transferOwnership(address(msg.sender));
    }

    // confirm specific Id token is exist or not
    function madaorunkai(uint256 tokenId) public view returns (bool) {
        return _exists(tokenId);
    }
}
