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

    struct offerContract {
        uint id; 
        address buyerAddress;
        address sellerAddress;
        uint offerDate;
        uint expiredDate;
        uint currentDate;
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

    mapping (uint => offerContract) public _listOfOfferContracts;
    mapping (uint => conditionList) public _conditionList;
    uint conditionListCounter;
    uint offerContractCounter; //this is used as an index that holds each contracts
    event OfferCreated(uint256 id, address indexed buyerAddress, address indexed sellerAddress, uint offerAmount, uint currentDate, uint expiredDate);
    event ConditionListCreate(uint _offerContractId, bool _conditionMet);

    function manageConditions(uint _offerId, bool _wallsPainted, bool _CarpetCleaned, bool _WindowsWashed) public {
        _conditionList[_offerId].WallsPainted = _wallsPainted;
        _conditionList[_offerId].CarpetCleaned = _CarpetCleaned;
        _conditionList[_offerId].WindowsWashed = _WindowsWashed;
        //if all conditions are true, then set conditions met to true automatically.
        if( _conditionList[_offerId].WallsPainted == true && _conditionList[_offerId].CarpetCleaned == true && _conditionList[_offerId].WindowsWashed == true) {
            _conditionList[_offerId].conditionMet = true;
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
        

    function createOfferContract(address _buyerAddress, address _sellerAddress, 
                                 uint _offerDate, uint _currentDate, uint _expiredDate,
                                 uint _offerAmount,bool _accepted) public  {

        offerContractCounter++;
            _listOfOfferContracts[offerContractCounter].id = offerContractCounter;
            _listOfOfferContracts[offerContractCounter].buyerAddress = _buyerAddress;
            _listOfOfferContracts[offerContractCounter].sellerAddress = _sellerAddress;
            _listOfOfferContracts[offerContractCounter].offerDate = _offerDate;
            _listOfOfferContracts[offerContractCounter].expiredDate = _expiredDate;
            _listOfOfferContracts[offerContractCounter].currentDate = _currentDate;
            _listOfOfferContracts[offerContractCounter].offerAmount = _offerAmount;
            _listOfOfferContracts[offerContractCounter].accepted = _accepted;
            emit OfferCreated(offerContractCounter, _buyerAddress, _sellerAddress, _offerAmount, _currentDate, _expiredDate);

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