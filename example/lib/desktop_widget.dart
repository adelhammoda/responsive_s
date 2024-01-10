import 'package:flutter/material.dart';
import 'package:responsive_s/responsive_s.dart';

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (sizer) => Image.asset(
        'assets/images/desktop.png',
        fit: BoxFit.fill,
        width: sizer.w(1000),
      ),
    );
  }
}
