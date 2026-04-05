import 'package:flutter/material.dart';

/// ============================================================================
/// CUSTOM BOTTOM NAVIGATION BAR - FIXED VERSION
/// ============================================================================
/// Bottom navbar yang konsisten di semua halaman
/// Tinggi dan posisi sudah di-fix agar tidak berbeda-beda
/// ============================================================================

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // CRITICAL: Height yang FIXED untuk semua device
      height: 80, // Tinggi fixed, tidak pakai responsive
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        // CRITICAL: SafeArea untuk handle notch di bawah
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icon 1: Home
            _buildNavItem(
              index: 0,
              icon: Icons.home,
              label: 'Home',
              isSelected: selectedIndex == 0,
            ),

            // Icon 2: Kendaraan
            _buildNavItem(
              index: 1,
              icon: Icons.directions_car,
              label: 'Kendaraan',
              isSelected: selectedIndex == 1,
            ),

            // Icon 3: QR/Booking (Tombol Tengah yang Besar)
            _buildCenterButton(),

            // Icon 4: Orderan
            _buildNavItem(
              index: 2,
              icon: Icons.receipt_long,
              label: 'Orderan',
              isSelected: selectedIndex == 2,
            ),

            // Icon 5: Profile
            _buildNavItem(
              index: 3,
              icon: Icons.person,
              label: 'Profile',
              isSelected: selectedIndex == 3,
            ),
          ],
        ),
      ),
    );
  }

  /// Item navigasi biasa (Home, Kendaraan, Orderan, Profile)
  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => onItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected
                  ? const Color(0xFF4A7AB8)
                  : Colors.grey.shade400,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? const Color(0xFF4A7AB8)
                    : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Tombol tengah yang besar (QR/Booking)
  Widget _buildCenterButton() {
    return Expanded(
      child: InkWell(
        onTap: () => onItemTapped(4), // Index 4 = Booking
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4AC6E5), Color(0xFF4A7AB8)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A7AB8).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
