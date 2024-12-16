import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  TextEditingController _codeController = TextEditingController();

  String contractAddress = "CONTRACT_ADDRESS";
  String rpcUrl = "HTTP://127.0.0.1:8545";
  late Web3Client ethClient;

  Map<String, dynamic> carData = {};

  @override
  void initState() {
    super.initState();
    ethClient = Web3Client(rpcUrl, Client());
  }

  Future<void> getCarInfo(String code) async {
    String abi = '''
    [
      {
        "inputs": [
          {
            "internalType": "string",
            "name": "code",
            "type": "string"
          }
        ],
        "name": "getCarInfoByCode",
        "outputs": [
          {
            "internalType": "string",
            "name": "marka",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "model",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "plaka",
            "type": "string"
          },
          {
            "internalType": "uint256",
            "name": "kilometre",
            "type": "uint256"
          },
          {
            "internalType": "bool",
            "name": "motorYagi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "direksiyonYagi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "sanzimanYagi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "yagFiltresi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "havaFiltresi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "polenFiltresi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "buji",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "vKayisi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "trigerKayisi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "debriyajKayisi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "onFrenBalatasi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "arkaFrenBalatasi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "onAmortisor",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "arkaAmortisor",
            "type": "bool"
          }
        ],
        "stateMutability": "view",
        "type": "function"
      }
    ]
    ''';

    final contract = DeployedContract(
      ContractAbi.fromJson(abi, "CarService"),
      EthereumAddress.fromHex(contractAddress),
    );

    final function = contract.function("getCarInfoByCode");

    final result = await ethClient.call(
      contract: contract,
      function: function,
      params: [code],
    );

    setState(() {
      carData = {
        "marka": result[0] as String,
        "model": result[1] as String,
        "plaka": result[2] as String,
        "kilometre": result[3].toString(),
        "motorYagi": result[4],
        "direksiyonYagi": result[5],
        "sanzimanYagi": result[6],
        "yagFiltresi": result[7],
        "havaFiltresi": result[8],
        "polenFiltresi": result[9],
        "buji": result[10],
        "vKayisi": result[11],
        "trigerKayisi": result[12],
        "debriyajKayisi": result[13],
        "onFrenBalatasi": result[14],
        "arkaFrenBalatasi": result[15],
        "onAmortisor": result[16],
        "arkaAmortisor": result[17],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Müşteri Girişi")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: "11 Haneli Kod"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  getCarInfo(_codeController.text);
                },
                child: Text("Bilgileri Getir")),
            SizedBox(height: 20),
            carData.isNotEmpty
                ? Expanded(
                    child: ListView(
                    children: carData.entries.map((entry) {
                      return ListTile(
                        title: Text(entry.key),
                        subtitle: Text(entry.value.toString()),
                      );
                    }).toList(),
                  ))
                : Container()
          ],
        ),
      ),
    );
  }
}
