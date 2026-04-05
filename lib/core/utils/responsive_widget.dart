import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Widget builder untuk responsive design yang mudah digunakan
/// Menggabungkan MediaQuery dan LayoutBuilder
class ResponsiveWidget extends StatelessWidget {
  final Widget Function(BuildContext context, double width) builder;

  const ResponsiveWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(context, constraints.maxWidth);
      },
    );
  }
}

/// Mixin untuk helper method responsive design
mixin ResponsiveMixin {
  /// Cek apakah mobile
  bool isMobile(double width) => width < AppConstants.mobileBreakpoint;

  /// Cek apakah tablet
  bool isTablet(double width) =>
      width >= AppConstants.mobileBreakpoint &&
      width < AppConstants.tabletBreakpoint;

  /// Cek apakah desktop
  bool isDesktop(double width) => width >= AppConstants.tabletBreakpoint;

  /// Get responsive padding
  double getResponsivePadding(double width) {
    if (isMobile(width)) return AppConstants.paddingNormal; // 16
    if (isTablet(width)) return AppConstants.paddingMedium; // 24
    return AppConstants.paddingLarge; // 32
  }

  /// Get responsive font size
  double getResponsiveFontSize(
    double width, {
    required double mobileSize,
    double? tabletSize,
    double? desktopSize,
  }) {
    if (isMobile(width)) return mobileSize;
    if (isTablet(width)) return tabletSize ?? mobileSize * 1.1;
    return desktopSize ?? mobileSize * 1.25;
  }

  /// Get responsive height
  double getResponsiveHeight(
    double width, {
    required double mobileHeight,
    double? tabletHeight,
    double? desktopHeight,
  }) {
    if (isMobile(width)) return mobileHeight;
    if (isTablet(width)) return tabletHeight ?? mobileHeight * 1.1;
    return desktopHeight ?? mobileHeight * 1.2;
  }
}
