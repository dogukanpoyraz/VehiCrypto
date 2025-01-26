import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://xxx.xxx.x.xx:xxxx/api/maintenance';

  Future<bool> sendMaintenanceData(Map<String, dynamic> maintenanceData) async {
    final url = Uri.parse('$baseUrl/add');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(maintenanceData),
      );
      print(maintenanceData);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print('Data successfully sent!');
        print(response.body);
        return true;
      } else {
        throw Exception('Error: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> fetchMaintenanceData(String ref) async {
    final url = Uri.parse('$baseUrl/get/$ref');
    print(url);

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return {
        'vehicle_plate': data['vehicle_plate'],
        'vehicle_brand': data['vehicle_brand'],
        'vehicle_model': data['vehicle_model'],
        'vehicle_km': data['vehicle_km'],
        'engine_oil': data['engine_oil'],
        'steering_oil': data['steering_oil'],
        'transmission_oil': data['transmission_oil'],
        'oil_filter': data['oil_filter'],
        'air_filter': data['air_filter'],
        'pollen_filter': data['pollen_filter'],
        'spark_plug': data['spark_plug'],
        'timing_belt': data['timing_belt'],
        'clutchB_belt': data['clutchB_belt'],
        'front_brake_pads': data['front_brake_pads'],
        'rear_brake_pads': data['rear_brake_pads'],
        'front_shock_absorber': data['front_shock_absorber'],
        'rear_shock_absorber': data['rear_shock_absorber'],
        'date': data['date'],
        'ipfsCid': data['ipfsCid'],
        'referenceCode': data['referenceCode'],
        'v_belt': data['v_belt'],
      };
    } else {
      throw Exception(
          'Error fetching data: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<String>> fetchMaintenanceList(String plate) async {
    final url = Uri.parse('$baseUrl/getList/$plate');
    print(url);

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      List<String> dataList = List<String>.from(json.decode(response.body));
      return dataList;
    } else {
      throw Exception(
          'Error fetching list: ${response.statusCode} - ${response.body}');
    }
  }
}
