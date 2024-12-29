// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DrugTraceability {
    struct Drug {
        string name;
        string manufacturer;
        string batchNumber;
        address owner;
    }

    mapping(uint256 => Drug) public drugs;
    uint256 public drugCount;

    // Register a drug
    function registerDrug(uint256 _id, string memory _name, string memory _manufacturer, string memory _batchNumber) public {
        drugs[_id] = Drug(_name, _manufacturer, _batchNumber, msg.sender);
        drugCount++;
    }

    // Get drug details by ID
    function getDrugDetails(uint256 _id) public view returns (string memory, string memory, string memory, address) {
        Drug memory drug = drugs[_id];
        return (drug.name, drug.manufacturer, drug.batchNumber, drug.owner);
    }

    // Get all registered drugs (returns an array of IDs)
    function getAllRegisteredDrugs() public view returns (uint256[] memory) {
        uint256[] memory drugIds = new uint256[](drugCount);
        for (uint256 i = 0; i < drugCount; i++) {
            drugIds[i] = i;
        }
        return drugIds;
    }
    
    // Transfer drug ownership
    function transferOwnership(uint256 _id, address _newOwner) public {
        require(drugs[_id].owner == msg.sender, "You are not the owner");
        drugs[_id].owner = _newOwner;
    }
}
