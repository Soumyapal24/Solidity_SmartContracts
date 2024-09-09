// SPDX-License-Identifier: MIT
// Soumya Pal|| MSc Cyber Security || 231043
pragma solidity 0.8.26;

contract ItemStore {
    struct itemData {
        string name;
        uint8 price;
        bool sold;

    }

itemData theItem;
    address public owner;
    address[] buyers;

constructor(string memory _name){
    theItem.name = _name;
    owner = msg.sender;
}

function putOnSale(uint8 _price) public {
    theItem.price = _price;
    theItem.sold = false;
}

function toWei(uint8 _ether) internal pure returns (uint256){
    return (1 ether * _ether );
}


function buyItem() public payable {
    uint256 itemPriceInWei = toWei(theItem.price);
    if(msg.value >= itemPriceInWei) {
        owner = msg.sender;
        theItem.sold = true;
        buyers.push(msg.sender);
        uint256 balance = msg.value - itemPriceInWei; 
        if(balance > 0) payable (msg.sender).transfer(balance);
    }
}

function getItemData () public view returns (string memory, uint8, bool){
    return (theItem.name, theItem.price, theItem.sold);

}

function getBuyers () public  view returns (uint256, address[] memory){
    return (buyers.length, buyers);

}

}   
    


