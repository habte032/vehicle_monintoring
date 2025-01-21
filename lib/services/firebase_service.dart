import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vehicle.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<List<Vehicle>> getVehicles() async {
  QuerySnapshot snapshot = await _firestore.collection('vehicles').get();
  return snapshot.docs.map((doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Vehicle(
      id: doc.id, 
      name: data['name'],
      status: data['status'],
      lastKnownLocation: data['lastKnownLocation'],
      fuelLevel: data['fuelLevel'],
      batteryLevel: data['batteryLevel'],
    );
  }).toList();
}
  Future<void> addVehicle(Vehicle vehicle) async {
    if (vehicle.id.isEmpty) {
      String newId = _firestore.collection('vehicles').doc().id; // Generate new ID
      print('New ID: $newId');
      vehicle = Vehicle(
        id: newId,
        name: vehicle.name,
        status: vehicle.status,
        lastKnownLocation: vehicle.lastKnownLocation,
        fuelLevel: vehicle.fuelLevel,
        batteryLevel: vehicle.batteryLevel,
      );
    }
    await _firestore.collection('vehicles').doc(vehicle.id).set(vehicle.toMap());
  }

  Future<void> updateVehicle(Vehicle vehicle) async {
    if (vehicle.id.isEmpty) {
      throw Exception('Vehicle ID must not be empty');
    }
    await _firestore.collection('vehicles').doc(vehicle.id).update(vehicle.toMap());
  }

    Future<void> deleteVehicle(String vehicleId) async {
    if (vehicleId.isEmpty) {
      throw Exception('Vehicle ID must not be empty');
    }
    await _firestore.collection('vehicles').doc(vehicleId).delete();
  }
}