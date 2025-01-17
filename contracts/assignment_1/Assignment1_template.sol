// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Open Zeppelin:

// Open Zeppelin NFT guide:
// https://docs.openzeppelin.com/contracts/4.x/erc721

// Open Zeppelin ERC721 contract implements the ERC-721 interface and provides
// methods to mint a new NFT and to keep track of token ids.
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol

// Open Zeppelin ERC721URIStorage extends the standard ERC-721 with methods
// to hold additional metadata.
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

// TODO:
// Other openzeppelin contracts might be useful. Check the Utils!
// https://docs.openzeppelin.com/contracts/4.x/utilities


// Local imports:

// TODO:
// You might need to adjust paths to import accordingly.

// Import BaseAssignment.sol
import "../BaseAssignment.sol";

// Import INFTMINTER.sol
import "./INFTMINTER.sol";

// You contract starts here:
// You need to inherit from multiple contracts/interfaces.
contract Assignment1 is INFTMINTER, ERC721URIStorage, BaseAssignment {

    
    // TODO: 
    // Add the ipfs hash of an image that you uploaded to IPFS.
    string IPFSHash = "QmXf3vfHe6JjLdGAj1cFH5H1JVGox5DrAiYz44U9Rw3gvU";

    // Total supply.
    uint256 public totalSupply;

    // Current price. See also: https://www.cryps.info/en/Gwei_to_ETH/1/
    uint256 private price = 0.001 ether; 

    // TODO: 
    // Add more state variables, as needed.

    // TODO: 
    // Adjust the Token name and ticker as you like.
    // Very important! The validator address must be passed to the 
    // BaseAssignment constructor (already inserted here).
    constructor()
        ERC721("Token", "TKN")
        BaseAssignment(0x80A2FBEC8E3a12931F68f1C1afedEf43aBAE8541)
    {}

    // Mint a nft and send to _address.
    function mint(address _address) public payable returns (uint256) {
        
        // Your code here!

        // 1. First, check if the conditions for minting are met.

        // 2. Then increment total supply and price.
       
        // 3. Get the current token id, after incrementing it.
        // Hint: Open Zeppelin has methods for this.

        // 4. Mint the token.
        // Hint: Open Zeppelin has a method for this.

        // 5. Compose the token URI with metadata info.
        // You might use the helper function getTokenURI.
        // Make sure to keep the data in "memory."
        // Hint: Learn about data locations.
        // https://dev.to/jamiescript/data-location-in-solidity-12di
        // https://solidity-by-example.org/data-locations/
        
        // 6. Set encoded token URI to token.
        // Hint: Open Zeppelin has a method for this.
        
        // 7. Return the NFT id.
    }

    function flipSaleStatus() public override {
        require(msg.sender == _owner, "Only owner can flip sale status");
        price = price == 0 ? 0.001 ether : 0;
    }

    function getSaleStatus() public view override returns (bool) {
        return price > 0;
    }

    function withdraw(uint256 amount) public override {
        require(msg.sender == _owner, "Only owner can withdraw");
        require(address(this).balance >= amount, "Not enough balance");

        payable(_owner).transfer(amount);
    }

    function getPrice() public view override returns (uint256) {
        return price;
    }

    function getTotalSupply() public view override returns (uint256) {
        return totalSupply;
    }

    function getIPFSHash() public view override returns (string memory) {
        return IPFSHash;
    }


    // TODO: 
    // Other methods of the INFTMINTER interface to be added here. 
    // Hint: all methods of an interface are external, but here you might
    // need to adjust them to public.

    /*=============================================
    =                   HELPER                  =
    =============================================*/

    // Get tokenURI for token id
    function getTokenURI(uint256 tokenId, address newOwner)
        public
        view
        returns (string memory)
    {
        // Build dataURI.
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "My beautiful artwork #',
            tokenId.toString(),
            '"', // Name of NFT with id.
            '"hash": "',
            IPFSHash,
            '",', // Define hash of your artwork from IPFS.
            '"by": "',
            getOwner(),
            '",', // Address of creator.
            '"new_owner": "',
            newOwner,
            '"', // Address of new owner.
            "}"
        );

        // Encode dataURI using base64 and return it.
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    /*=====         End of HELPER         ======*/
}
