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
    mapping(uint256 => Campaign) campaigns;
    uint256 public numberOfCampaigns = 0;

    function createCampaign(address _owner, string memory _title, 
    string memory _description, uint256 _goal, uint256 _amountRaised,uint256 _deadline, string memory _image) public returns (uint256){
        Campaign storage newCampaign = campaigns[numberOfCampaigns];
        require(newCampaign.deadline > block.timestamp, "Deadline must be in the future");
        newCampaign.owner = _owner;
        newCampaign.title = _title;
        newCampaign.description = _description;
        newCampaign.goal = _goal;
        newCampaign.amountRaised = _amountRaised;
        newCampaign.deadline = _deadline;
        newCampaign.image = _image;

        numberOfCampaigns++;
        return numberOfCampaigns-1;
    }
}