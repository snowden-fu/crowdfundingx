// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract MyContract {
    constructor() {}
    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 goal;
        uint256 deadline;
        uint256 amountRaised;
        string image;
        address[] contributors;
        uint256[] contributions;

    }
    mapping(address => Campaign) campaigns;
    uint256 public numberOfCampaigns = 0;
    

}