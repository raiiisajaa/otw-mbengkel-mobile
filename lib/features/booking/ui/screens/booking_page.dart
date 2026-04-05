import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Wajib untuk ukuran responsif
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// --- IMPORT NAVIGASI ---
import 'package:otw_mbengkel/core/widgets/bottom_nav.dart';
import 'package:otw_mbengkel/features/home/ui/screens/home_page.dart';
import 'package:otw_mbengkel/features/vehicle/ui/screens/kendaraan_page.dart';
import 'package:otw_mbengkel/features/order/ui/screens/orderan_page.dart';
import 'package:otw_mbengkel/features/profile/ui/screens/profile_page.dart';

// Import halaman tambah kendaraan agar bisa diarahkan langsung
import 'package:otw_mbengkel/features/vehicle/ui/screens/tambah_kendaraan_page.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // --- CONTROLLER & DATA ---
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _kmController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // POV: USER BARU (Data kendaraan dikosongkan)
  final List<String> _myVehicles = [];

  final List<String> _serviceTypes = [
    'Servis Ringan',
    'Ganti Oli',
    'Tune Up',
    'Overhaul',
    'Perbaikan Rem',
  ];

  String? _selectedVehicle;
  String? _selectedService;

  @override
  void dispose() {
    _kmController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // --- LOGIKA DATE PICKER ---
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4AC6E5),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat(
          'dd / MM / yyyy, --.--',
        ).format(picked);
      });
    }
  }

  // --- LOGIKA SUBMIT ---
  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      // Validasi khusus untuk user baru yang belum punya kendaraan
      if (_myVehicles.isEmpty || _selectedVehicle == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Silahkan daftarkan kendaraan Anda terlebih dahulu!"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_selectedService == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Mohon lengkapi semua data"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Booking Berhasil Dibuat!"),
          backgroundColor: Color(0xFF7CC576),
        ),
      );
    }
  }

  // --- LOGIKA NAVIGASI ---
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
      case 4:
        break; // Tetap di halaman ini
    }
  }

  // ===========================================================================
  // TAMPILAN UTAMA (UI)
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 4,
        onItemTapped: (index) => _handleNavigation(context, index),
      ),

      // Tidak pakai Stack lagi karena tombol back sudah dihapus, langsung Column
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),

            // --- A. LOGO ---
            Center(
              child: Image.asset(
                'assets/img/logo-otw-b.png',
                height: 65.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.build_circle, size: 55.sp, color: Colors.blue),
              ),
            ),

            SizedBox(height: 5.h),

            // --- B. BANNER BIRU LURUS ---
            Container(
              width: double.infinity,
              height: 55.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4AC6E5), Color(0xFF27A4FB)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(painter: PatternPainter()),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ambil Antrian",
                            style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          Text(
                            "Silahkan Buat Jadwal servis anda",
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- C. FORM CARD PUTIH ---
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Container(
                  padding: EdgeInsets.all(20.w),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ---------------------------------------------------
                        // LOGIKA UI KENDARAAN: KOSONG VS ADA ISINYA
                        // ---------------------------------------------------
                        _buildLabel("Pilih kendaraan anda"),

                        if (_myVehicles.isEmpty)
                          _buildEmptyVehicleAction() // Peringatan jika kendaraan kosong
                        else
                          _buildDropdownField(
                            // Dropdown normal jika kendaraan ada
                            hint: "-- Pilih kendaraan anda --",
                            value: _selectedVehicle,
                            items: _myVehicles,
                            onChanged: (val) =>
                                setState(() => _selectedVehicle = val),
                          ),

                        // ---------------------------------------------------
                        SizedBox(height: 16.h),

                        _buildLabel("Pilih jenis servis"),
                        _buildDropdownField(
                          hint: "-- Pilih Jenis Servis --",
                          value: _selectedService,
                          items: _serviceTypes,
                          onChanged: (val) =>
                              setState(() => _selectedService = val),
                        ),

                        SizedBox(height: 16.h),

                        _buildLabel("Pilih jarak KM MOBIL"),
                        _buildTextField(
                          controller: _kmController,
                          hint: "Masukkan jarak KM saat ini (contoh : 45000)",
                          isNumber: true,
                        ),

                        SizedBox(height: 16.h),

                        _buildLabel("Pilih tanggal dan waktu"),
                        _buildTextField(
                          controller: _dateController,
                          hint: "hh / bb / tttt, --.--",
                          isReadOnly: true,
                          icon: Icons.calendar_today_outlined,
                          onTap: () => _selectDate(context),
                        ),

                        SizedBox(height: 16.h),

                        _buildLabel("Catatan Tambahan (opsional)"),
                        _buildTextField(
                          controller: _notesController,
                          hint:
                              "Deskripsikan sedikit masalah Anda atau permintaan khusus.",
                          maxLines: 4,
                        ),

                        SizedBox(height: 24.h),

                        // TOMBOL SUBMIT (HIJAU)
                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7CC576),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              elevation: 0,
                            ),
                            onPressed: _submitBooking,
                            child: Text(
                              "Konfirmasi Ambil Antrian",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
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
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // WIDGET HELPER
  // ===========================================================================

  /// WIDGET BARU: Peringatan jika belum ada kendaraan
  Widget _buildEmptyVehicleAction() {
    return InkWell(
      onTap: () {
        // Arahkan user ke halaman tambah kendaraan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TambahKendaraanPage()),
        );
      },
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F8FF), // Latar biru sangat muda
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: const Color(0xFF4AC6E5),
          ), // Border biru tema kita
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: const Color(0xFF27A4FB),
              size: 20.sp,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                "Belum ada kendaraan. Klik di sini untuk mendaftar.",
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  color: const Color(0xFF27A4FB),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xFF27A4FB),
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(
            hint,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: Colors.grey.shade600,
            ),
          ),
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey.shade600,
            size: 14.sp,
          ),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Colors.black87,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool isNumber = false,
    bool isReadOnly = false,
    int maxLines = 1,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: isReadOnly,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        onTap: onTap,
        style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Colors.grey.shade600,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          border: InputBorder.none,
          suffixIcon: icon != null
              ? Icon(icon, size: 18.sp, color: Colors.grey.shade600)
              : (isReadOnly
                    ? null
                    : Icon(
                        Icons.arrow_forward_ios,
                        size: 14.sp,
                        color: Colors.grey.shade600,
                      )),
        ),
        validator: (val) {
          if (!hint.contains("opsional") && (val == null || val.isEmpty)) {
            return "Wajib diisi";
          }
          return null;
        },
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
    final double spacing = 20.w;

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
