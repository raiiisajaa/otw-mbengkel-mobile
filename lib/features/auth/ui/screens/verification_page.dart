import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import ini untuk input number only
import 'package:otw_mbengkel/features/auth/ui/screens/login_page.dart';
import 'verification_success_page.dart';
// Pastikan import widget kamu sudah benar

class VerificationPage extends StatefulWidget {
  final bool isFromRegister;
  const VerificationPage({super.key, this.isFromRegister = false});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  int _start = 60;
  Timer? _timer;
  bool _isButtonDisabled = true;

  // 1. Tambahkan Controller dan FocusNode untuk 4 kotak
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _isButtonDisabled = true;
    _start = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        if (mounted) {
          setState(() {
            _isButtonDisabled = false;
            _timer?.cancel();
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _start--;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    // 2. Wajib dispose controller & focus node agar memori tidak bocor
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String timerText = "00:${_start.toString().padLeft(2, '0')}";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios, size: 20),
              ),

              const SizedBox(height: 24),

              // LOGIC TEXT DINAMIS SESUAI PARAMETER
              Text(
                widget.isFromRegister
                    ? "Verifikasi Pendaftaran"
                    : "Verifikasi Masuk",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _isButtonDisabled
                    ? "Mohon tunggu $timerText untuk mengirim ulang kode."
                    : "Anda sekarang bisa meminta kode baru.",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 32),

              /// 3. OTP BOX YANG BENAR (Ada TextField-nya)
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // Gunakan spaceEvenly agar rapi
                children: List.generate(4, (index) => _buildOtpBox(index)),
              ),

              const Expanded(child: SizedBox()),

              Center(
                child: TextButton(
                  onPressed: _isButtonDisabled
                      ? null
                      : () {
                          startTimer();
                          debugPrint("OTP dikirim ulang");
                        },
                  child: Text(
                    "Kirim Ulang",
                    style: TextStyle(
                      color: _isButtonDisabled ? Colors.grey : Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              PrimaryButton(
                text: "Konfirmasi",
                onPressed: () {
                  // Gabungkan 4 input menjadi satu string
                  String code = _controllers.map((e) => e.text).join();
                  debugPrint("Kode OTP: $code");

                  // Logic Cek Validasi
                  if (code.length < 4) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Kode harus 4 digit")),
                    );
                  } else {
                    // PERBAIKAN DI SINI: Navigasi ke Halaman Sukses
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerificationSuccessPage(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // 4. Widget Builder Khusus Kotak OTP
  Widget _buildOtpBox(int index) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          // Sedikit bayangan agar terlihat timbul
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1), // Batasi cuma 1 angka
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            border: InputBorder.none, // Hilangkan garis bawah default TextField
            contentPadding: EdgeInsets.zero,
            counterText: "", // Hilangkan counter karakter
          ),
          onChanged: (value) {
            // LOGIC PINDAH FOKUS (AUTO-FOCUS)
            if (value.isNotEmpty) {
              // Jika diisi, pindah ke kanan (jika bukan kotak terakhir)
              if (index < 3) {
                _focusNodes[index + 1].requestFocus();
              } else {
                // Jika kotak terakhir, tutup keyboard
                FocusScope.of(context).unfocus();
              }
            } else {
              // Jika dihapus, pindah ke kiri (jika bukan kotak pertama)
              if (index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
            }
          },
        ),
      ),
    );
  }
}
