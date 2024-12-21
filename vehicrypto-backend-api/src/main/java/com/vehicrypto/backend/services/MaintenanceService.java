package com.vehicrypto.backend.services;

import com.vehicrypto.backend.models.Maintenance;
import io.ipfs.api.IPFS;
import io.ipfs.api.MerkleNode;
import io.ipfs.api.NamedStreamable;
import org.springframework.stereotype.Service;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.methods.request.Transaction;
import org.web3j.protocol.http.HttpService;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MaintenanceService {

    private final IPFS ipfs = new IPFS("/ip4/127.0.0.1/tcp/5001");
    private final Web3j web3j = Web3j.build(new HttpService("http://localhost:8545")); 

    private final Map<String, Maintenance> blockchainMockDB = new HashMap<>(); 

    public String addMaintenanceRecord(Maintenance maintenance) {
        try {
            NamedStreamable.ByteArrayWrapper file = new NamedStreamable.ByteArrayWrapper(maintenance.toString().getBytes());
            MerkleNode response = ipfs.add(file).get(0);
            String ipfsCid = response.hash.toString();

            String referenceCode = "REF-" + System.currentTimeMillis();
            maintenance.setIpfsCid(ipfsCid);
            maintenance.setReferenceCode(referenceCode);

            blockchainMockDB.put(referenceCode, maintenance);

            return referenceCode;
        } catch (Exception e) {
            throw new RuntimeException("Error adding maintenance record: " + e.getMessage());
        }
    }
    
    public List<String> getReferenceCodes(String vehicle_plate) {
        List<String> referenceCodes = new ArrayList<>();

        for (Map.Entry<String, Maintenance> entry : blockchainMockDB.entrySet()) {
            if (entry.getValue().getVehicle_plate().equals(vehicle_plate)) {
                referenceCodes.add(entry.getKey());
            }
        }

        return referenceCodes;
    }

    public Maintenance getMaintenanceRecord(String referenceCode) {
        if (!blockchainMockDB.containsKey(referenceCode)) {
            throw new RuntimeException("Record not found!");
        }
        return blockchainMockDB.get(referenceCode);
    }
}
