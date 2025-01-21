import 'package:flutter/material.dart';
import 'package:vehicle_monintoring/models/vehicle.dart';
import 'package:vehicle_monintoring/screens/add_update_vehicle_screen.dart';

class VehicleDetailsScreen extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleDetailsScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(vehicle.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildStatusCard(),
              const SizedBox(height: 16),
              _buildInfoCard(Icons.location_on, 'Last Known Location',
                  vehicle.lastKnownLocation, Colors.blue),
              _buildInfoCard(Icons.warning_amber, 'System Status',
                  'All systems operational', Colors.amber),
              _buildProgressCard(Icons.local_gas_station, 'Fuel Level',
                  vehicle.fuelLevel, Colors.cyan),
              _buildProgressCard(Icons.battery_charging_full, 'Battery Level',
                  vehicle.batteryLevel, Colors.green),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUpdateVehicleScreen(vehicle: vehicle),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 18, 67, 226),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 10,
        child: const Icon(Icons.edit, size: 28),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.directions_car, color: Colors.green, size: 28),
                SizedBox(width: 12),
                Text('Current Status',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(vehicle.status,
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      IconData icon, String title, String content, Color iconColor) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(width: 12),
                Text(title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            const SizedBox(height: 12),
            Text(content,
                style: TextStyle(color: Colors.grey[300], fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(
      IconData icon, String title, double value, Color color) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Text(title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: value / 100,
              color: color,
              backgroundColor: Colors.grey[700],
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 12),
            Text('${value.toStringAsFixed(1)}%',
                style: TextStyle(
                    color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
