pragma solidity ^0.4.18;

contract B2BArticles {

    struct Article {
        uint id;
        address seller;
        address buyer;
        string name;
        string description;
        uint256 price;
    }

    mapping (uint => Article) public articles;
    uint articleCounter;

    event LogSellArticle(
        uint indexed _id,
        address indexed _seller,
        string _name,
        uint256 _price
    );

    event LogBuyArticle(
        uint indexed _id, 
        address indexed _seller, 
        address indexed _buyer, 
        string _name, 
        uint256 _price,
        uint256 msgvalue
    );


    function sellArticle(string _name, string _description, uint256 _price) public {
        //a new article
        articleCounter++;

        articles[articleCounter] = Article (
            articleCounter,
            msg.sender,
            0X0,
            _name,
            _description,
            _price
        );
        LogSellArticle(articleCounter, msg.sender, _name, _price);
    }

    function getNumberOfArticles() public view returns (uint) {
        return articleCounter;
    }

    function getArticlesForSale() public view returns (uint[]) {
        uint[] memory articleIds = new uint[](articleCounter);
        uint numberOfArticlesForSale = 0;
        for(uint i=1; i<= articleCounter; i++) {
           if(articles[i].buyer == 0x0) {
               articleIds[numberOfArticlesForSale] = articles[i].id;
               numberOfArticlesForSale++;
           }
        }

        uint[] memory forSale = new uint[](numberOfArticlesForSale);
        for(uint j = 0; j < numberOfArticlesForSale; j++) {
            forSale[j] = articleIds[j];
        }
        return forSale;
    }

    function payable public {
 buyArticle(uint _id)
        //retrieve the article
        Article storage article = articles[_id];
        require(msg.sender != article.seller);
        //keep buyer's info
        article.buyer = msg.sender;
        //buyer pays the seller
        article.seller.transfer(msg.value);
        LogBuyArticle(_id, article.seller, article.buyer, article.name, article.price, msg.value);
    }

}