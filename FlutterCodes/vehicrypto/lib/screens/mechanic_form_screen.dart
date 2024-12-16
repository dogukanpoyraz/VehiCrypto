import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart'; // http paketi

class MechanicFormScreen extends StatefulWidget {
  const MechanicFormScreen({Key? key}) : super(key: key);

  @override
  _MechanicFormScreenState createState() => _MechanicFormScreenState();
}

class _MechanicFormScreenState extends State<MechanicFormScreen> {
  final _markaController = TextEditingController();
  final _modelController = TextEditingController();
  final _plakaController = TextEditingController();
  final _kmController = TextEditingController();

  bool motorYagi = false;
  bool direksiyonYagi = false;
  bool sanzimanYagi = false;
  bool yagFiltresi = false;
  bool havaFiltresi = false;
  bool polenFiltresi = false;
  bool buji = false;
  bool vKayisi = false;
  bool trigerKayisi = false;
  bool debriyajKayisi = false;
  bool onFrenBalatasi = false;
  bool arkaFrenBalatasi = false;
  bool onAmortisor = false;
  bool arkaAmortisor = false;

  String contractAddress = "CONTRACT_ADDRESS";
  String privateKey = "PRIVATE_KEY";
  String rpcUrl = "HTTP://127.0.0.1:8545";

  late Web3Client ethClient;

  @override
  void initState() {
    super.initState();
    ethClient = Web3Client(rpcUrl, Client());
  }

  Future<String> sendCarInfo() async {
    String code =
        (DateTime.now().millisecondsSinceEpoch.toString()).substring(0, 11);
    String abi = '''
    [
      {
        "inputs": [
          {
            "internalType": "string",
            "name": "code",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "_marka",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "_model",
            "type": "string"
          },
          {
            "internalType": "string",
            "name": "_plaka",
            "type": "string"
          },
          {
            "internalType": "uint256",
            "name": "_kilometre",
            "type": "uint256"
          },
          {
            "internalType": "bool",
            "name": "_motorYagi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_direksiyonYagi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_sanzimanYagi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_yagFiltresi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_havaFiltresi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_polenFiltresi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_buji",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_vKayisi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_trigerKayisi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_debriyajKayisi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_onFrenBalatasi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_arkaFrenBalatasi",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_onAmortisor",
            "type": "bool"
          },
          {
            "internalType": "bool",
            "name": "_arkaAmortisor",
            "type": "bool"
          }
        ],
        "name": "setCarInfo",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
      }
    ]
    ''';

    final credentials = EthPrivateKey.fromHex(privateKey);
    final contract = DeployedContract(
      ContractAbi.fromJson(abi, "CarService"),
      EthereumAddress.fromHex(contractAddress),
    );

    final function = contract.function("setCarInfo");

    await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [
          code,
          _markaController.text,
          _modelController.text,
          _plakaController.text,
          BigInt.from(int.parse(_kmController.text)),
          motorYagi,
          direksiyonYagi,
          sanzimanYagi,
          yagFiltresi,
          havaFiltresi,
          polenFiltresi,
          buji,
          vKayisi,
          trigerKayisi,
          debriyajKayisi,
          onFrenBalatasi,
          arkaFrenBalatasi,
          onAmortisor,
          arkaAmortisor
        ],
      ),
      chainId: 1337,
      fetchChainIdFromNetworkId: false,
    );

    return code;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Araç Bakım Bilgileri")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _markaController,
                decoration: InputDecoration(labelText: "Marka"),
              ),
              TextField(
                controller: _modelController,
                decoration: InputDecoration(labelText: "Model"),
              ),
              TextField(
                controller: _plakaController,
                decoration: InputDecoration(labelText: "Plaka"),
              ),
              TextField(
                controller: _kmController,
                decoration: InputDecoration(labelText: "Kilometre"),
                keyboardType: TextInputType.number,
              ),
              CheckboxListTile(
                value: motorYagi,
                onChanged: (val) => setState(() => motorYagi = val!),
                title: Text("Motor Yağı"),
              ),
              CheckboxListTile(
                value: direksiyonYagi,
                onChanged: (val) => setState(() => direksiyonYagi = val!),
                title: Text("Direksiyon Yağı"),
              ),
              CheckboxListTile(
                value: sanzimanYagi,
                onChanged: (val) => setState(() => sanzimanYagi = val!),
                title: Text("Şanzıman Yağı"),
              ),
              CheckboxListTile(
                value: yagFiltresi,
                onChanged: (val) => setState(() => yagFiltresi = val!),
                title: Text("Yağ Filtresi"),
              ),
              CheckboxListTile(
                value: havaFiltresi,
                onChanged: (val) => setState(() => havaFiltresi = val!),
                title: Text("Hava Filtresi"),
              ),
              CheckboxListTile(
                value: polenFiltresi,
                onChanged: (val) => setState(() => polenFiltresi = val!),
                title: Text("Polen Filtresi"),
              ),
              CheckboxListTile(
                value: buji,
                onChanged: (val) => setState(() => buji = val!),
                title: Text("Buji"),
              ),
              CheckboxListTile(
                value: vKayisi,
                onChanged: (val) => setState(() => vKayisi = val!),
                title: Text("V Kayışı"),
              ),
              CheckboxListTile(
                value: trigerKayisi,
                onChanged: (val) => setState(() => trigerKayisi = val!),
                title: Text("Triger Kayışı"),
              ),
              CheckboxListTile(
                value: debriyajKayisi,
                onChanged: (val) => setState(() => debriyajKayisi = val!),
                title: Text("Debriyaj Kayışı"),
              ),
              CheckboxListTile(
                value: onFrenBalatasi,
                onChanged: (val) => setState(() => onFrenBalatasi = val!),
                title: Text("Ön Fren Balatası"),
              ),
              CheckboxListTile(
                value: arkaFrenBalatasi,
                onChanged: (val) => setState(() => arkaFrenBalatasi = val!),
                title: Text("Arka Fren Balatası"),
              ),
              CheckboxListTile(
                value: onAmortisor,
                onChanged: (val) => setState(() => onAmortisor = val!),
                title: Text("Ön Amortisör"),
              ),
              CheckboxListTile(
                value: arkaAmortisor,
                onChanged: (val) => setState(() => arkaAmortisor = val!),
                title: Text("Arka Amortisör"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String code = await sendCarInfo();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Bilgi"),
                          content:
                              Text("Araç bilgileri kaydedildi. Kod: $code"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Tamam"))
                          ],
                        );
                      });
                },
                child: Text("Kaydet ve Kod Al"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
