// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract transfer {
    // 這個合約的擁有者
    address public owner;

    // 建構子設定合約擁有者
    constructor() {
        owner = msg.sender;
    }

    // 以太幣轉移函數
    function transferEther(address payable _receiver, uint256 _amount) external {
        // 檢查呼叫者是否為合約擁有者
        require(msg.sender == owner, "Only the contract owner can transfer Ether.");

        // 確認合約餘額足夠
        require(address(this).balance >= _amount, "Insufficient balance in the contract.");

        // 傳送以太幣
        _receiver.transfer(_amount);
    }

    // 獲取合約餘額
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    //獲取當前帳戶餘額
    function getAccountBalance() external view returns (uint256) {
        return msg.sender.balance;
    }

    receive() external payable { }

    // 獲取使用者位置
    function getOwnerAddress() external view returns (address) {
        return owner;
    }
}