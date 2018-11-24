pragma solidity ^0.4.0;

// 官方文档众筹实现
// https://solidity.readthedocs.io/en/develop/types.html#structs

// 独立实现
contract CrowdFunding {

    // 众筹项目
    struct Fund {
        // 众筹地址
        address owner;
        // 众筹描述
        string desc;
        // 众筹目标
        uint goal;

        // 已筹金币
        uint coins;
        // 是否结束
        bool finished;

        // 捐赠人数
        uint recordCounts;
        // 捐赠记录
        mapping(uint => Record) records;
        // 原本使用 Record[] records 数组定义
        // 但是貌似目前版本尚不支持
        // 于是将 数组 拆分成 长度 + 映射
        // https://solidity.readthedocs.io/en/develop/types.html#mappings
    }

    // 捐赠记录
    struct Record {
        address member;
        uint coin;
        uint time;
    }

    Fund[] funds;

    function getFundCount() public view returns (uint) {
        return funds.length;
    }

    function getFundInfo(uint fundIndex) public view returns (address, string, uint, uint, bool) {
        Fund storage fund = funds[fundIndex];
        return (fund.owner, fund.desc, fund.goal, fund.coins, fund.finished);
    }

    function getRecordCount(uint fundIndex) public view returns (uint) {
        return funds[fundIndex].recordCounts;
    }

    function getRecordInfo(uint fundIndex, uint recordIndex) public view returns (address, uint, uint) {
        Record storage record = funds[fundIndex].records[recordIndex];
        return (record.member, record.coin, record.time);
    }

    function raiseFund(string info, uint goal) public {
        funds.push(Fund(msg.sender, info, goal, 0, false, 0));
    }

    function sendCoin(uint fundIndex) public payable {
        Fund storage fund = funds[fundIndex];
        require(!fund.finished);

        fund.owner.transfer(msg.value);
        fund.coins += msg.value;
        fund.records[fund.recordCounts++] = Record(msg.sender, msg.value, now);
        fund.finished = fund.coins >= fund.goal * 1 ether ? true : false;
    }

    function() public payable { }
}
