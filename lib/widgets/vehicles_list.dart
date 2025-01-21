import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vehicle_monintoring/models/vehicle.dart';
import 'package:vehicle_monintoring/provider/vehicle_provider.dart';
import 'package:vehicle_monintoring/screens/vehicle_details_screen.dart';
import 'package:vehicle_monintoring/widgets/vehicle_card.dart';

class VehiclesList extends StatelessWidget {
  final Future<void> Function() loadVehicles;

  const VehiclesList({Key? key, required this.loadVehicles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildShimmerCard(),
                childCount: 3,
              ),
            ),
          );
        }

        if (provider.vehicles.isEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.directions_car_outlined,
                    size: 64,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No vehicles found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: loadVehicles,
                    child: const Text(
                      'Refresh',
                      style: TextStyle(
                        color: Color(0xFFE94560),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => VehicleCard(
                vehicle: provider.vehicles[index],
                onTap: () => _navigateToDetails(context, provider.vehicles[index]),
              ),
              childCount: provider.vehicles.length,
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerCard() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade800,
    highlightColor: Colors.grey.shade600,
    child: Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 18,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12,
                    color: Colors.white,
                    width: 120,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 20,
              width: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}
 void _navigateToDetails(BuildContext context, Vehicle vehicle) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            VehicleDetailsScreen(vehicle: vehicle),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
