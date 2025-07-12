import 'package:flutter/material.dart';

/// Screen size breakpoints for responsive design
class ScreenBreakpoints {
  /// Extra small devices (phones)
  static const double xs = 576;

  /// Small devices (portrait tablets and large phones)
  static const double sm = 768;

  /// Medium devices (landscape tablets)
  static const double md = 992;

  /// Large devices (desktops)
  static const double lg = 1200;

  /// Extra large devices (large desktops)
  static const double xl = 1400;
}

/// Screen size utility class
class ScreenSizeHelper {
  /// Get screen width
  static double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  /// Get screen height
  static double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  /// Get screen size
  static Size getScreenSize(BuildContext context) => MediaQuery.of(context).size;

  /// Get device pixel ratio
  static double getPixelRatio(BuildContext context) => MediaQuery.of(context).devicePixelRatio;

  /// Get status bar height
  static double getStatusBarHeight(BuildContext context) => MediaQuery.of(context).padding.top;

  /// Get bottom safe area height
  static double getBottomSafeAreaHeight(BuildContext context) => MediaQuery.of(context).padding.bottom;

  /// Check if device is mobile (xs)
  static bool isMobile(BuildContext context) => getScreenWidth(context) < ScreenBreakpoints.xs;

  /// Check if device is small (sm)
  static bool isSmall(BuildContext context) => getScreenWidth(context) >= ScreenBreakpoints.xs && getScreenWidth(context) < ScreenBreakpoints.sm;

  /// Check if device is medium (md)
  static bool isMedium(BuildContext context) => getScreenWidth(context) >= ScreenBreakpoints.sm && getScreenWidth(context) < ScreenBreakpoints.md;

  /// Check if device is large (lg)
  static bool isLarge(BuildContext context) => getScreenWidth(context) >= ScreenBreakpoints.md && getScreenWidth(context) < ScreenBreakpoints.lg;

  /// Check if device is extra large (xl)
  static bool isExtraLarge(BuildContext context) => getScreenWidth(context) >= ScreenBreakpoints.lg;

  /// Check if device is tablet size or larger
  static bool isTabletOrLarger(BuildContext context) => getScreenWidth(context) >= ScreenBreakpoints.sm;

