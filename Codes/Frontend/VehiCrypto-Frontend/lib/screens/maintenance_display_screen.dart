import 'package:flutter/material.dart';
import 'package:blockchainproject/Api/apiService.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MaintenanceDisplayScreen extends StatefulWidget {
  @override
  _MaintenanceDisplayScreen createState() => _MaintenanceDisplayScreen();
}

class _MaintenanceDisplayScreen extends State<MaintenanceDisplayScreen> {
  final ApiService apiService = ApiService();

  List<Map<String, dynamic>> maintenanceDataList = [];
  bool isLoading = false;
  final TextEditingController plateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool isValidPlate(String plate) {
    if (plate.isEmpty) return false;

    final RegExp plateRegExp = RegExp(r'^[0-9]{2}[A-Za-z]{1,3}[0-9]{2,4}$');

    if (!plateRegExp.hasMatch(plate)) {}

    List<String> parts = plate.split(' ');

    if (plate.contains(' ')) {
      return false;
    }

    String secondPart = plate.substring(2, plate.length - 4);

    if (secondPart.length == 1) {
      return plate.length == 10;
    }

    return true;
  }

  Future<void> fetchMaintenanceDataList(String plate) async {
    try {
      setState(() {
        isLoading = true;
      });

      final cidList = await apiService.fetchMaintenanceList(plate);

      List<Map<String, dynamic>> fetchedDataList = [];
      for (String cid in cidList) {
        final data = await apiService.fetchMaintenanceData(cid);
        fetchedDataList.add(data);
      }

      setState(() {
        maintenanceDataList = fetchedDataList;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching maintenance data: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              cursor: '',
              'Maintenance Records',
              textStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              speed: Duration(milliseconds: 50),
            ),
          ],
          totalRepeatCount: 1,
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: plateController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Enter Vehicle Plate',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Enter the plate number',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  plateController.text = value.toUpperCase();
                  plateController.selection = TextSelection.fromPosition(
                      TextPosition(offset: plateController.text.length));
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String plate = plateController.text.trim();

                if (plate.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a vehicle plate.')),
                  );
                  return;
                }

                if (!isValidPlate(plate)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Invalid plate format. Please check.')),
                  );
                  return;
                }

                fetchMaintenanceDataList(plate);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white),
              child: Text('Get Data'),
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : maintenanceDataList.isEmpty
                    ? Center(
                        child: Text(
                          'No maintenance records found.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: maintenanceDataList.length,
                          itemBuilder: (context, index) {
                            return _buildMaintenanceCard(
                                maintenanceDataList[index]);
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceCard(Map<String, dynamic> record) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vehicle Plate: ${record['vehicle_plate']}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 12),
            Text(
              'Brand: ${record['vehicle_brand']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            ),
            Text(
              'Model: ${record['vehicle_model']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            ),
            Text(
              'KM: ${record['vehicle_km']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            ),
            Text(
              'Date: ${record['date']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            ),
            SizedBox(height: 16),
            Divider(
              color: Colors.blueAccent,
              thickness: 1,
            ),
            SizedBox(height: 12),
            Text(
              'Maintenance Parts:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            _buildMaintenanceParts(record),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceParts(Map<String, dynamic> record) {
    final parts = [
      'engine_oil',
      'steering_oil',
      'transmission_oil',
      'oil_filter',
      'air_filter',
      'pollen_filter',
      'spark_plug',
      'v_belt',
      'timing_belt',
      'clutch_belt',
      'front_brake_pads',
      'rear_brake_pads',
      'front_shock_absorber',
      'rear_shock_absorber',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: parts.map((part) {
        final isChecked = record[part] == true;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(
                isChecked ? Icons.check_circle : Icons.cancel,
                color: isChecked ? Colors.green : Colors.red,
                size: 24,
              ),
              SizedBox(width: 12),
              Flexible(
                child: Text(
                  '${_formatPartName(part)}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _formatPartName(String part) {
    return part
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
