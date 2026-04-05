import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/asset_paths.dart';
import 'login_page.dart';
import 'register_page.dart';

class AuthSelectionPage extends StatefulWidget {
  const AuthSelectionPage({super.key});

  @override
  State<AuthSelectionPage> createState() => _AuthSelectionPageState();
}

class _AuthSelectionPageState extends State<AuthSelectionPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache images to avoid visible loading on first display
    precacheImage(const AssetImage(AssetPaths.carGtr), context);
    precacheImage(const AssetImage(AssetPaths.logoOtw), context);
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle whiteButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      minimumSize: const Size(double.infinity, 55),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0,
    );

    final ButtonStyle blackButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 55),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 11,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        AssetPaths.carGtr,
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                        frameBuilder: (context, child, frame, wasSync) {
                          if (wasSync) return child;
                          return AnimatedOpacity(
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                            child: child,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 60,
                      child: Image.asset(AssetPaths.logoOtw, width: 180),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 8),
            ],
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF64A1F4), Color(0xFF192F72)],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Text(
                    'Selamat Datang',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Mulai perjalananmu bersama SERVIZIO. Dari booking servis, cek sparepart, sampai update status kendaraan, semua bisa kamu lakukan langsung dari genggaman.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(179, 255, 255, 255),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),

                  ElevatedButton(
                    style: whiteButton,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    ),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton(
                    style: blackButton,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    ),
                    child: const Text(
                      'Buat Akun',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
