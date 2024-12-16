package com.vehicrypto.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.validation.constraints.NotBlank;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Maintenance {
    @NotBlank
    private String vehiclePlate;
    
    @NotBlank
    private String maintenanceType;
    
    @NotBlank
    private String date;

    private String ipfsCid; // CID from IPFS
    private String referenceCode; // Generated unique reference code

    public String getIpfsCid() {
        return ipfsCid;
    }

    public void setIpfsCid(String ipfsCid) {
        this.ipfsCid = ipfsCid;
    }

    public String getReferenceCode() {
        return referenceCode;
    }

    public void setReferenceCode(String referenceCode) {
        this.referenceCode = referenceCode;
    }

}
