package com.vehicrypto.backend.services;

import io.ipfs.api.IPFS;
import io.ipfs.api.MerkleNode;
import io.ipfs.api.NamedStreamable;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.List;

@Service
public class IpfsService {

    private final IPFS ipfs;

    // IPFS bağlantısını başlat
    public IpfsService() {
        this.ipfs = new IPFS("127.0.0.1", 5001); // IPFS RPC URL
    }

    // Dosyayı IPFS'e yükle ve CID'yi döndür
    public String uploadFileToIpfs(String filePath) {
        try {
            // Dosyayı yüklemek için NamedStreamable kullan
            NamedStreamable.FileWrapper file = new NamedStreamable.FileWrapper(new File(filePath));
            
            // IPFS'e dosyayı yükle
            List<MerkleNode> response = ipfs.add(file);
            String cid = response.get(0).hash.toBase58(); // CID'yi al
            
            System.out.println("File uploaded successfully. CID: " + cid);
            return cid;
        } catch (Exception e) {
            throw new RuntimeException("Failed to upload file to IPFS", e);
        }
    }
}
