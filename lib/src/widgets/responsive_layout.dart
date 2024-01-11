import 'package:flutter/material.dart';

import '../enums/enums.dart';
import '../screen_detector.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.defaultWidget,
    this.mobile,
    this.mobileLandscape,
    this.tablet,
    this.tabletLandscape,
    this.desktop,
    this.tvScreen,
    this.smartWatch,
    this.unresolvedBoundaryWidget,
  });

  final Widget defaultWidget;
  final Widget? mobile;
  final Widget? mobileLandscape;
  final Widget? tablet;
  final Widget? tabletLandscape;
  final Widget? desktop;
  final Widget? tvScreen;
  final Widget? smartWatch;
  final Widget? unresolvedBoundaryWidget;

  @override
  Widget build(BuildContext context) {
    final ScreenDetector screenDetector = ScreenDetector(
      context,
    );
    switch (screenDetector.getScreenType()) {
      case ScreenType.TV:
        return tvScreen ?? desktop ?? defaultWidget;
      case ScreenType.desktop:
        return desktop ?? defaultWidget;
      case ScreenType.tabletPortrait:
        return tablet ?? defaultWidget;
      case ScreenType.tableLandScape:
        return tabletLandscape ?? tablet ?? defaultWidget;
      case ScreenType.mobilePortrait:
        return mobile ?? defaultWidget;
      case ScreenType.mobileLandscape:
        return mobileLandscape ?? mobile ?? defaultWidget;
      case ScreenType.smartWatch:
        return smartWatch ?? defaultWidget;
      case ScreenType.unresolvedBoundaries:
        return unresolvedBoundaryWidget ?? defaultWidget;
    }
  }
}
