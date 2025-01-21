import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_monintoring/provider/vehicle_provider.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VehicleProvider>(
      builder: (context, provider, child) {
        return SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          stretch: true,
          backgroundColor: const Color(0xFF16213E),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Vehicle Dashboard',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF16213E), Color(0xFF0F3460)],
                    ),
                  ),
                ),
                Center(
                  child: provider.isRefreshing
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE94560)),
                        )
                      : SvgPicture.asset(
                          'assets/dashboard_icon.svg',
                          width: 80,
                          height: 80,
                          color: Colors.white.withOpacity(0.9),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
