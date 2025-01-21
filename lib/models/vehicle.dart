class Vehicle {
  final String id;
  final String name;
  String status;
  String lastKnownLocation;
  double fuelLevel;
  double batteryLevel;

  Vehicle({
    required this.id,
    required this.name,
    required this.status,
    required this.lastKnownLocation,
    required this.fuelLevel,
    required this.batteryLevel,
  });

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      lastKnownLocation: map['lastKnownLocation'],
      fuelLevel: map['fuelLevel'],
      batteryLevel: map['batteryLevel'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'lastKnownLocation': lastKnownLocation,
      'fuelLevel': fuelLevel,
      'batteryLevel': batteryLevel,
    };
  }
}

