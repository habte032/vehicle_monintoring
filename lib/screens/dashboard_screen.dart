
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_monintoring/provider/vehicle_provider.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_monintoring/widgets/app_bar.dart';
import 'package:vehicle_monintoring/widgets/header.dart';
import 'package:vehicle_monintoring/screens/add_update_vehicle_screen.dart';
import 'package:vehicle_monintoring/widgets/vehicles_list.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fabAnimationController;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    try {
      await context.read<VehicleProvider>().loadVehicles();
    } catch (e) {
      _showErrorSnackbar('Failed to load vehicles');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: _loadVehicles,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: RefreshIndicator(
        onRefresh: _loadVehicles,
        color: const Color(0xFFE94560),
        backgroundColor: const Color(0xFF16213E),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CustomAppBar(),
              Header(),
              VehiclesList(loadVehicles: _loadVehicles),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildFAB() {
    return AnimatedBuilder(
      animation: _fabAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_fabAnimationController.value * 0.1),
          child: FloatingActionButton.extended(
            onPressed: () => _navigateToAddVehicle(),
            backgroundColor: const Color.fromARGB(255, 18, 67, 226),
            icon: const Icon(Icons.add),
            label: Text(
              'Add Vehicle',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToAddVehicle() async {
    _fabAnimationController.forward();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddUpdateVehicleScreen(),
      ),
    );
    _fabAnimationController.reverse();
    _loadVehicles();
  }
}
