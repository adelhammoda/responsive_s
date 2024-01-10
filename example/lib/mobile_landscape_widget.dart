import 'dart:math';

import 'package:flutter/material.dart';

class MobileLandscapeWidget extends StatelessWidget {
  const MobileLandscapeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi/2,
      child: Image.asset('assets/images/phone.jpeg'),
    );
  }
}
