import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../services/firebase_service.dart';

class VehicleProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Vehicle> _vehicles = [];
  bool _isLoading = true;
  bool _isRefreshing = false;

  List<Vehicle> get vehicles => _vehicles;
  bool get isLoading => _isLoading;
  bool get isRefreshing => _isRefreshing;

  Future<void> loadVehicles() async {
    if (!_isLoading) {
      _isRefreshing = true;
      notifyListeners();
    }

    try {
      List<Vehicle> vehicles = await _firebaseService.getVehicles();
      _vehicles = vehicles;
      _isLoading = false;
      _isRefreshing = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _isRefreshing = false;
      notifyListeners();
      throw e; // Re-throw to handle in UI
    }
  }
}
