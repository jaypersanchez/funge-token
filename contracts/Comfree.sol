// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.17
pragma solidity ^0.8.17;

contract ComfreeProtocol {

    string public name;
    string public symbol;

    constructor() {
        name = "ComFree Protocol"; 
        symbol = "Comfree";
    }

    struct homeForSale {
        uint id;
        address seller;
        address buyer;
        string imgurl;
        string propertyaddress;
        uint ethprice;
    }

    struct offerContract {
        uint id; 
        address buyerAddress;
        address sellerAddress;
        uint offerAmount;
        bool accepted;
        uint conditionListId;
    }

    struct conditionList {
        /*
        * For simplicity sake there will only be a few conditions
        * when a condition is set to true, then it is a condition 
        * that needs to be met
        */
        //uint conditionListId;
        bool conditionMet;
        bool WallsPainted;
        bool CarpetCleaned;
        bool WindowsWashed;
    }

    mapping (uint => homeForSale) public _homesForSale;
    mapping (uint => offerContract) public _listOfOfferContracts;
    mapping (uint => conditionList) public _conditionList;
    
    uint homesForSaleCounter;
    uint listingCounter;
    uint conditionListCounter;
    uint offerContractCounter; //this is used as an index that holds each contracts
    event OfferCreated(uint256 id, address indexed sellerAddress, address indexed buyerAddress, uint priceAmount);
    event ConditionListCreate(uint _offerContractId, bool _conditionMet);
    event ConditionMet(uint _offerId);
    event ConditionNotMet(uint _offerId);

    function addPropertyForSale(address _buyerAddress, address _sellerAddress, string memory imgurl, string memory propertyaddress, uint _ethprice) public  {

        listingCounter++;
            _homesForSale[listingCounter].id = listingCounter;
            _homesForSale[listingCounter].seller = _sellerAddress;
            _homesForSale[listingCounter].buyer = _buyerAddress;
            _homesForSale[listingCounter].imgurl = imgurl;
            _homesForSale[listingCounter].propertyaddress = propertyaddress;
            _homesForSale[listingCounter].ethprice = _ethprice;
    }

    function getHomesForSale() public view returns(uint[] memory) {
        uint[] memory Ids = new uint[](listingCounter);

        uint numberOflistingCounter = 0;
        //iterate
        for(uint i = 1; i <= listingCounter; i++) {
                Ids[numberOflistingCounter] =  _homesForSale[i].id;
                numberOflistingCounter++;
        }

        uint[] memory forSale = new uint[](numberOflistingCounter);
        for(uint j = 0; j < numberOflistingCounter; j++) {
            forSale[j] = Ids[j];
        }
        return forSale;
    }

    function manageConditions(uint _offerId, bool _wallsPainted, bool _CarpetCleaned, bool _WindowsWashed) public {
        _conditionList[_offerId].WallsPainted = _wallsPainted;
        _conditionList[_offerId].CarpetCleaned = _CarpetCleaned;
        _conditionList[_offerId].WindowsWashed = _WindowsWashed;
        //if all conditions are true, then set conditions met to true automatically.
        if( _conditionList[_offerId].WallsPainted == true && _conditionList[_offerId].CarpetCleaned == true && _conditionList[_offerId].WindowsWashed == true) {
            _conditionList[_offerId].conditionMet = true;
        }
        if(_conditionList[_offerId].conditionMet == true) {
            emit ConditionMet(_offerId);
        }
        else {
            emit ConditionNotMet(_offerId);
        }
        
    }

    function createConditionList(uint _offerId) public {
        bool isAccepted = _listOfOfferContracts[_offerId].accepted;
        require(isAccepted == true);
        _conditionList[_offerId].conditionMet = false;
        _conditionList[_offerId].WallsPainted = false;
        _conditionList[_offerId].CarpetCleaned = false;
        _conditionList[_offerId].WindowsWashed = false; 
        emit ConditionListCreate(_offerId, _conditionList[_offerId].conditionMet);
    }
        

    function createOfferContract(address _buyerAddress, address _sellerAddress, uint _offerAmount,bool _accepted) public  {

        offerContractCounter++;
            _listOfOfferContracts[offerContractCounter].id = offerContractCounter;
            _listOfOfferContracts[offerContractCounter].buyerAddress = _buyerAddress;
            _listOfOfferContracts[offerContractCounter].sellerAddress = _sellerAddress;
            _listOfOfferContracts[offerContractCounter].offerAmount = _offerAmount;
            _listOfOfferContracts[offerContractCounter].accepted = _accepted;
            emit OfferCreated(offerContractCounter, _buyerAddress, _sellerAddress, _offerAmount);

    }

    function accept(uint _id, bool _value) public returns(bool) {
        /*
        * Future update.  Must have mechanism to prevent changing accepted offer
        * back to non-acception.  Depending on law of the land, the current
        * instance of this contract may have to be nulled and a new contract
        * must be opened.
        */
        require(_listOfOfferContracts[_id].sellerAddress != msg.sender);
        _listOfOfferContracts[_id].accepted = _value;
        return _value; //this will either return true or false
    }

    function getOfferContractDetailsById() public view returns(uint[] memory) {
        uint[] memory offerIds = new uint[](offerContractCounter);

        uint numberOfPropertiesForSale = 0;
        //iterate
        for(uint i = 1; i <= offerContractCounter; i++) {
                offerIds[numberOfPropertiesForSale] =  _listOfOfferContracts[i].id;
                numberOfPropertiesForSale++;
        }

        uint[] memory forSale = new uint[](numberOfPropertiesForSale);
        for(uint j = 0; j < numberOfPropertiesForSale; j++) {
            forSale[j] = offerIds[j];
        }
        return forSale;
    }

}