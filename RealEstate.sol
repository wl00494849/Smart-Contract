// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract RealEstate {
    //建立Map紀錄使用者存放在合約內的以太幣數量
    mapping(address => uint256) private userBalances;

    address private owner;
    address payable private  ownerAc;
    //陶朱隱園的持有證明
    string public house = "Tao Zhuyin Garden No. 68, Songgao Road, Xinyi District, Taipei City,Proof of possession";
    
    //建構式函式，在建立合約持有者為建立合約的人
    constructor(){
        ownerAc = payable(msg.sender);
        owner = msg.sender;
    }

    //確認是否為合約持有人
    modifier isOwner() {
        require(msg.sender == owner , "Caller is not owner");
        _;
    }

    //存入合約金額時，紀錄存款人及金額
    receive() external payable { 
        userBalances[msg.sender] += msg.value;
    }

    // 查詢使用者存款金額
    function getUserBalance() external view returns (uint256) {
        return userBalances[msg.sender];
    }

    //變更持有人
    function changeOwner(address payable _receiver, uint256 _amount) public isOwner {
        // 檢查呼叫者是否為合約擁有者
        require(msg.sender == owner, "Only the contract owner can transfer Ether.");
        // 確認使用者存入合約金額是否足夠
        require(userBalances[_receiver] >= _amount, "Insufficient balance in the contract.");
        // 傳送以太幣
        ownerAc.transfer(_amount);
        //交易成功扣除Table紀錄的金額，修改持有者資料
        userBalances[_receiver] -= _amount;
        owner = _receiver;
        ownerAc = _receiver;
    }

    //取得持有人位置
    function getOwnerAddress() external view returns (address) {
        return owner;
    }
}