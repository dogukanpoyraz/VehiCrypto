package com.vehicrypto.backend.contracts;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.Callable;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.DynamicArray;
import org.web3j.abi.datatypes.Function;
import org.web3j.abi.datatypes.Type;
import org.web3j.crypto.Credentials;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.RemoteCall;
import org.web3j.protocol.core.RemoteFunctionCall;
import org.web3j.protocol.core.methods.response.TransactionReceipt;
import org.web3j.tx.Contract;
import org.web3j.tx.TransactionManager;
import org.web3j.tx.gas.ContractGasProvider;

import com.vehicrypto.backend.utils.CIDInfo;

/**
 * <p>Auto generated code.
 * <p><strong>Do not modify!</strong>
 * <p>Please use the <a href="https://docs.web3j.io/command_line.html">web3j command line tools</a>,
 * or the org.web3j.codegen.SolidityFunctionWrapperGenerator in the 
 * <a href="https://github.com/web3j/web3j/tree/master/codegen">codegen module</a> to update.
 *
 * <p>Generated with web3j version 4.8.7.
 */
@SuppressWarnings("rawtypes")
public class CIDManager extends Contract {
    public static final String BINARY = "6080604052348015600e575f80fd5b506109ae8061001c5f395ff3fe608060405234801561000f575f80fd5b5060043610610034575f3560e01c80632dda7241146100385780636367da9c14610054575b5f80fd5b610052600480360381019061004d919061042f565b610084565b005b61006e600480360381019061006991906104ff565b61012b565b60405161007b9190610686565b60405180910390f35b5f803373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f20604051806040016040528084815260200183815250908060018154018082558091505060019003905f5260205f2090600202015f909190919091505f820151815f01908161010e91906108a9565b50602082015181600101908161012491906108a9565b5050505050565b60605f808373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f20805480602002602001604051908101604052809291908181526020015f905b828210156102d7578382905f5260205f2090600202016040518060400160405290815f820180546101b8906106d3565b80601f01602080910402602001604051908101604052809291908181526020018280546101e4906106d3565b801561022f5780601f106102065761010080835404028352916020019161022f565b820191905f5260205f20905b81548152906001019060200180831161021257829003601f168201915b50505050508152602001600182018054610248906106d3565b80601f0160208091040260200160405190810160405280929190818152602001828054610274906106d3565b80156102bf5780601f10610296576101008083540402835291602001916102bf565b820191905f5260205f20905b8154815290600101906020018083116102a257829003601f168201915b50505050508152505081526020019060010190610188565b505050509050919050565b5f604051905090565b5f80fd5b5f80fd5b5f80fd5b5f80fd5b5f601f19601f8301169050919050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b610341826102fb565b810181811067ffffffffffffffff821117156103605761035f61030b565b5b80604052505050565b5f6103726102e2565b905061037e8282610338565b919050565b5f67ffffffffffffffff82111561039d5761039c61030b565b5b6103a6826102fb565b9050602081019050919050565b828183375f83830152505050565b5f6103d36103ce84610383565b610369565b9050828152602081018484840111156103ef576103ee6102f7565b5b6103fa8482856103b3565b509392505050565b5f82601f830112610416576104156102f3565b5b81356104268482602086016103c1565b91505092915050565b5f8060408385031215610445576104446102eb565b5b5f83013567ffffffffffffffff811115610462576104616102ef565b5b61046e85828601610402565b925050602083013567ffffffffffffffff81111561048f5761048e6102ef565b5b61049b85828601610402565b9150509250929050565b5f73ffffffffffffffffffffffffffffffffffffffff82169050919050565b5f6104ce826104a5565b9050919050565b6104de816104c4565b81146104e8575f80fd5b50565b5f813590506104f9816104d5565b92915050565b5f60208284031215610514576105136102eb565b5b5f610521848285016104eb565b91505092915050565b5f81519050919050565b5f82825260208201905092915050565b5f819050602082019050919050565b5f81519050919050565b5f82825260208201905092915050565b8281835e5f83830152505050565b5f61058582610553565b61058f818561055d565b935061059f81856020860161056d565b6105a8816102fb565b840191505092915050565b5f604083015f8301518482035f8601526105cd828261057b565b915050602083015184820360208601526105e7828261057b565b9150508091505092915050565b5f6105ff83836105b3565b905092915050565b5f602082019050919050565b5f61061d8261052a565b6106278185610534565b93508360208202850161063985610544565b805f5b85811015610674578484038952815161065585826105f4565b945061066083610607565b925060208a0199505060018101905061063c565b50829750879550505050505092915050565b5f6020820190508181035f83015261069e8184610613565b905092915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52602260045260245ffd5b5f60028204905060018216806106ea57607f821691505b6020821081036106fd576106fc6106a6565b5b50919050565b5f819050815f5260205f209050919050565b5f6020601f8301049050919050565b5f82821b905092915050565b5f6008830261075f7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff82610724565b6107698683610724565b95508019841693508086168417925050509392505050565b5f819050919050565b5f819050919050565b5f6107ad6107a86107a384610781565b61078a565b610781565b9050919050565b5f819050919050565b6107c683610793565b6107da6107d2826107b4565b848454610730565b825550505050565b5f90565b6107ee6107e2565b6107f98184846107bd565b505050565b5b8181101561081c576108115f826107e6565b6001810190506107ff565b5050565b601f8211156108615761083281610703565b61083b84610715565b8101602085101561084a578190505b61085e61085685610715565b8301826107fe565b50505b505050565b5f82821c905092915050565b5f6108815f1984600802610866565b1980831691505092915050565b5f6108998383610872565b9150826002028217905092915050565b6108b282610553565b67ffffffffffffffff8111156108cb576108ca61030b565b5b6108d582546106d3565b6108e0828285610820565b5f60209050601f831160018114610911575f84156108ff578287015190505b610909858261088e565b865550610970565b601f19841661091f86610703565b5f5b8281101561094657848901518255600182019150602085019450602081019050610921565b86831015610963578489015161095f601f891682610872565b8355505b6001600288020188555050505b50505050505056fea2646970667358221220eb91f434691d2748c26d2420f1701b5d3615421d35f138fb7820d4ab84839cb764736f6c634300081a0033";

