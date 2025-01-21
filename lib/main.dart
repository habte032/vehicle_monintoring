import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_monintoring/provider/vehicle_provider.dart';
import 'screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VehicleProvider()..loadVehicles()),
      ],
      child: MaterialApp(
        title: 'Vehicle Monitoring App',
        theme: ThemeData(
          primaryColor: Color(0xFF16213E),
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          scaffoldBackgroundColor: Color(0xFF1A1A2E),
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFE94560)),
        ),
        home: DashboardScreen(),
      ),
    );
  }
}
