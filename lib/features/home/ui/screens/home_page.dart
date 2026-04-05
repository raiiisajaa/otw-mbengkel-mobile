import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:otw_mbengkel/core/widgets/bottom_nav.dart';
import 'package:otw_mbengkel/features/booking/ui/screens/booking_page.dart';
import 'package:otw_mbengkel/features/vehicle/ui/screens/kendaraan_page.dart';
import 'package:otw_mbengkel/features/vehicle/ui/screens/tambah_kendaraan_page.dart';
import 'package:otw_mbengkel/features/order/ui/screens/orderan_page.dart';
import 'package:otw_mbengkel/features/profile/ui/screens/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _bannerController;
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  final List<String> _bannerImages = [
    'assets/img/banner_iklan.jpg',
    'assets/img/iklan_biru.png',
  ];

  @override
  void initState() {
    super.initState();
    _bannerController = PageController();
    _startBannerAutoSlide();
  }

  void _startBannerAutoSlide() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentBannerIndex < _bannerImages.length - 1) {
        _currentBannerIndex++;
      } else {
        _currentBannerIndex = 0;
      }
      if (_bannerController.hasClients) {
        _bannerController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
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
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 0,
        onItemTapped: (index) => _handleNavigation(context, index),
      ),

      body: CustomScrollView(
        slivers: [
          // 1. SLIVER APP BAR
          SliverAppBar(
            automaticallyImplyLeading:
                false, // <--- INI KUNCI UNTUK MENGHILANGKAN ICON BACK HITAM
            expandedHeight: 190.h,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6BB1D1), Color(0xFF38639C)],
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30.r),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(painter: PolkaDotPainter()),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
                          child: _buildHeaderInfo(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 2. KONTEN SCROLL BAWAH
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBannerSlider(),
                  SizedBox(height: 24.h),
                  _buildMenuGrid(),
                  SizedBox(height: 20.h),
                  _buildMobilCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER ---

  Widget _buildHeaderInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello,",
              style: GoogleFonts.poppins(
                fontSize: 45.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1,
              ),
            ),
            Text(
              "Dzaky Raihan",
              style: GoogleFonts.poppins(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.2,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "#SiapAmbilAntrianServisHariIni?",
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
            ),
          ],
        ),
        Image.asset(
          'assets/img/logo-otw-b.png',
          width: 90.w,
          height: 85.h,
          fit: BoxFit.contain,
          errorBuilder: (ctx, err, stack) =>
              Icon(Icons.car_repair, color: Colors.white, size: 50.sp),
        ),
      ],
    );
  }

  Widget _buildBannerSlider() {
    return Column(
      children: [
        Container(
          height: 120.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5.h),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: PageView.builder(
              controller: _bannerController,
              onPageChanged: (idx) => setState(() => _currentBannerIndex = idx),
              itemCount: _bannerImages.length,
              itemBuilder: (context, index) => Image.asset(
                _bannerImages[index],
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => Container(
                  color: Colors.grey.shade300,
                  child: const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _bannerImages.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: _currentBannerIndex == index ? 24.w : 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: _currentBannerIndex == index
                    ? const Color(0xFF4A7AB8)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildShadowedBox(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookingPage()),
                );
              },
              borderRadius: BorderRadius.circular(10.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 160.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      image: const DecorationImage(
                        image: AssetImage('assets/img/room_service.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Booking\nServis",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                        Image.asset(
                          'assets/img/logo-otw-b.png',
                          width: 50.w,
                          fit: BoxFit.contain,
                          errorBuilder: (ctx, err, stack) => const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: _buildShadowedBox(
            child: Container(
              padding: EdgeInsets.all(8.w),
              child: Column(
                children: [
                  Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF41BDEB), Color(0xFF004580)],
                      ),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.directions_car,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "antrian anda",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 9.h),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF41BDEB), Color(0xFF004580)],
                        ),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      padding: EdgeInsets.all(10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildQueueText("Antrian:", "-"),
                          SizedBox(height: 6.h),
                          _buildQueueText("Jam:", "-"),
                          const Spacer(),
                          Center(
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobilCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFF6B9BD1), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mobil Anda :",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Detail",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.info_outline, size: 16.sp, color: Colors.black),
                ],
              ),
            ],
          ),
          Divider(height: 20.h, thickness: 1.5, color: const Color(0xFF6B9BD1)),
          SizedBox(height: 40.h),
          Text(
            "Belum ada kendaraan yang di tambahkan",
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 11.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50.h),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TambahKendaraanPage(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(30.r),
              child: Container(
                width: 38.w,
                height: 38.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF4A7AB8),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white, size: 22.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShadowedBox({required Widget child}) {
    return Container(
      height: 170.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildQueueText(String label, String value) {
    return Row(
      children: [
        Text(
          "$label ",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 10.sp),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class PolkaDotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.15);
    final double spacing = 25.w;
    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        double offsetX = (y / spacing).round() % 2 == 0 ? 0 : spacing / 2;
        canvas.drawCircle(Offset(x + offsetX, y), 2.w, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
