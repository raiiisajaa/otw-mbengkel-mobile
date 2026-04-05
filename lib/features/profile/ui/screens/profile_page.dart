import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // WAJIB IMPORT
import 'package:google_fonts/google_fonts.dart';

import 'package:otw_mbengkel/core/widgets/bottom_nav.dart';
import 'package:otw_mbengkel/features/home/ui/screens/home_page.dart';
import 'package:otw_mbengkel/features/vehicle/ui/screens/kendaraan_page.dart';
import 'package:otw_mbengkel/features/booking/ui/screens/booking_page.dart';
import 'package:otw_mbengkel/features/order/ui/screens/orderan_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // =========================================================================
  // NAVIGATION HANDLER
  // =========================================================================

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const KendaraanPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OrderanPage()),
        );
        break;
      case 3:
        break; // Tetap di halaman Profile
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // 1. KUNCI NAVBAR DISINI (Tanpa Stack)
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 3,
        onItemTapped: (index) => _handleNavigation(context, index),
      ),

      // 2. KONTEN UTAMA LEBIH BERSIH (Tanpa Stack & Spacer 100px)
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCoverHeader(),
              SizedBox(height: 30.h), // RESPONSIVE
              _buildProfileCard(),
              SizedBox(height: 24.h), // RESPONSIVE
              _buildQuickStats(),
              SizedBox(height: 24.h), // RESPONSIVE
              _buildFeatureGrid(),
              SizedBox(height: 24.h), // RESPONSIVE
              _buildSettingsSection(),
              SizedBox(height: 30.h), // Padding bawah secukupnya saja
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // COVER HEADER
  // =========================================================================

  Widget _buildCoverHeader() {
    // Stack di sini BOLEH dipertahankan karena fungsinya menumpuk foto profil di atas banner
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1. Background Gradient
        Container(
          height: 160.h, // RESPONSIVE
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4AC6E5), Color(0xFF27A4FB), Color(0xFF4A7AB8)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r), // RESPONSIVE
              bottomRight: Radius.circular(30.r), // RESPONSIVE
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 15.r,
                offset: Offset(0, 5.h),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(painter: _CoverPatternPainter()),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 40.h, // RESPONSIVE
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. FOTO PROFIL DI TENGAH BAAWAH
        Positioned(
          bottom: -50.h, // RESPONSIVE
          left: 0,
          right: 0,
          child: Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Lingkaran Luar (Transparan)
                    Container(
                      width: 124.w,
                      height: 124.w, // RESPONSIVE
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20.r,
                            offset: Offset(0, 8.h),
                          ),
                        ],
                      ),
                    ),
                    // Lingkaran Dalam (Foto)
                    Container(
                      width: 120.w,
                      height: 120.w, // RESPONSIVE
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                          width: 4.w,
                        ), // RESPONSIVE
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.r),
                        child: Image.asset(
                          'assets/img/profile_dzaky.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: Icon(
                                Icons.person,
                                size: 60.sp,
                                color: Colors.grey,
                              ), // RESPONSIVE
                            );
                          },
                        ),
                      ),
                    ),
                    // Badge Verified
                    Positioned(
                      bottom: 6.h,
                      right: 6.w, // RESPONSIVE
                      child: Container(
                        padding: EdgeInsets.all(4.w), // RESPONSIVE
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified,
                          color: const Color(0xFF4A7AB8),
                          size: 20.sp,
                        ), // RESPONSIVE
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h), // RESPONSIVE
                // Tombol Ubah Foto
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ), // RESPONSIVE
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r), // RESPONSIVE
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 14.sp,
                        color: const Color(0xFF4A7AB8),
                      ), // RESPONSIVE
                      SizedBox(width: 4.w),
                      Text(
                        "Ubah Foto",
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4A7AB8),
                        ), // RESPONSIVE
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // PROFILE CARD
  // =========================================================================

  Widget _buildProfileCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w), // RESPONSIVE
      child: Column(
        children: [
          SizedBox(height: 50.h), // RESPONSIVE
          Text(
            'Dzaky Raihan',
            style: GoogleFonts.poppins(
              fontSize: 24.sp, // RESPONSIVE
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 4.h), // RESPONSIVE
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.alternate_email,
                size: 14.sp,
                color: Colors.grey.shade500,
              ), // RESPONSIVE
              SizedBox(width: 4.w),
              Text(
                '@dzaky_raihan',
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ), // RESPONSIVE
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w), // RESPONSIVE
                width: 4.w,
                height: 4.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  shape: BoxShape.circle,
                ),
              ),
              Icon(
                Icons.location_on,
                size: 14.sp,
                color: Colors.grey.shade500,
              ), // RESPONSIVE
              SizedBox(width: 4.w),
              Text(
                'Jakarta',
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ), // RESPONSIVE
              ),
            ],
          ),
          SizedBox(height: 16.h), // RESPONSIVE
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 14.h,
            ), // RESPONSIVE
            decoration: BoxDecoration(
              color: const Color(0xFF4A7AB8).withOpacity(0.08),
              borderRadius: BorderRadius.circular(16.r), // RESPONSIVE
              border: Border.all(
                color: const Color(0xFF4A7AB8).withOpacity(0.2),
              ),
            ),
            child: Text(
              '🏎️ Pecinta otomotif & penggemar modifikasi mobil\n✨ Member sejak 2023',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.grey.shade700,
                height: 1.6,
              ), // RESPONSIVE
            ),
          ),
          SizedBox(height: 20.h), // RESPONSIVE
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildContactItem(
                Icons.phone,
                '+62 812 3456 7890',
                const Color(0xFF4A7AB8),
              ),
              SizedBox(width: 16.w), // RESPONSIVE
              _buildContactItem(
                Icons.email,
                'dzaky@otw.com',
                const Color(0xFF4A7AB8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 10.h,
      ), // RESPONSIVE
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r), // RESPONSIVE
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: color), // RESPONSIVE
          SizedBox(width: 8.w), // RESPONSIVE
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              color: color,
              fontWeight: FontWeight.w600,
            ), // RESPONSIVE
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // QUICK STATS
  // =========================================================================

  Widget _buildQuickStats() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w), // RESPONSIVE
      child: Row(
        children: [
          _buildStatCard(
            '12',
            'Pesanan',
            Icons.shopping_bag_rounded,
            const Color(0xFF4A7AB8),
          ),
          SizedBox(width: 12.w), // RESPONSIVE
          _buildStatCard(
            '8',
            'Kendaraan',
            Icons.directions_car_rounded,
            const Color(0xFF4AC6E5),
          ),
          SizedBox(width: 12.w), // RESPONSIVE
          _buildStatCard(
            '4.9',
            'Rating',
            Icons.star_rounded,
            const Color(0xFFFFB74D),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.w), // RESPONSIVE
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r), // RESPONSIVE
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12.r,
              offset: Offset(0, 4.h),
            ), // RESPONSIVE
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.w), // RESPONSIVE
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12.r), // RESPONSIVE
              ),
              child: Icon(icon, color: color, size: 24.sp), // RESPONSIVE
            ),
            SizedBox(height: 12.h), // RESPONSIVE
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ), // RESPONSIVE
            ),
            SizedBox(height: 4.h), // RESPONSIVE
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ), // RESPONSIVE
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // FEATURE GRID
  // =========================================================================

  Widget _buildFeatureGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w), // RESPONSIVE
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aksi Cepat',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ), // RESPONSIVE
          ),
          SizedBox(height: 12.h), // RESPONSIVE
          Row(
            children: [
              _buildActionCard(
                icon: Icons.edit_rounded,
                label: 'Edit Profil',
                color: const Color(0xFF4A7AB8),
                onTap: () => _showSnackBar('Edit Profil - Segera Hadir'),
              ),
              SizedBox(width: 12.w), // RESPONSIVE
              _buildActionCard(
                icon: Icons.share_rounded,
                label: 'Bagikan',
                color: const Color(0xFF4AC6E5),
                onTap: () => _showSnackBar('Fitur Bagikan - Segera Hadir'),
              ),
              SizedBox(width: 12.w), // RESPONSIVE
              _buildActionCard(
                icon: Icons.card_giftcard,
                label: 'Rewards',
                color: const Color(0xFF27A4FB),
                onTap: () => _showSnackBar('Rewards - Segera Hadir'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r), // RESPONSIVE
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.h), // RESPONSIVE
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r), // RESPONSIVE
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12.r,
                  offset: Offset(0, 4.h),
                ),
              ], // RESPONSIVE
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w), // RESPONSIVE
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12.r), // RESPONSIVE
                  ),
                  child: Icon(icon, color: color, size: 24.sp), // RESPONSIVE
                ),
                SizedBox(height: 10.h), // RESPONSIVE
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ), // RESPONSIVE
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // SETTINGS SECTION
  // =========================================================================

  Widget _buildSettingsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w), // RESPONSIVE
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pengaturan',
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ), // RESPONSIVE
          ),
          SizedBox(height: 12.h), // RESPONSIVE
          _buildSettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifikasi',
            hasSwitch: true,
            onTap: () => _showSnackBar('Notifikasi - Segera Hadir'),
          ),
          _buildSettingsTile(
            icon: Icons.lock_outline,
            title: 'Keamanan & Privasi',
            hasSwitch: false,
            onTap: () => _showSnackBar('Keamanan - Segera Hadir'),
          ),
          _buildSettingsTile(
            icon: Icons.language,
            title: 'Bahasa',
            hasSwitch: false,
            onTap: () => _showSnackBar('Bahasa - Segera Hadir'),
          ),
          _buildSettingsTile(
            icon: Icons.help_outline,
            title: 'Bantuan & Dukungan',
            hasSwitch: false,
            onTap: () => _showSnackBar('Bantuan - Segera Hadir'),
          ),
          _buildSettingsTile(
            icon: Icons.info_outline,
            title: 'Tentang Aplikasi',
            hasSwitch: false,
            onTap: () => _showSnackBar('Tentang - Segera Hadir'),
          ),
          _buildSettingsTile(
            icon: Icons.logout_outlined,
            title: 'Logout',
            hasSwitch: false,
            isLogout: true,
            onTap: () => _showLogoutDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required bool hasSwitch,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r), // RESPONSIVE
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 14.h,
            horizontal: 16.w,
          ), // RESPONSIVE
          margin: EdgeInsets.only(bottom: 4.h), // RESPONSIVE
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r), // RESPONSIVE
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6.r,
                offset: Offset(0, 2.h),
              ),
            ], // RESPONSIVE
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w), // RESPONSIVE
                decoration: BoxDecoration(
                  color: isLogout
                      ? Colors.red.withOpacity(0.15)
                      : const Color(0xFF4A7AB8).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10.r), // RESPONSIVE
                ),
                child: Icon(
                  icon,
                  color: isLogout ? Colors.red : const Color(0xFF4A7AB8),
                  size: 20.sp,
                ), // RESPONSIVE
              ),
              SizedBox(width: 14.w), // RESPONSIVE
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isLogout ? Colors.red : Colors.black,
                  ), // RESPONSIVE
                ),
              ),
              if (hasSwitch)
                Switch(
                  value: false,
                  onChanged: (value) {},
                  activeColor: const Color(0xFF4A7AB8),
                )
              else
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: Colors.grey.shade400,
                ), // RESPONSIVE
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // HELPER METHODS
  // =========================================================================

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins()),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF4A7AB8),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ), // RESPONSIVE
        title: Text(
          'Logout',
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ), // RESPONSIVE
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar dari akun?',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ), // RESPONSIVE
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Batal',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ), // RESPONSIVE
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 12.h,
              ), // RESPONSIVE
            ),
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('Logout Berhasil');
            },
            child: Text(
              'Logout',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// CUSTOM PAINTER UNTUK COVER PATTERN
// =========================================================================

class _CoverPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    // Menggunakan .w untuk responsif
    final double dotSize = 2.0.w;
    final double spacing = 20.0.w;

    for (double y = 0; y < size.height; y += spacing) {
      double startX = (y / spacing).round() % 2 == 0 ? 0 : spacing / 2;
      for (double x = startX; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize / 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
