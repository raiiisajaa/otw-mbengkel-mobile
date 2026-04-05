import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Helper class untuk menangani responsive design
/// Memudahkan adaptasi layout untuk berbagai ukuran layar
class ResponsiveHelper {
  /// Mendapatkan lebar layar
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Mendapatkan tinggi layar
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Cek apakah device adalah mobile (< 600px)
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  }

  /// Cek apakah device adalah tablet (600px - 1200px)
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.mobileBreakpoint &&
        width < AppConstants.tabletBreakpoint;
  }

  /// Cek apakah device adalah desktop (> 1200px)
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;
  }

  /// Mendapatkan device type (MOBILE, TABLET, DESKTOP)
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppConstants.mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width < AppConstants.tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Responsive font size berdasarkan ukuran layar
  static double responsiveFontSize(
    BuildContext context, {
    required double mobileSize,
    double? tabletSize,
    double? desktopSize,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppConstants.mobileBreakpoint) {
      return mobileSize;
    } else if (width < AppConstants.tabletBreakpoint) {
      return tabletSize ?? mobileSize * 1.2;
    } else {
      return desktopSize ?? mobileSize * 1.4;
    }
  }

  /// Responsive padding berdasarkan ukuran layar
  static double responsivePadding(
    BuildContext context, {
    required double mobilePadding,
    double? tabletPadding,
    double? desktopPadding,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppConstants.mobileBreakpoint) {
      return mobilePadding;
    } else if (width < AppConstants.tabletBreakpoint) {
      return tabletPadding ?? mobilePadding * 1.25;
    } else {
      return desktopPadding ?? mobilePadding * 1.5;
    }
  }

  /// Responsive width berdasarkan percentage layar
  static double responsiveWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  /// Responsive height berdasarkan percentage layar
  static double responsiveHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }
}

/// Enum untuk tipe device
enum DeviceType { mobile, tablet, desktop }
