// SPDX-License-Identifier: MIT
// Tells the Solidity compiler to compile only from v0.8.13 to v0.9.0
pragma solidity ^0.8.13;

contract B2BArticles {
  
  // events
  event LogSellArticle(
    address indexed _seller,
    string _name,
    uint256 _price
  );
  event LogBuyArticle(
    address indexed _buyer,
    string _name,
    uint256 _price
  );

  // state variables
  struct Article {
    address seller;
    string name;
    string description;
    uint256 price;
  }

  uint numberOfArticleCount = 0;
  mapping(uint => Article) public articlesForSale;

  // sell an article
  function sellArticle(string memory _name, string memory _description, uint256 _price) public {
    articlesForSale[numberOfArticleCount] = Article(msg.sender, _name, _description, _price);
    numberOfArticleCount++;

    emit LogSellArticle(msg.sender, _name, _price);
  }

  // get an article
  function getArticle() public view returns (Article[] memory articles) {
      Article[] result = new Article[];
      for(uint counter=0; counter<numberOfArticleCount; counter++) {
        result[counter] = articlesForSale[counter];
        counter++;
      }
      return result;
  }

  // buy an article
  function buyArticle() payable public {
    // we check whether there is an article for sale
    //require(seller != address(0));

    // we check that the article has not been sold yet
    //require(buyer == address(0));

    // we don't allow the seller to buy his own article
    //require(msg.sender != seller);

    // we check that the value sent corresponds to the price of the article
    //require(msg.value == price);

    // keep buyer's information
    //buyer = msg.sender;

    // the buyer can pay the seller
    //payable(seller).transfer(msg.value);

    // trigger the event
    //emit LogBuyArticle(msg.sender, name, price);
  }
}
