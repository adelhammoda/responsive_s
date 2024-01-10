import 'dart:math';

import 'package:flutter/material.dart';

class TabletLandscapeWidget extends StatelessWidget {
  const TabletLandscapeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Transform.rotate(
      angle: pi/2,
      child: Image.asset('assets/images/tablet.jpeg'),
    );
  }
}
