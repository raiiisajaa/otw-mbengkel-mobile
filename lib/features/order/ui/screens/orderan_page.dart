import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Wajib untuk ukuran responsif
import 'package:google_fonts/google_fonts.dart';

// --- IMPORT NAVIGASI ---
import 'package:otw_mbengkel/core/widgets/bottom_nav.dart';
import 'package:otw_mbengkel/features/home/ui/screens/home_page.dart';
import 'package:otw_mbengkel/features/booking/ui/screens/booking_page.dart';
import 'package:otw_mbengkel/features/vehicle/ui/screens/kendaraan_page.dart';
import 'package:otw_mbengkel/features/profile/ui/screens/profile_page.dart';

class OrderanPage extends StatefulWidget {
  const OrderanPage({super.key});

  @override
  State<OrderanPage> createState() => _OrderanPageState();
}

class _OrderanPageState extends State<OrderanPage> {
  // --- LOGIKA NAVIGASI NAVBAR ---
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
        // Sudah di halaman Orderan, tidak perlu aksi
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
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
    // CATATAN: R.init(context) DIHAPUS karena kita sudah pakai ScreenUtilInit di main.dart

    return Scaffold(
      backgroundColor: const Color(
        0xFFF5F5F5,
      ), // Warna background seragam dengan KendaraanPage
      // 1. BOTTOM NAVBAR FIXED
      // Tidak perlu pakai Stack lagi, posisinya otomatis terkunci di bawah
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2, // Highlight untuk icon Orderan
        onItemTapped: (index) => _handleNavigation(context, index),
      ),

      // 2. KONTEN HALAMAN UTAMA
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h), // Spasi atas agar proporsional
            // --- A. LOGO OTW MBENGKEL ---
            Center(
              child: Image.asset(
                // Menggunakan file logo yang sama agar ukurannya konsisten
                'assets/img/logo-otw-b.png',
                height: 65.h, // Tinggi logo responsif
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.build_circle,
                  size: 65.sp,
                  color: Colors.blue,
                ), // Fallback
              ),
            ),

            SizedBox(height: 15.h),

            // --- B. BANNER HEADER BIRU ---
            Container(
              width: double.infinity,
              height: 55.h, // Tinggi responsif
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4AC6E5), Color(0xFF27A4FB)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Stack(
                children: [
                  // Efek titik-titik transparan
                  Positioned.fill(
                    child: CustomPaint(painter: PatternPainter()),
                  ),
                  // Teks Judul
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        "Orderan Saya",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- C. KONTEN (TAMPILAN KOSONG / EMPTY STATE) ---
            // Menggunakan Expanded agar posisinya otomatis di tengah sisa layar
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list_alt_outlined,
                      size: 80
                          .sp, // Ukuran disamakan dengan ikon mobil di halaman sebelah
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Belum ada riwayat Orderan",
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Booking servis untuk melihat orderan Anda",
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade400,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 40.h), // Jarak aman ke navbar
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// PAINTER: PATTERN TITIK-TITIK
// ===========================================================================
class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.15);
    final double spacing = 20.w; // Jarak titik responsif

    for (double y = 0; y < size.height; y += spacing) {
      double startX = (y / spacing).round() % 2 == 0 ? 0 : spacing / 2;
      for (double x = startX; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5.w, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
