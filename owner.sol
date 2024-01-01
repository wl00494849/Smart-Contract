// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Owner
 * @dev Set & change owner
 */
contract Owner {

    address private owner;
    string private ownerName;
    
    // event for EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner);

    // modifier去確認操作者是否為持有人
    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    /**
     * @dev Set contract deployer as owner
     */
    constructor() {
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerSet(address(0), owner);
    }

    /**
     * @dev 變更合約持有者
     * @param newOwner 新持有者的帳戶位置
     */
    function changeOwner(address newOwner,string memory newOwnerName) public isOwner {
        ownerName = newOwnerName;
        emit OwnerSet(owner, newOwner);
        owner = newOwner;
    }

    /**
     * @dev 回傳使用者位置
     * @return address 持有者
     */
    function getOwnerAddress() external view returns (address) {
        return owner;
    }
} 