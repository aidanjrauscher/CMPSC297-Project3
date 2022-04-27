// SPDX-License-Identifier: MIT

// Only allow compiler versions from 0.7.0 to (not including) 0.9.0
pragma solidity >=0.7.0 <0.9.0;

contract GroceryStore{

    //boilerplate contract features
    address public owner; 
    bool storeOpen;

    //variables specific to grocery store application
    //fruit
    mapping (address => uint) appleStock;
    mapping (address => uint) bananaStock;
    mapping (address => uint) grapeStock;

    //vegetables (tbh idrk if potatoes are vegetables)
    mapping (address => uint) potatoStock;
    mapping (address => uint) tomatoStock; 

    //meat    
    mapping (address => uint) chickenStock;
    mapping (address => uint) steakStock;



    constructor(){
        //on creation, shop is open
        storeOpen = true; 

        //set owner 
        owner = msg.sender;

        //set inventory of store 
        //fruit
        appleStock[address(this)] = 2500;
        bananaStock[address(this)] = 1000;
        grapeStock[address(this)] = 100;

        //vegetables (tbh idrk if potatoes are vegetables)
        potatoStock[address(this)] = 500;
        tomatoStock[address(this)] = 2500; 

        //meat    
        chickenStock[address(this)] = 100;
        steakStock[address(this)] = 50;
    }

    // utility function to compare two strings by comparing their hash
    function compareStrings(string memory a, string memory b) private pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked(b)));
    }

    //allow owner address to restock the store 
    function restock(uint newStock, string memory foodItem) public{
        //check to make sure only owner is restocking items
        require(msg.sender == owner, "Only the owner can restock the produce isle!");
        bool invalidItem = false;
        //refill based on item
        if(compareStrings(foodItem, "apple")){
            appleStock[address(this)] += newStock;
        }
        else if(compareStrings(foodItem, "banana")){
            bananaStock[address(this)] += newStock;
        }
        else if(compareStrings(foodItem, "grape")){
            grapeStock[address(this)] += newStock;
        }
        else if(compareStrings(foodItem, "potato")){
            potatoStock[address(this)] += newStock;
        }
        else if(compareStrings(foodItem, "tomato")){
            tomatoStock[address(this)] += newStock; 
        }
        else if(compareStrings(foodItem, "chicken")){
            chickenStock[address(this)] += newStock;
        }
        else if(compareStrings(foodItem, "steak")){
            steakStock[address(this)] += newStock;
        }
        else if(compareStrings(foodItem, "all")){
            appleStock[address(this)] += newStock;
            bananaStock[address(this)] += newStock;
            grapeStock[address(this)] += newStock;

            potatoStock[address(this)] += newStock;
            tomatoStock[address(this)] += newStock; 

            chickenStock[address(this)] += newStock;
            steakStock[address(this)] += newStock;
        }
        else{
            require(invalidItem, "Item cannot be found!");
        }
    }

    //allow owner address to open and close the store
    function changeStoreState() public returns (string memory){
        if(storeOpen){
            storeOpen = false;
            return "Store has been closed!";
        }
        else{
            storeOpen = true;
            return "Store has been opened!";
        }
    }

    //allow an address to buy an item from the store
    function purchase(uint amount, string memory foodItem) public payable{
        require(storeOpen == true, "The store is closed! Come back later!.");
        require(msg.value >= amount * 1 ether, "You must pay at least 1 ETH per food item!");
        bool invalidItem = false; 
        //refill based on item
        if(compareStrings(foodItem, "apple")){
            appleStock[address(this)] -= amount;
        }
        else if(compareStrings(foodItem, "banana")){
            bananaStock[address(this)] -= amount;
        }
        else if(compareStrings(foodItem, "grape")){
            grapeStock[address(this)] -= amount;
        }
        else if(compareStrings(foodItem, "potato")){
            potatoStock[address(this)] -= amount;
        }
        else if(compareStrings(foodItem, "tomato")){
            tomatoStock[address(this)] -= amount;
        }
        else if(compareStrings(foodItem, "chicken")){
            chickenStock[address(this)] -= amount;
        }
        else if(compareStrings(foodItem, "steak")){
            steakStock[address(this)] -= amount;
        }
        else if(compareStrings(foodItem, "fullCart")){
            appleStock[address(this)] -= amount;
            bananaStock[address(this)] -= amount;
            grapeStock[address(this)] -= amount;

            potatoStock[address(this)] -= amount;
            tomatoStock[address(this)] -= amount;

            chickenStock[address(this)] -= amount;
            steakStock[address(this)] -= amount;
        }
        else{
            require(invalidItem, "Item cannot be found!");
        }
    }

    //get stock of inventory item 
    function getStock(string memory foodItem) public view returns (uint) {
        if(compareStrings(foodItem, "apple")){
            return appleStock[address(this)];
        }
        else if(compareStrings(foodItem, "banana")){
            return bananaStock[address(this)];
        }
        else if(compareStrings(foodItem, "grape")){
            return grapeStock[address(this)];
        }
        else if(compareStrings(foodItem, "potato")){
            return potatoStock[address(this)];
        }
        else if(compareStrings(foodItem, "tomato")){
            return tomatoStock[address(this)]; 
        }
        else if(compareStrings(foodItem, "chicken")){
            return chickenStock[address(this)];
        }
        else if(compareStrings(foodItem, "steak")){
            return steakStock[address(this)];
        }
        else{
            return 0;
        }
    }

}
