import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../services/firebase_service.dart';

class AddUpdateVehicleScreen extends StatefulWidget {
  final Vehicle? vehicle;

  const AddUpdateVehicleScreen({super.key, this.vehicle});

  @override
  _AddUpdateVehicleScreenState createState() => _AddUpdateVehicleScreenState();
}

class _AddUpdateVehicleScreenState extends State<AddUpdateVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseService _firebaseService = FirebaseService();

  late TextEditingController _nameController;
  late TextEditingController _statusController;
  late TextEditingController _locationController;
  late double _fuelLevel;
  late double _batteryLevel;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.vehicle?.name ?? '');
    _statusController =
        TextEditingController(text: widget.vehicle?.status ?? '');
    _locationController =
        TextEditingController(text: widget.vehicle?.lastKnownLocation ?? '');
    _fuelLevel = widget.vehicle?.fuelLevel ?? 50.0;
    _batteryLevel = widget.vehicle?.batteryLevel ?? 50.0;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _statusController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final vehicle = Vehicle(
        id: widget.vehicle?.id ?? '', // Use existing ID if updating
        name: _nameController.text,
        status: _statusController.text,
        lastKnownLocation: _locationController.text,
        fuelLevel: _fuelLevel,
        batteryLevel: _batteryLevel,
      );

      try {
        if (widget.vehicle == null) {
          // Adding a new vehicle
          await _firebaseService.addVehicle(vehicle);
          _showSnackbar('Vehicle added successfully');
        } else {
          // Updating an existing vehicle
          await _firebaseService.updateVehicle(vehicle);
          _showSnackbar('Vehicle updated successfully');
        }
        Navigator.pop(context);
      } catch (e) {
        print(e);
        _showSnackbar('Error: ${e.toString()}');
      }
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        message,
        textAlign: TextAlign.center,
      )),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[850],
        ),
        validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  Widget _buildSlider(String label, double value,
      ValueChanged<double> onChanged, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white70),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
        Slider(
          value: value,
          min: 0,
          max: 100,
          divisions: 10,
          label: value.round().toString(),
          onChanged: onChanged,
          activeColor: Colors.blueAccent,
        ),
        Text('${value.round()}%',
            style: const TextStyle(fontSize: 14, color: Colors.white70)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(widget.vehicle == null ? 'Add Vehicle' : 'Update Vehicle'),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 4,
      ),
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Card(
              color: Colors.grey[900],
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Vehicle Information',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    _buildTextField(
                        _nameController, 'Name', Icons.directions_car),
                    _buildTextField(
                        _statusController, 'Status', Icons.info_outline),
                    _buildTextField(
                        _locationController, 'Location', Icons.location_on),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildSlider(
                'Fuel Level',
                _fuelLevel,
                (value) => setState(() => _fuelLevel = value),
                Icons.local_gas_station),
            _buildSlider(
                'Battery Level',
                _batteryLevel,
                (value) => setState(() => _batteryLevel = value),
                Icons.battery_charging_full),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 18, 67, 226),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _submitForm,
              child: Text(
                  widget.vehicle == null ? 'Add Vehicle' : 'Update Vehicle',
                  style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
