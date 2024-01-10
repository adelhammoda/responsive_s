import 'package:flutter/material.dart';
import '../screen_detector.dart';
import '../sizer.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    super.key,
    required this.builder,
  });

  final Widget Function(Sizer sizer) builder;

  @override
  Widget build(BuildContext context) {
    final ScreenDetector screenDetector = ScreenDetector(context);
    final sizer = Sizer(
      context,
      frameSize: screenDetector.getFrame(),
    );

    return builder(sizer);
  }
}
