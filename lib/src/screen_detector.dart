import 'dart:math';

import 'package:flutter/material.dart';

import 'enums/enums.dart';
import 'frame_provider/frame_provider.dart';

///detect screen type depending on width ,height and orientation
class ScreenDetector {
  final BuildContext context;

  ScreenDetector(this.context);

  Orientation getDeviceOrientation() => MediaQuery.of(context).orientation;

  ///test all probably screens for all devices including Tv screens ,
  ///smart watch screen
  ScreenType getScreenType() {
    final size = MediaQuery.of(context).size;

    final defaultSizes = FrameProvider.of(context).defaultSizes;
    final bool isLandscape = getDeviceOrientation() == Orientation.landscape;
    final realWidth;
    final bool considerHeight = FrameProvider.of(context).addHeightInCalculating;
    if (considerHeight) {
      realWidth = min(size.width, size.height);
    } else {
      realWidth = size.width;
    }

    ///In case the screen is under the unresolved boundaries
    if (realWidth <= defaultSizes.defaultUnresolvedWidth)
      return ScreenType.unresolvedBoundaries;

    ///smart watch screen
    if (realWidth >= 0 && realWidth <= defaultSizes.defaultScreenWatchWidth) {
      return ScreenType.smartWatch;
    }

    ///mobile phone screen
    else if (realWidth > defaultSizes.defaultScreenWatchWidth &&
        realWidth <= defaultSizes.defaultMobileWidth) {
      return isLandscape
          ? ScreenType.mobileLandscape
          : ScreenType.mobilePortrait;
    }

    ///tablet screen
    else if (realWidth > defaultSizes.defaultMobileWidth &&
        realWidth <= defaultSizes.defaultTabletWidth) {
      return isLandscape
          ? ScreenType.tableLandScape
          : ScreenType.tabletPortrait;
    }

    ///desktop screen
    else if (realWidth > defaultSizes.defaultTabletWidth &&
        realWidth <= defaultSizes.defaultDesktopWidth) {
      return ScreenType.desktop;
    }

    ///tv screen
    else {
      return ScreenType.TV;
    }
  }

  Size getFrame() {
    final screenType = getScreenType();
    final frameProvider = FrameProvider.of(context);
    switch (screenType) {
      case ScreenType.TV:
        return frameProvider.tvFrame;
      case ScreenType.desktop:
        return frameProvider.desktopFrame;
      case ScreenType.tabletPortrait:
        return frameProvider.tabletPortraitFrame;
      case ScreenType.tableLandScape:
        return frameProvider.tabletLandscapeFrame;
      case ScreenType.mobilePortrait:
        return frameProvider.mobilePortraitFrame;
      case ScreenType.mobileLandscape:
        return frameProvider.mobileLandscapeFrame;
      case ScreenType.smartWatch:
        return frameProvider.screenWatchFrame;
      case ScreenType.unresolvedBoundaries:
        return frameProvider.unresolvedBoundariesFrame;
    }
  }
}
