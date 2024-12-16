package com.vehicrypto.backend.controllers;

import com.vehicrypto.backend.services.IpfsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/ipfs")
public class IpfsController {

    private final IpfsService ipfsService;

    @Autowired
    public IpfsController(IpfsService ipfsService) {
        this.ipfsService = ipfsService;
    }

    @PostMapping("/upload")
    public ResponseEntity<String> uploadFile(@RequestParam String filePath) {
        String cid = ipfsService.uploadFileToIpfs(filePath);
        return ResponseEntity.ok("File uploaded successfully. CID: " + cid);
    }
}
