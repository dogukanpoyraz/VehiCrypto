package com.vehicrypto.backend.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.vehicrypto.backend.contracts.CIDManager;
import com.vehicrypto.backend.models.Maintenance;
import com.vehicrypto.backend.utils.CIDInfo;  // <-- Az önce yarattığınız DynamicStruct sınıfı
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
    private final CIDManager cidManager;  // Akıllı sözleşme wrapper’ımız

    // Lokal mock DB – eğer hâlâ saklamak istiyorsanız kullanırsınız.
    private final Map<String, Maintenance> blockchainMockDB = new HashMap<>();

    public MaintenanceService() {
        // 1) IPFS bağlantısı
        this.ipfs = new IPFS("/ip4/127.0.0.1/tcp/5001");

        // 2) Web3j ile blockchain node’una bağlanma
        this.web3j = Web3j.build(new HttpService("https://sepolia.infura.io/v3/{PROJECT_ID}"));

        // 3) Credentials (private key)
        String privateKey = "PrivateKey";
        Credentials credentials = Credentials.create(privateKey);

        // 4) Gas Provider (Static olarak ayarlandı, gerekirse güncellenebilir)
        ContractGasProvider gasProvider = new StaticGasProvider(
                BigInteger.valueOf(1_000_000_000L), // 1 Gwei
                BigInteger.valueOf(3_000_000L)      // 3,000,000 gas limit
        );

        // 5) Sözleşmeyi yükleme
        try {
            String contractAddress = "0x384c25b288eb3269585034b53f08fdf63120730b"; // Deploy edilmiş sözleşme adresi
            this.cidManager = CIDManager.load(contractAddress, web3j, credentials, gasProvider);
            System.out.println("CIDManager loaded at: " + cidManager.getContractAddress());
        } catch (Exception e) {
            throw new RuntimeException("Error initializing MaintenanceService: " + e.getMessage(), e);
        }
    }

    /**
     * 1) Maintenance kaydını IPFS'e yükler
     * 2) IPFS CID'sini akıllı sözleşmeye (CIDManager) addCID(...) ile kaydeder
     * 3) (İsteğe bağlı) local mockDB'ye de ekler
     * @param maintenance - Bakım bilgileri
     * @return IPFS CID
     */
    public String addMaintenanceRecord(Maintenance maintenance) {
        try {
            // 1) Maintenance objesini JSON'a çevir
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonData = objectMapper.writeValueAsString(maintenance);

            // 2) IPFS'e upload
            NamedStreamable.ByteArrayWrapper file = new NamedStreamable.ByteArrayWrapper(jsonData.getBytes());
            MerkleNode response = ipfs.add(file).get(0);
            String ipfsCid = response.hash.toString();  // IPFS üzerinde oluşan CID
            maintenance.setIpfsCid(ipfsCid);

            // 3) Sözleşmeye kaydet (transaction onayını kontrol et)
            BigInteger nonce = web3j.ethGetTransactionCount(
                    Credentials.create("PrivateKey").getAddress(),
                    org.web3j.protocol.core.DefaultBlockParameterName.PENDING).send().getTransactionCount();
            System.out.println("Nonce: " + nonce);

            String transactionHash = cidManager.addCID(maintenance.getVehicle_plate(), ipfsCid).send().getTransactionHash();
            System.out.println("Transaction Hash: " + transactionHash);

            // 4) (İsteğe bağlı) Lokalde de saklamak isterseniz:
            blockchainMockDB.put(ipfsCid, maintenance);

            return ipfsCid;
        } catch (Exception e) {
            throw new RuntimeException("Error adding maintenance record: " + e.getMessage(), e);
        }
    }

    /**
     * Belirli bir plakaya ait IPFS kodlarını döndürür (lokal mockDB mantığı).
     */
    public List<String> getIpfsCodes(String vehicle_plate) {
        List<String> ipfsCodes = new ArrayList<>();
        for (Map.Entry<String, Maintenance> entry : blockchainMockDB.entrySet()) {
            if (entry.getValue().getVehicle_plate().equals(vehicle_plate)) {
                ipfsCodes.add(entry.getKey());
            }
        }
        return ipfsCodes;
    }

    /**
     * IPFS Koduna göre Maintenance objesini lokalde döndürür.
     */
    public Maintenance getMaintenanceRecord(String ipfsCode) {
        if (!blockchainMockDB.containsKey(ipfsCode)) {
            throw new RuntimeException("Record not found in local DB!");
        }
        return blockchainMockDB.get(ipfsCode);
    }

    /**
     * Sözleşmeden, belirli bir kullanıcının (ownerAddress) eklediği CIDInfo'ları çeker.
     */
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