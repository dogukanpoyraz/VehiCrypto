package com.vehicrypto.backend.utils;

import org.web3j.abi.datatypes.DynamicStruct;
import org.web3j.abi.datatypes.Utf8String;

public class CIDInfo extends DynamicStruct {

    public String vehicle_plate;
    public String cid;

    // 1) Constructor (object -> blockchain)
    public CIDInfo(String vehicle_plate, String cid) {
        super(new Utf8String(vehicle_plate), new Utf8String(cid));
        this.vehicle_plate = vehicle_plate;
        this.cid = cid;
    }

    // 2) Constructor (blockchain -> object)
    public CIDInfo(Utf8String vehicle_plate, Utf8String cid) {
        super(vehicle_plate, cid);
        this.vehicle_plate = vehicle_plate.getValue();
        this.cid = cid.getValue();
    }
}
