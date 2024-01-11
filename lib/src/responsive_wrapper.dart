import 'package:flutter/cupertino.dart';
import 'package:responsive_s/src/constant/frame_constant.dart';
import 'package:responsive_s/src/custom_default_size.dart';
import 'package:responsive_s/src/frame_provider/frame_provider.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final Size desktopFrame;
  final Size tabletLandscapeFrame;
  final Size tabletPortraitFrame;
  final Size mobileLandscapeFrame;
  final Size mobilePortraitFrame;
  final Size tvFrame;
  final Size screenWatchFrame;
  final Size unresolvedBoundariesFrame;
  final CustomDefaultSize defaultSizes;
  final bool addHeightInCalculating;
  const ResponsiveWrapper({
    required this.child,
    this.defaultSizes = const CustomDefaultSize(),
    this.tvFrame = FrameConstant.tvFrame,
    this.desktopFrame = FrameConstant.desktopFrame,
    this.mobileLandscapeFrame = FrameConstant.mobileLandscapeFrame,
    this.mobilePortraitFrame = FrameConstant.mobilePortraitFrame,
    this.tabletLandscapeFrame = FrameConstant.tabletLandscapeFrame,
    this.tabletPortraitFrame = FrameConstant.tabletPortraitFrame,
    this.screenWatchFrame = FrameConstant.screenWatchFrame,
    this.unresolvedBoundariesFrame = FrameConstant.unresolvedBoundariesFrame,
    this.addHeightInCalculating = false,
  });

  @override
  Widget build(BuildContext context) {
    return FrameProvider(
      defaultSizes: defaultSizes,
      unresolvedBoundariesFrame: unresolvedBoundariesFrame,
      desktopFrame: desktopFrame,
      mobileLandscapeFrame: mobileLandscapeFrame,
      mobilePortraitFrame: mobilePortraitFrame,
      screenWatchFrame: screenWatchFrame,
      tabletLandscapeFrame: tabletLandscapeFrame,
      tabletPortraitFrame: tabletPortraitFrame,
      tvFrame: tvFrame,
      addHeightInCalculating: addHeightInCalculating,
      child: child,
    );
  }
}