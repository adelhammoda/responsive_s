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
    final realWidth = size.width;

    if (realWidth >= 0 && realWidth <= defaultSizes.defaultScreenWatchWidth) {
      return ScreenType.smartWatch;
    } else if (realWidth > defaultSizes.defaultScreenWatchWidth &&
        realWidth <= defaultSizes.defaultMobileWidth) {
      return isLandscape ? ScreenType.mobileLandscape : ScreenType.mobilePortrait;
    } else if (realWidth > defaultSizes.defaultMobileWidth &&
        realWidth <= defaultSizes.defaultTabletWidth) {
      return isLandscape
          ? ScreenType.tableLandScape
          : ScreenType.tabletPortrait;
    } else if (realWidth > defaultSizes.defaultTabletWidth &&
        realWidth <= defaultSizes.defaultDesktopWidth) {
      return ScreenType.desktop;
    } else {
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
    }
  }
}
