package com.vehicrypto.backend.utils;

import org.web3j.codegen.SolidityFunctionWrapperGenerator; // <-- Doğru import

public class CodeGen {
    public static void main(String[] args) throws Exception {

        // 1) .abi ve .bin dosya yollarını ayarlayın
        String abiPath = "C:\\Users\\Caho_\\Desktop\\Folders\\Projects\\VehiCrypto\\vehicrypto-backend-api\\src\\main\\resources\\CIDManager.abi";
        String binPath = "C:\\Users\\Caho_\\Desktop\\Folders\\Projects\\VehiCrypto\\vehicrypto-backend-api\\src\\main\\resources\\CIDManager.bin";

        // 2) Output dizini ve paket ismi
        String outputDir  = "C:\\Users\\Caho_\\Desktop\\Folders\\Projects\\VehiCrypto\\vehicrypto-backend-api\\src\\main\\java\\com\\vehicrypto\\backend\\contracts";
        String packageName = "com.vehicrypto.backend.contracts";

        // 3) Codegen çağrısı
        SolidityFunctionWrapperGenerator.main(new String[] {
            "-a", abiPath,
            "-b", binPath,
            "-o", outputDir,
            "-p", packageName
        });

        System.out.println("Wrapper class generated successfully!");
    }
}