    public static final String FUNC_ADDCID = "addCID";

    public static final String FUNC_GETCIDS = "getCIDs";

    @Deprecated
    protected CIDManager(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        super(BINARY, contractAddress, web3j, credentials, gasPrice, gasLimit);
    }

    protected CIDManager(String contractAddress, Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, web3j, credentials, contractGasProvider);
    }

    @Deprecated
    protected CIDManager(String contractAddress, Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        super(BINARY, contractAddress, web3j, transactionManager, gasPrice, gasLimit);
    }

    protected CIDManager(String contractAddress, Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        super(BINARY, contractAddress, web3j, transactionManager, contractGasProvider);
    }

    public RemoteFunctionCall<TransactionReceipt> addCID(String _vehiclePlate, String _ipfsCID) {
        final Function function = new Function(
                FUNC_ADDCID, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Utf8String(_vehiclePlate), 
                new org.web3j.abi.datatypes.Utf8String(_ipfsCID)), 
                Collections.<TypeReference<?>>emptyList());
        return executeRemoteCallTransaction(function);
    }

    public RemoteFunctionCall<List> getCIDs(String _owner) {
        final Function function = new Function(FUNC_GETCIDS, 
                Arrays.<Type>asList(new org.web3j.abi.datatypes.Address(160, _owner)), 
                Arrays.<TypeReference<?>>asList(new TypeReference<DynamicArray<CIDInfo>>() {}));
        return new RemoteFunctionCall<List>(function,
                new Callable<List>() {
                    @Override
                    @SuppressWarnings("unchecked")
                    public List call() throws Exception {
                        List<Type> result = (List<Type>) executeCallSingleValueReturn(function, List.class);
                        return convertToNative(result);
                    }
                });
    }

    @Deprecated
    public static CIDManager load(String contractAddress, Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        return new CIDManager(contractAddress, web3j, credentials, gasPrice, gasLimit);
    }

    @Deprecated
    public static CIDManager load(String contractAddress, Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        return new CIDManager(contractAddress, web3j, transactionManager, gasPrice, gasLimit);
    }

    public static CIDManager load(String contractAddress, Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        return new CIDManager(contractAddress, web3j, credentials, contractGasProvider);
    }

    public static CIDManager load(String contractAddress, Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return new CIDManager(contractAddress, web3j, transactionManager, contractGasProvider);
    }

    public static RemoteCall<CIDManager> deploy(Web3j web3j, Credentials credentials, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(CIDManager.class, web3j, credentials, contractGasProvider, BINARY, "");
    }

    @Deprecated
    public static RemoteCall<CIDManager> deploy(Web3j web3j, Credentials credentials, BigInteger gasPrice, BigInteger gasLimit) {
        return deployRemoteCall(CIDManager.class, web3j, credentials, gasPrice, gasLimit, BINARY, "");
    }

    public static RemoteCall<CIDManager> deploy(Web3j web3j, TransactionManager transactionManager, ContractGasProvider contractGasProvider) {
        return deployRemoteCall(CIDManager.class, web3j, transactionManager, contractGasProvider, BINARY, "");
    }

    @Deprecated
    public static RemoteCall<CIDManager> deploy(Web3j web3j, TransactionManager transactionManager, BigInteger gasPrice, BigInteger gasLimit) {
        return deployRemoteCall(CIDManager.class, web3j, transactionManager, gasPrice, gasLimit, BINARY, "");
    }
}
