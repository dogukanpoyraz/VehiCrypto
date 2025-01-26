package com.vehicrypto.backend.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.vehicrypto.backend.contracts.CIDManager;
import com.vehicrypto.backend.models.Maintenance;
import com.vehicrypto.backend.utils.CIDInfo; 
import io.ipfs.api.IPFS;
import io.ipfs.api.MerkleNode;
import io.ipfs.api.NamedStreamable;
import org.springframework.stereotype.Service;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.http.HttpService;
import org.web3j.crypto.Credentials;
import org.web3j.tx.gas.ContractGasProvider;
import org.web3j.tx.gas.StaticGasProvider;

import java.math.BigInteger;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class MaintenanceService {

    private final IPFS ipfs;
    private final Web3j web3j;
    private final CIDManager cidManager;

    private final Map<String, Maintenance> blockchainMockDB = new HashMap<>();

    public MaintenanceService() {
        
        this.ipfs = new IPFS("/ip4/127.0.0.1/tcp/5001");

        this.web3j = Web3j.build(new HttpService("https://sepolia.infura.io/v3/{PROJECT_ID}"));

        String privateKey = "Private_Key";
        Credentials credentials = Credentials.create(privateKey);

        ContractGasProvider gasProvider = new StaticGasProvider(
                BigInteger.valueOf(1_000_000_000L),
                BigInteger.valueOf(3_000_000L)      
        );

        try {
            String contractAddress = "Contract_Address"; 
            this.cidManager = CIDManager.load(contractAddress, web3j, credentials, gasProvider);
            System.out.println("CIDManager loaded at: " + cidManager.getContractAddress());
        } catch (Exception e) {
            throw new RuntimeException("Error initializing MaintenanceService: " + e.getMessage(), e);
        }
    }


    public String addMaintenanceRecord(Maintenance maintenance) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonData = objectMapper.writeValueAsString(maintenance);

            NamedStreamable.ByteArrayWrapper file = new NamedStreamable.ByteArrayWrapper(jsonData.getBytes());
            MerkleNode response = ipfs.add(file).get(0);
            String ipfsCid = response.hash.toString();  
            maintenance.setIpfsCid(ipfsCid);

            BigInteger nonce = web3j.ethGetTransactionCount(
                    Credentials.create("Private_Key").getAddress(),
                    org.web3j.protocol.core.DefaultBlockParameterName.PENDING).send().getTransactionCount();
            System.out.println("Nonce: " + nonce);

            String transactionHash = cidManager.addCID(maintenance.getVehicle_plate(), ipfsCid).send().getTransactionHash();
            System.out.println("Transaction Hash: " + transactionHash);

            blockchainMockDB.put(ipfsCid, maintenance);

            return ipfsCid;
        } catch (Exception e) {
            throw new RuntimeException("Error adding maintenance record: " + e.getMessage(), e);
        }
    }


    public List<String> getIpfsCodes(String vehicle_plate) {
        List<String> ipfsCodes = new ArrayList<>();
        for (Map.Entry<String, Maintenance> entry : blockchainMockDB.entrySet()) {
            if (entry.getValue().getVehicle_plate().equals(vehicle_plate)) {
                ipfsCodes.add(entry.getKey());
            }
        }
        return ipfsCodes;
    }


    public Maintenance getMaintenanceRecord(String ipfsCode) {
        if (!blockchainMockDB.containsKey(ipfsCode)) {
            throw new RuntimeException("Record not found in local DB!");
        }
        return blockchainMockDB.get(ipfsCode);
    }


    @SuppressWarnings("unchecked")
    public List<CIDInfo> getCIDsFromContract(String ownerAddress) {
        try {
            List<CIDInfo> cidInfoList = (List<CIDInfo>) cidManager.getCIDs(ownerAddress).send();
            return cidInfoList;
        } catch (Exception e) {
            throw new RuntimeException("Error fetching CID list from contract: " + e.getMessage(), e);
        }
    }
}