  /// Check if device is desktop size or larger
  static bool isDesktopOrLarger(BuildContext context) {
    return getScreenWidth(context) >= ScreenBreakpoints.md;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Get responsive value based on screen size
  static T getResponsiveValue<T>(BuildContext context, {required T mobile, T? tablet, T? desktop}) {
    if (isDesktopOrLarger(context) && desktop != null) {
      return desktop;
    } else if (isTabletOrLarger(context) && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }

  /// Get responsive padding
  static EdgeInsets getResponsivePadding(BuildContext context, {EdgeInsets? mobile, EdgeInsets? tablet, EdgeInsets? desktop}) {
    return getResponsiveValue(
      context,
      mobile: mobile ?? const EdgeInsets.all(16.0),
      tablet: tablet ?? const EdgeInsets.all(24.0),
      desktop: desktop ?? const EdgeInsets.all(32.0),
    );
  }

  /// Get responsive margin
  static EdgeInsets getResponsiveMargin(BuildContext context, {EdgeInsets? mobile, EdgeInsets? tablet, EdgeInsets? desktop}) {
    return getResponsiveValue(
      context,
      mobile: mobile ?? const EdgeInsets.all(8.0),
      tablet: tablet ?? const EdgeInsets.all(16.0),
      desktop: desktop ?? const EdgeInsets.all(24.0),
    );
  }

  /// Get responsive font size
  static double getResponsiveFontSize(BuildContext context, {double? mobile, double? tablet, double? desktop}) {
    return getResponsiveValue(context, mobile: mobile ?? 14.0, tablet: tablet ?? 16.0, desktop: desktop ?? 18.0);
  }

  /// Get responsive grid columns
  static int getResponsiveColumns(BuildContext context, {int? mobile, int? tablet, int? desktop}) {
    return getResponsiveValue(context, mobile: mobile ?? 1, tablet: tablet ?? 2, desktop: desktop ?? 3);
  }

  /// Get responsive container width
  static double getResponsiveContainerWidth(BuildContext context, {double? mobile, double? tablet, double? desktop}) {
    return getResponsiveValue(
      context,
      mobile: mobile ?? getScreenWidth(context) * 0.95,
      tablet: tablet ?? getScreenWidth(context) * 0.8,
      desktop: desktop ?? getScreenWidth(context) * 0.6,
    );
  }

  /// Get responsive height factor
  static double getResponsiveHeightFactor(BuildContext context, {double? mobile, double? tablet, double? desktop}) {
    return getResponsiveValue(context, mobile: mobile ?? 0.8, tablet: tablet ?? 0.7, desktop: desktop ?? 0.6);
  }

  /// Get screen size category as string
  static String getScreenSizeCategory(BuildContext context) {
    if (isMobile(context)) return 'mobile';
    if (isSmall(context)) return 'small';
    if (isMedium(context)) return 'medium';
    if (isLarge(context)) return 'large';
    return 'extra_large';
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get view padding (includes keyboard)
  static EdgeInsets getViewPadding(BuildContext context) {
    return MediaQuery.of(context).viewPadding;
  }

  /// Get keyboard height
  static double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  /// Check if keyboard is visible
  static bool isKeyboardVisible(BuildContext context) {
    return getKeyboardHeight(context) > 0;
  }
}

/// MediaQuery extension for easier access
extension MediaQueryExtension on BuildContext {
  /// Get MediaQuery data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen width
  double get screenWidth => mediaQuery.size.width;

  /// Get screen height
  double get screenHeight => mediaQuery.size.height;

  /// Get screen size
  Size get screenSize => mediaQuery.size;

  /// Get device pixel ratio
  double get pixelRatio => mediaQuery.devicePixelRatio;

  /// Get status bar height
  double get statusBarHeight => mediaQuery.padding.top;

  /// Get bottom safe area height
  double get bottomSafeAreaHeight => mediaQuery.padding.bottom;

  /// Check if device is mobile
  bool get isMobile => screenWidth < ScreenBreakpoints.xs;

  /// Check if device is small
  bool get isSmall => screenWidth >= ScreenBreakpoints.xs && screenWidth < ScreenBreakpoints.sm;

  /// Check if device is medium
  bool get isMedium => screenWidth >= ScreenBreakpoints.sm && screenWidth < ScreenBreakpoints.md;

  /// Check if device is large
  bool get isLarge => screenWidth >= ScreenBreakpoints.md && screenWidth < ScreenBreakpoints.lg;

  /// Check if device is extra large
  bool get isExtraLarge => screenWidth >= ScreenBreakpoints.lg;

  /// Check if device is tablet or larger
  bool get isTabletOrLarger => screenWidth >= ScreenBreakpoints.sm;

  /// Check if device is desktop or larger
  bool get isDesktopOrLarger => screenWidth >= ScreenBreakpoints.md;

  /// Check if device is in landscape mode
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  /// Check if device is in portrait mode
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  /// Get safe area padding
  EdgeInsets get safeAreaPadding => mediaQuery.padding;

  /// Get view padding
  EdgeInsets get viewPadding => mediaQuery.viewPadding;

  /// Get keyboard height
  double get keyboardHeight => mediaQuery.viewInsets.bottom;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => keyboardHeight > 0;
}

/// Responsive widget builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, String screenSize) builder;
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBuilder({super.key, required this.builder, this.mobile, this.tablet, this.desktop});

  @override
  Widget build(BuildContext context) {
    if (mobile != null || tablet != null || desktop != null) {
      return ScreenSizeHelper.getResponsiveValue(context, mobile: mobile ?? const SizedBox.shrink(), tablet: tablet, desktop: desktop);
    }

    return builder(context, ScreenSizeHelper.getScreenSizeCategory(context));
  }
}

/// Responsive layout widget
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({super.key, required this.mobile, this.tablet, this.desktop});

  @override
  Widget build(BuildContext context) {
    return ScreenSizeHelper.getResponsiveValue(context, mobile: mobile, tablet: tablet, desktop: desktop);
  }
}
