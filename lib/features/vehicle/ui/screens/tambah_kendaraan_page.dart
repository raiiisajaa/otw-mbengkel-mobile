import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TambahKendaraanPage extends StatefulWidget {
  const TambahKendaraanPage({super.key});

  @override
  State<TambahKendaraanPage> createState() => _TambahKendaraanPageState();
}

class _TambahKendaraanPageState extends State<TambahKendaraanPage> {
  // ==========================================
  // 1. VARIABEL & CONTROLLER
  // ==========================================
  final _formKey = GlobalKey<FormState>();

  // Controller untuk input text
  final TextEditingController _nopolController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  @override
  void dispose() {
    // Bersihkan memori
    _nopolController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  // ==========================================
  // 2. TAMPILAN UTAMA (UI)
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Background abu muda
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- A. TOP BAR (Tombol Back & Logo) ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 1. Tombol Kembali (Kotak Putih Modif)
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12), // Sudut tumpul
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                    // 2. Logo (Kanan)
                    Image.asset(
                      'assets/img/logo-otw-b 2.png', // Pastikan aset ada
                      width: 101, // Sesuai Request
                      height: 57, // Sesuai Request
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),

              // --- B. HEADER BIRU (GRADASI & PATTERN) ---
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4AC6E5), Color(0xFF27A4FB)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Stack(
                  children: [
                    // Pattern Titik-titik
                    Positioned.fill(
                      child: CustomPaint(painter: PatternPainter()),
                    ),

                    // Teks Judul
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Text(
                        "Daftar Kendaraan Anda",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- C. FORMULIR ISIAN ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    // Shadow Form
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. NOMOR POLISI
                        _buildLabel("Nomor Polisi"),
                        _buildTextField(
                          controller: _nopolController,
                          hint:
                              "Nomor Polisi harus sesuai dengan data di STNK anda*",
                        ),
                        const SizedBox(height: 15),

                        // 2. MODEL MOBIL
                        _buildLabel("Model/Tipe Mobil"),
                        _buildTextField(
                          controller: _modelController,
                          hint: "Contoh : Honda Jazz atau Toyota Avanza",
                        ),
                        const SizedBox(height: 15),

                        // 3. TAHUN (Opsional)
                        _buildLabel("Tahun kendaraan (Opsional)"),
                        _buildTextField(
                          controller: _yearController,
                          hint: "Contoh : 2025",
                          inputType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),

                        // 4. WARNA (Opsional)
                        _buildLabel("Warna kendaraan (Opsional)"),
                        _buildTextField(
                          controller: _colorController,
                          hint: "Contoh : Hitam Metalik",
                        ),

                        const SizedBox(height: 30),

                        // TOMBOL SIMPAN
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7CC576), // Hijau
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Logic Simpan Disini
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Kendaraan Berhasil Disimpan!",
                                    ),
                                  ),
                                );
                                Navigator.pop(
                                  context,
                                ); // Kembali setelah simpan
                              }
                            },
                            child: Text(
                              "Simpan Kendaraan",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // --- D. FOOTER TEXT ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Data anda aman dan hanya digunakan untuk kepentingan di OTW MBENGKEL",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 3. WIDGET KECIL (HELPER)
  // ==========================================

  // Label Judul Input (Bold 12)
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    );
  }

  // Input Field (Regular 10) + Shadow Container
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300), // Border tipis abu
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        style: GoogleFonts.poppins(fontSize: 10), // Font input uk 10
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none, // Hilangkan border default input
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        validator: (val) {
          // Validasi hanya untuk yang tidak ada tulisan (Opsional)
          if (!hint.contains("Opsional") &&
              !hint.contains("Contoh : 2025") &&
              (val == null || val.isEmpty)) {
            // Logic sederhana: cek apakah label (di parent) mengandung kata Opsional
            // Karena di sini kita cuma punya hint, kita asumsikan Nopol & Model wajib
            if (controller == _nopolController ||
                controller == _modelController) {
              return "Wajib diisi";
            }
          }
          return null;
        },
      ),
    );
  }
}

// ==========================================
// 4. PAINTER (EFEK POLKADOT)
// ==========================================
class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      // ignore: deprecated_member_use
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    const double spacing = 15.0;

    for (double y = 0; y < size.height; y += spacing) {
      double startX = (y / spacing).round() % 2 == 0 ? 0 : spacing / 2;
      for (double x = startX; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), 1.0, paint); // Dot size kecil
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
