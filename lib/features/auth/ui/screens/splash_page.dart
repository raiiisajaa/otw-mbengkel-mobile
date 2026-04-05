import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/asset_paths.dart';
import 'onboarding_page.dart';

/// ============================================================================
/// SPLASH PAGE - Halaman Pembuka Aplikasi
/// ============================================================================
///
/// ANIMASI SEDERHANA:
/// - Logo muncul dengan fade in (lembut)
/// - Sedikit efek scale (membesar tipis)
/// - Tidak ada efek berlebihan
/// - Background gradient statis (lebih kalem)
/// - Durasi 2.5 detik
///
/// ============================================================================

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  // =========================================================================
  // ANIMATION CONTROLLER (SEDERHANA)
  // =========================================================================

  /// Satu controller untuk semua animasi
  late AnimationController _controller;

  /// Animasi fade in (0 → 1)
  late Animation<double> _fadeAnimation;

  /// Animasi scale (0.8 → 1.0) - sedikit membesar
  late Animation<double> _scaleAnimation;

  // =========================================================================
  // LIFECYCLE
  // =========================================================================

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToNextPage();
  }

  @override
  void dispose() {
    _controller.dispose(); // Bersihkan controller
    super.dispose();
  }

  // =========================================================================
  // SETUP ANIMASI (SEDERHANA)
  // =========================================================================

  /// Setup animasi - simple dan smooth
  void _setupAnimations() {
    // Controller dengan durasi 1.5 detik
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    // 1. FADE IN - muncul perlahan
    _fadeAnimation =
        Tween<double>(
          begin: 0.0, // Transparan
          end: 1.0, // Solid
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeIn, // Smooth easing
          ),
        );

    // 2. SCALE - sedikit membesar (efek subtle)
    _scaleAnimation =
        Tween<double>(
          begin: 0.85, // Mulai 85% ukuran
          end: 1.0, // Akhir 100% ukuran
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutBack, // Efek sedikit "kenyal" tapi halus
          ),
        );

    // Jalankan animasi
    _controller.forward();
  }

  // =========================================================================
  // NAVIGASI
  // =========================================================================

  /// Pindah ke halaman onboarding setelah 2.5 detik
  void _navigateToNextPage() {
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OnboardingPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  // Fade transition yang smooth
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  // =========================================================================
  // BUILD
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Background gradient yang elegan
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A7AB8), // Biru lebih tua
              Color(0xFF64A1F4), // Biru lebih muda
            ],
          ),
        ),
        child: Stack(
          children: [
            // Pattern halus di background (opsional)
            _buildBackgroundPattern(),

            // Logo dengan animasi
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: _buildLogo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // UI COMPONENTS
  // =========================================================================

  /// Logo dengan ukuran fixed tapi tetap proporsional
  Widget _buildLogo() {
    return Container(
      width: 180,
      height: 180,
      padding: const EdgeInsets.all(16),
      child: Image.asset(
        AssetPaths.logoOtw,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Fallback jika logo tidak ditemukan
          return Icon(
            Icons.car_repair,
            size: 100,
            color: Colors.white.withOpacity(0.8),
          );
        },
      ),
    );
  }

  /// Pattern titik-titik halus di background (opsional)
  Widget _buildBackgroundPattern() {
    return Positioned.fill(
      child: CustomPaint(painter: _SplashPatternPainter()),
    );
  }
}

// ===========================================================================
// CUSTOM PAINTER - PATTERN HALUS
// ===========================================================================

/// Membuat pola titik-titik halus di background
class _SplashPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
          .withOpacity(0.03) // Sangat tipis
      ..style = PaintingStyle.fill;

    const double dotSize = 2.0;
    const double spacing = 30.0;

    // Gambar titik-titik dengan pola grid
    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize / 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ===========================================================================
// VERSI ALTERNATIF YANG LEBIH MINIMALIS
// ===========================================================================

/*
/// SPLASH PAGE VERSION 2 - SUPER MINIMAL
/// Hanya fade in tanpa scale
class SplashPageMinimal extends StatefulWidget {
  const SplashPageMinimal({super.key});

  @override
  State<SplashPageMinimal> createState() => _SplashPageMinimalState();
}

class _SplashPageMinimalState extends State<SplashPageMinimal> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A7AB8),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Image.asset(
            AssetPaths.logoOtw,
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
*/

// ===========================================================================
// TIPS: CARA MENYESUAIKAN ANIMASI
// ===========================================================================

/*
| Parameter        | Nilai Saat Ini | Keterangan                                  |
|------------------|----------------|---------------------------------------------|
| Durasi Animasi   | 1500 ms        | Semakin besar => semakin lambat             |
| Fade Start       | 0.0            | 0 = transparan, 1 = solid                   |
| Scale Start      | 0.85           | 0.5 = setengah ukuran, 1 = ukuran normal    |
| Navigasi Delay   | 2500 ms        | Waktu sebelum pindah halaman                |
| Kurva Fade       | Curves.easeIn  | easeIn = smooth mulai                       |
| Kurva Scale      | easeOutBack    | efek sedikit kenyal tapi halus               |

CARA MENGUBAH:
1. Untuk animasi lebih lambat: 
   - duration: const Duration(milliseconds: 2000)
   
2. Untuk scale lebih besar: 
   - begin: 0.5 (mulai dari setengah ukuran)
   
3. Untuk tanpa scale:
   - Hapus Transform.scale, hanya pakai Opacity
   
4. Untuk background putih:
   - Ganti gradient dengan Colors.white
*/
