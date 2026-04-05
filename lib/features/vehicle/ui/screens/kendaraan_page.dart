import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// --- IMPORT NAVIGASI ---
import 'package:otw_mbengkel/core/widgets/bottom_nav.dart';
import 'package:otw_mbengkel/features/home/ui/screens/home_page.dart';
import 'package:otw_mbengkel/features/booking/ui/screens/booking_page.dart';
import 'package:otw_mbengkel/features/vehicle/ui/screens/tambah_kendaraan_page.dart';
import 'package:otw_mbengkel/features/order/ui/screens/orderan_page.dart';
import 'package:otw_mbengkel/features/profile/ui/screens/profile_page.dart';

class KendaraanPage extends StatefulWidget {
  const KendaraanPage({super.key});

  @override
  State<KendaraanPage> createState() => _KendaraanPageState();
}

class _KendaraanPageState extends State<KendaraanPage> {
  // --- DATA KENDARAAN ---
  // Dibiarkan kosong [] agar menampilkan Empty State (seperti di gambar)
  final List<Map<String, String>> _vehicles = [];

  // --- LOGIKA NAVIGASI NAVBAR ---
  void _handleNavigation(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OrderanPage()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BookingPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF5F5F5,
      ), // Sesuai warna background abu sangat muda
      // 1. BOTTOM NAVBAR
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1, // Kunci di index Kendaraan
        onItemTapped: _handleNavigation,
      ),

      // 2. TOMBOL TAMBAH (FAB)
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 100.h), // Jarak dari navbar
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TambahKendaraanPage(),
              ),
            );
          },
          backgroundColor: const Color(
            0xFF2C568D,
          ), // Warna biru tua seperti di gambar
          elevation: 4,
          shape: const CircleBorder(), // Memastikan bentuknya bulat sempurna
          child: Icon(Icons.add, color: Colors.white, size: 32.sp),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      // 3. KONTEN HALAMAN
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h), // Spasi dari ujung atas HP
            // --- A. LOGO OTW MBENGKEL ---
            Center(
              child: Image.asset(
                'assets/img/logo-otw-b.png', // Pastikan nama file sesuai
                height: 65.h, // Tinggi logo responsif
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.build_circle,
                  size: 65.sp,
                  color: Colors.blue,
                ), // Fallback
              ),
            ),

            SizedBox(height: 15.h), // Jarak antara logo dan banner biru
            // --- B. BANNER HEADER BIRU ---
            // Bentuknya lurus, tidak ada lengkungan, dengan pattern
            Container(
              width: double.infinity,
              height: 55.h, // Tinggi banner
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4AC6E5), Color(0xFF27A4FB)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Stack(
                children: [
                  // Pattern Titik-titik transparan
                  Positioned.fill(
                    child: CustomPaint(painter: PatternPainter()),
                  ),
                  // Teks "Kendaraan Anda"
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        "Kendaraan Anda",
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

            // --- C. ISI KONTEN (Tengah Layar) ---
            Expanded(
              child: _vehicles.isEmpty
                  ? _buildEmptyState() // Jika list kosong (sesuai gambar)
                  : _buildVehicleList(), // Jika ada isinya
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // WIDGET HELPER
  // ===========================================================================

  /// Tampilan Empty State (Sesuai Gambar 4)
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Text(
          "Silahkan daftar kendaraan anda terlebih dahulu",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.grey.shade600, // Warna abu-abu teks
            fontSize: 13.sp, // Ukuran font minimalis
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  /// Tampilan Jika List Kendaraan Ada (Disembunyikan sementara)
  Widget _buildVehicleList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      itemCount: _vehicles.length,
      itemBuilder: (context, index) {
        final car = _vehicles[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF4AC6E5).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.directions_car_filled,
                  color: const Color(0xFF4AC6E5),
                  size: 30.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car['name']!,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      car['plat']!,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ===========================================================================
// PAINTER: PATTERN TITIK-TITIK
// ===========================================================================
// Membuat efek titik putih transparan untuk banner biru
class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.15);
    final double spacing = 20.w;

    // Logika menggambar titik selang-seling
    for (double y = 0; y < size.height; y += spacing) {
      double startX = (y / spacing).round() % 2 == 0 ? 0 : spacing / 2;
      for (double x = startX; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5.w, paint); // Ukuran titik
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
