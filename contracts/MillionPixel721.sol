pragma solidity ^0.4.24;

import "../node_modules/zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";

contract MyERC721 is ERC721Token("MillionPixel", "MP") {

    mapping(uint => uint24[9]) public colors;

    constructor () public {}

    function mintTokenWithCoordinates(uint256 _tokenId, uint24[9] _colors) public {
      require(_tokenId < 16384);

      super._mint(msg.sender, _tokenId);
      colors[_tokenId] = _colors;
      emit SquareCreation(_tokenId, _colors, msg.sender);
    }

    function updateSquareColor(uint256 _tokenId, uint24[9] _colors) public onlyOwnerOf(_tokenId) {
      colors[_tokenId] = _colors;
    }

    function getAllOwnedSquares() public view returns(uint256[]) {
      return ownedTokens[msg.sender];
    }

    function getAllSquareColors() public view returns(uint256[], uint24[9][]) {
        uint length = allTokens.length;
        uint24[9][] memory colorArray = new uint24[9][](length);
        for (uint x = 0; x < length; x++) {
            colorArray[x] = colors[allTokens[x]];
        }
        return (allTokens, colorArray);
    }

    event SquareCreation(uint256 tokenId, uint24[9] colors, address owner);

}
