// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding {
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

    // create a mapping of campaignId to Campaign, initialize to 0
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

    function getCampaign(uint256 _campaignId) public view returns (address, string memory, string memory, uint256, uint256, uint256, string memory, address[] memory, uint256[] memory){
        Campaign storage campaign = campaigns[_campaignId];
        return (campaign.owner, campaign.title, campaign.description, campaign.goal, campaign.amountRaised, campaign.deadline, campaign.image, campaign.contributors, campaign.contributions);
    }

    function contribute(uint256 _campaignId) public payable{
        uint256 amount = msg.value;
        Campaign storage campaign = campaigns[_campaignId];
        campaign.contributors.push(msg.sender);
        campaign.contributions.push(amount);

        (bool success, ) = campaign.owner.call{value: amount}("");

        if(success){
            campaign.amountRaised += amount;
        }
        else{
            revert("Transfer failed");
        }

    }
    
    function getContributors(uint256 _campaignId) public view returns (address[] memory){
        return campaigns[_campaignId].contributors;
    }

    function getContributions(uint256 _campaignId) public view returns (uint256[] memory){
        return campaigns[_campaignId].contributions;
    }

    function getAllCampaigns() public view returns (Campaign[] memory){
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);
        for(uint256 i = 0; i < numberOfCampaigns; i++){
            allCampaigns[i] = campaigns[i];
        }
        return allCampaigns;
    }
}