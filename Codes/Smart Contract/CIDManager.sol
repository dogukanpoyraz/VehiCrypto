// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CIDManager {
    
    struct CIDInfo {
        string vehiclePlate;
        string ipfsCID;
    }
    
    mapping(address => CIDInfo[]) private cidsByOwner;

    function addCID(string memory _vehiclePlate, string memory _ipfsCID) public {
        cidsByOwner[msg.sender].push(CIDInfo(_vehiclePlate, _ipfsCID));
    }

    function getCIDs(address _owner) public view returns (CIDInfo[] memory) {
        return cidsByOwner[_owner];
    }
}
