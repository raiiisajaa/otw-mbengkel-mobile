import 'package:flutter/material.dart';

/// ============================================================================
/// SIMPLE RESPONSIVE HELPER
/// ============================================================================
/// Helper sederhana untuk membuat UI tetap konsisten di berbagai device
/// Tidak perlu refactor semua kode, cukup gunakan untuk element bermasalah
/// ============================================================================

class R {
  // Singleton
  static final R _instance = R._internal();
  factory R() => _instance;
  R._internal();

  /// DESIGN BASE - iPhone 13 (ukuran design di Figma)
  static const double _designWidth = 390.0; // iPhone 13 width
  static const double _designHeight = 844.0; // iPhone 13 height

  /// Current screen info
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _scaleW;
  static late double _scaleH;

  /// WAJIB: Init di setiap halaman (di build method paling atas)
  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
    _scaleW = _screenWidth / _designWidth;
    _scaleH = _screenHeight / _designHeight;
  }

  /// Get responsive width
  static double w(double width) => width * _scaleW;

  /// Get responsive height
  static double h(double height) => height * _scaleH;

  /// Get responsive font size
  static double sp(double fontSize) => fontSize * _scaleW;
}

/// ============================================================================
/// EXTENSION untuk penggunaan yang lebih mudah
/// ============================================================================
/// Contoh: 16.w, 20.h, 14.sp
/// ============================================================================

extension ResponsiveNum on num {
  double get w => R.w(toDouble());
  double get h => R.h(toDouble());
  double get sp => R.sp(toDouble());
}
