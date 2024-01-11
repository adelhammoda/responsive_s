import 'package:flutter/cupertino.dart';
import 'package:responsive_s/src/custom_default_size.dart';



class FrameProvider extends InheritedWidget {
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

  FrameProvider({
    required super.child,
    required this.tvFrame,
    required this.desktopFrame,
    required this.mobileLandscapeFrame,
    required this.mobilePortraitFrame,
    required this.tabletLandscapeFrame,
    required this.tabletPortraitFrame,
    required this.screenWatchFrame,
    required this.defaultSizes,
    required this.unresolvedBoundariesFrame,
    this.addHeightInCalculating = false,
  });

  static FrameProvider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<FrameProvider>()!);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget != this;
}
