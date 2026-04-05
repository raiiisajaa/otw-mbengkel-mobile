import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Konfigurasi ukuran responsif untuk aplikasi
/// Membantu menstandarisasi ukuran elemen di berbagai device
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late bool isPortrait;
  static late bool isMobilePortrait;
  static late bool isMobileLandscape;
  static late bool isTabletPortrait;
  static late bool isTabletLandscape;

  /// Inisialisasi SizeConfig
  /// Panggil method ini di main() sebelum runApp()
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    // Hitung ukuran blok (untuk grid layout)
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    // Multiplier untuk text dan image
    textMultiplier = blockSizeVertical;
    imageSizeMultiplier = blockSizeHorizontal;

    // Orientasi
    isPortrait = _mediaQueryData.orientation == Orientation.portrait;
    isMobilePortrait =
        isPortrait && screenWidth < AppConstants.mobileBreakpoint;
    isMobileLandscape =
        !isPortrait && screenWidth < AppConstants.mobileBreakpoint;
    isTabletPortrait =
        isPortrait &&
        screenWidth >= AppConstants.mobileBreakpoint &&
        screenWidth < AppConstants.tabletBreakpoint;
    isTabletLandscape =
        !isPortrait &&
        screenWidth >= AppConstants.mobileBreakpoint &&
        screenWidth < AppConstants.tabletBreakpoint;
  }
}
