import 'package:flutter/cupertino.dart';

class Sizer {
  final BuildContext context;
  late Size screenSize;
  final Size frameSize;

  Sizer(
    this.context, {
    required this.frameSize,
  }) {
    screenSize = MediaQuery.of(context).size;
  }

  double _calculateLengthPercentage(
    double frameLength,
    double screenLength,
    double length,
  ) {
    final percentage = length / frameLength ;
    return percentage * screenLength;
  }

  ///Calculate  width from value depending on given frames.
  double w(double width) {
    return _calculateLengthPercentage(
      frameSize.width,
      screenSize.width,
      width,
    );
  }

  ///Calculate height from value depending on given frames.
  double h(double height) {
    return _calculateLengthPercentage(
      frameSize.height,
      screenSize.height,
      height,
    );
  }
}
