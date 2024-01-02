// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract RealEstate {
    address private owner;
    address payable private  ownerAc;
    uint256 public price;
    //陶朱隱園的持有證明
    string public house = "Tao Zhuyin Garden No. 68, Songgao Road, Xinyi District, Taipei City,Proof of possession";

    constructor(uint256 pri){
        price = pri;
        owner = msg.sender;
        ownerAc = payable (msg.sender);
    }

    receive() external payable {
        // 確認使用者金額是否足夠
        require(price == msg.value, "Insufficient balance in the contract.");
        // 傳送以太幣
        ownerAc.transfer(msg.value);
        //修改持有者資料
        owner = msg.sender;
        ownerAc = payable (msg.sender);
    }

    //取得持有人位置
    function getOwnerAddress() external view returns (address) {
        return owner;
    }

}