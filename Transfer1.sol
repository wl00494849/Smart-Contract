// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract transfer1 {
    address payable private  _to;
    uint256 public price;

    constructor(uint256 pri){
        price = pri;
        _to = payable (msg.sender);
    }

    receive() external payable {
        // 確認使用者金額是否足夠
        require(price == msg.value, "Insufficient balance in the contract.");
        // 傳送以太幣
        _to.transfer(msg.value);
    }

    //取得持有人位置
    function getOwnerAddress() external view returns (address) {
        return _to;
    }

}