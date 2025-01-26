import 'package:flutter/material.dart';
import 'package:blockchainproject/Api/apiService.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MaintenanceScreen extends StatefulWidget {
  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController vehiclePlateController = TextEditingController();
  TextEditingController vehicleBrandController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController vehicleKmController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  bool engineOil = false;
  bool steeringOil = false;
  bool transmissionOil = false;
  bool oilFilter = false;
  bool airFilter = false;
  bool pollenFilter = false;
  bool sparkPlug = false;
  bool vBelt = false;
  bool timingBelt = false;
  bool clutchBelt = false;
  bool frontBrakePads = false;
  bool rearBrakePads = false;
  bool frontShockAbsorber = false;
  bool rearShockAbsorber = false;

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              cursor: '',
              'Maintenance Form',
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
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(vehiclePlateController, 'Vehicle Plate', true),
              _buildTextField(vehicleBrandController, 'Vehicle Brand', false),
              _buildTextField(vehicleModelController, 'Vehicle Model', false),
              _buildTextField(vehicleKmController, 'Vehicle KM', false),
              _buildTextField(dateController, 'Maintenance Date', false),
              SizedBox(height: 20),
              Text(
                'Select Maintenance Parts:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              _buildCheckbox('Engine Oil', engineOil,
                  (value) => setState(() => engineOil = value!)),
              _buildCheckbox('Steering Oil', steeringOil,
                  (value) => setState(() => steeringOil = value!)),
              _buildCheckbox('Transmission Oil', transmissionOil,
                  (value) => setState(() => transmissionOil = value!)),
              _buildCheckbox('Oil Filter', oilFilter,
                  (value) => setState(() => oilFilter = value!)),
              _buildCheckbox('Air Filter', airFilter,
                  (value) => setState(() => airFilter = value!)),
              _buildCheckbox('Pollen Filter', pollenFilter,
                  (value) => setState(() => pollenFilter = value!)),
              _buildCheckbox('Spark Plug', sparkPlug,
                  (value) => setState(() => sparkPlug = value!)),
              _buildCheckbox(
                  'V Belt', vBelt, (value) => setState(() => vBelt = value!)),
              _buildCheckbox('Timing Belt', timingBelt,
                  (value) => setState(() => timingBelt = value!)),
              _buildCheckbox('Clutch Belt', clutchBelt,
                  (value) => setState(() => clutchBelt = value!)),
              _buildCheckbox('Front Brake Pads', frontBrakePads,
                  (value) => setState(() => frontBrakePads = value!)),
              _buildCheckbox('Rear Brake Pads', rearBrakePads,
                  (value) => setState(() => rearBrakePads = value!)),
              _buildCheckbox('Front Shock Absorber', frontShockAbsorber,
                  (value) => setState(() => frontShockAbsorber = value!)),
              _buildCheckbox('Rear Shock Absorber', rearShockAbsorber,
                  (value) => setState(() => rearShockAbsorber = value!)),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    final vehiclePlate = vehiclePlateController.text;
                    final date = dateController.text;

                    final maintenanceData = {
                      'vehicle_plate': vehiclePlate,
                      'vehicle_brand': vehicleBrandController.text,
                      'vehicle_model': vehicleModelController.text,
                      'vehicle_km': vehicleKmController.text,
                      'date': date,
                      'engine_oil': engineOil,
                      'steering_oil': steeringOil,
                      'transmission_oil': transmissionOil,
                      'oil_filter': oilFilter,
                      'air_filter': airFilter,
                      'pollen_filter': pollenFilter,
                      'spark_plug': sparkPlug,
                      'v_belt': vBelt,
                      'timing_belt': timingBelt,
                      'clutch_belt': clutchBelt,
                      'front_brake_pads': frontBrakePads,
                      'rear_brake_pads': rearBrakePads,
                      'front_shock_absorber': frontShockAbsorber,
                      'rear_shock_absorber': rearShockAbsorber,
                    };

                    apiService
                        .sendMaintenanceData(maintenanceData)
                        .then((response) {
                      if (response) {
                        Fluttertoast.showToast(
                          msg: "Successfully Submitted!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Submission Failed! Please try again.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    }).catchError((e) {
                      Fluttertoast.showToast(
                        msg: "An error occurred: $e",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.5),
                          blurRadius: 15)
                    ],
                  ),
                  child: Text(
                    'Submit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, bool isPlate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[400]),
          filled: true,
          fillColor: Colors.grey[850],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[700]!),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        onChanged: (value) {
          if (isPlate || label == "Vehicle Brand" || label == "Vehicle Model") {
            controller.text = value.toUpperCase();
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length));
          }
        },
      ),
    );
  }

  Widget _buildCheckbox(
      String label, bool value, ValueChanged<bool?>? onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CheckboxListTile(
        title: Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        value: value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        activeColor: Colors.blueAccent,
        checkColor: Colors.white,
      ),
    );
  }
}
