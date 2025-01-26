package com.vehicrypto.backend.utils;

import org.web3j.codegen.SolidityFunctionWrapperGenerator; 

public class CodeGen {
    public static void main(String[] args) throws Exception {

        String abiPath = "...\\VehiCrypto\\vehicrypto-backend-api\\src\\main\\resources\\CIDManager.abi";
        String binPath = "...\\VehiCrypto\\vehicrypto-backend-api\\src\\main\\resources\\CIDManager.bin";

        String outputDir  = "...\\VehiCrypto\\vehicrypto-backend-api\\src\\main\\java\\com\\vehicrypto\\backend\\contracts";
        String packageName = "com.vehicrypto.backend.contracts";

        SolidityFunctionWrapperGenerator.main(new String[] {
            "-a", abiPath,
            "-b", binPath,
            "-o", outputDir,
            "-p", packageName
        });

        System.out.println("Wrapper class generated successfully!");
    }
}
