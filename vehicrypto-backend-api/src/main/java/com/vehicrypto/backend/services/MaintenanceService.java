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
import java.util.HashMap;
import java.util.Map;

@Service
public class MaintenanceService {

    private final IPFS ipfs = new IPFS("/ip4/127.0.0.1/tcp/5001");
    private final Web3j web3j = Web3j.build(new HttpService("http://localhost:8545")); // Ethereum node URL

    private final Map<String, Maintenance> blockchainMockDB = new HashMap<>(); // Mock DB for blockchain records

    public String addMaintenanceRecord(Maintenance maintenance) {
        try {
            // Upload file to IPFS
            NamedStreamable.ByteArrayWrapper file = new NamedStreamable.ByteArrayWrapper(maintenance.toString().getBytes());
            MerkleNode response = ipfs.add(file).get(0);
            String ipfsCid = response.hash.toString();

            // Generate mock reference code
            String referenceCode = "REF-" + System.currentTimeMillis();
            maintenance.setIpfsCid(ipfsCid);
            maintenance.setReferenceCode(referenceCode);

            // Store mock record (replace with smart contract call via Web3J)
            blockchainMockDB.put(referenceCode, maintenance);

            return referenceCode;
        } catch (Exception e) {
            throw new RuntimeException("Error adding maintenance record: " + e.getMessage());
        }
    }

    public Maintenance getMaintenanceRecord(String referenceCode) {
        // Fetch record (replace with blockchain query via Web3J)
        if (!blockchainMockDB.containsKey(referenceCode)) {
            throw new RuntimeException("Record not found!");
        }
        return blockchainMockDB.get(referenceCode);
    }
}
