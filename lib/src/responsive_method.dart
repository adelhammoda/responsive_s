//
import 'package:flutter/material.dart';

//this class handle the responsive method.User width and user height property
import 'dart:ui';
import 'dart:io';

///have all probably type of screens
enum ScreenType { phone, desktop, tabletOrIpad, TV, website }

///to store size and orientation for device. The size contain screen width and screen height
///and can't change according to orientation.
class _DeviceInfo {
  Size size;
  Orientation orientation;
  WindowPadding padding;

  _DeviceInfo(this.size, this.orientation, this.padding);
}

///detect screen type depending on width ,height and orientation
class _ScreenDetector {
  BuildContext _context;
  late ScreenType _screenType;
  late _DeviceInfo _deviceInfo;
  late String systemEnvironment;

  _ScreenDetector(this._context) {
    _screenDimension();
  }

  ///test all probably screens for all devices including Tv screens
  void _screenDimensionDet(double realWidth, double realHeight) {
    try {
      if (realWidth <= 0) return;
      if (realWidth < 480) {
        _screenType = ScreenType.phone;
      } else if (realWidth > 480 && realWidth < 1200) {
        _screenType = ScreenType.tabletOrIpad;
      } else if (realWidth >= 1280 && realWidth <= 1920) {
        _screenType = ScreenType.desktop;
      } else {
        _screenType = ScreenType.TV;
      }
      systemEnvironment = Platform.operatingSystem;
    } catch (e) {
      systemEnvironment = 'un supported operation:maybe website or another ';
    } finally {
      Size size = Size(
          _screenType == ScreenType.tabletOrIpad ||
                  _screenType == ScreenType.phone
              ? realWidth
              : realHeight,
          _screenType == ScreenType.tabletOrIpad ||
                  _screenType == ScreenType.phone
              ? realHeight
              : realWidth);
      _deviceInfo = new _DeviceInfo(
          size, MediaQuery.of(_context).orientation, window.padding);
    }
  }

  void _screenDimension() {
    double width = window.physicalSize.width / window.devicePixelRatio;
    double height = window.physicalSize.height / window.devicePixelRatio;
    Orientation orientation = MediaQuery.of(_context).orientation;
    if (orientation == Orientation.portrait) {
      _screenDimensionDet(width, height);
    } else {
      final tempSize = new Size(width, height);
      late final bool env;
      try{
        env=Platform.isAndroid||Platform.isIOS;
      }catch(e){
        env =false;
      }
      if(env)
        _screenDimensionDet(height, width);
     else if (tempSize.longestSide > 1280 && tempSize.shortestSide > 720)
        _screenDimensionDet(width, height);
      else
        _screenDimensionDet(height, width);
    }
  }
}


///The way that the package is respond to the  values
enum ResponsiveForChangeableOrientation {
  ///Meaning from width and height of device without caring about orientation.
  fromPhysicalDimension,
  ///The orientation will be important when this choice is enabled.
  fromRealDimension
}

class _ResponsiveHandler extends _ScreenDetector {


  final ResponsiveForChangeableOrientation _responsiveForChangeableOrientation;

  ///(For mobile)Calculate ths size without the padding of screen.
  final bool _removePadding;
  late Size _size;

  _ResponsiveHandler(BuildContext context,
      this._responsiveForChangeableOrientation, this._removePadding)
      : super(context) {
    _unresponsiveSize();
  }

  _unresponsiveSize() {
    _size = Size(
        _deviceInfo.size.width -
            (_removePadding
                ? (_deviceInfo.padding.right + _deviceInfo.padding.left) /
                    window.devicePixelRatio
                : 0),
        _deviceInfo.size.height -
            (_removePadding
                ? (_deviceInfo.padding.top / window.devicePixelRatio)
                : 0));
  }

  double _percentage(double percent, double length) {
    return (percent / 100) * length;
  }

  double responsiveLength(
      double length,
      double lengthForLandscape,
      double mobileScreenPortrait,
      double mobileScreenLandscape,
      double tabletPortraitScreen,
      double tabletLandscapeScreen,
      double desktopScreen,
      double tvScreen) {
    if (super._screenType == ScreenType.phone) {
      return super._deviceInfo.orientation == Orientation.portrait
          ? _percentage(mobileScreenPortrait, length)
          : _percentage(mobileScreenLandscape, lengthForLandscape);
    } else if (super._screenType == ScreenType.tabletOrIpad) {
      return super._deviceInfo.orientation == Orientation.portrait
          ? _percentage(tabletPortraitScreen, length)
          : _percentage(tabletLandscapeScreen, lengthForLandscape);
    } else if (super._screenType == ScreenType.desktop ||
        super._screenType == ScreenType.website) {
      return _percentage(desktopScreen, length);
    } else {
      return _percentage(tvScreen, length);
    }
  }
}

class Responsive {
  late _ResponsiveHandler _responsiveHandler;

  Responsive(BuildContext context,
      {responsiveForChangeableOrientation =
          ResponsiveForChangeableOrientation.fromRealDimension,
      bool removePadding = true}) {
    _responsiveHandler = _ResponsiveHandler(
        context,
        responsiveForChangeableOrientation = responsiveForChangeableOrientation,
        removePadding = removePadding);
  }
///return the type of screen depending on the  dimension
  ScreenType get screenType => _responsiveHandler._screenType;
///return  a responsive  value calculated in percentage
  double responsiveHeight(
      {required double forUnInitialDevices,
      double? forPortraitMobileScreen,
      double? forLandscapeMobileScreen,
      double? forPortraitTabletScreen,
      double? forLandscapeTabletScreen,
      double? forDesktopScreen,
      double? forTVScreen}) {
    return _responsiveHandler.responsiveLength(
        _responsiveHandler._size.height,
        _responsiveHandler._responsiveForChangeableOrientation ==
                ResponsiveForChangeableOrientation.fromPhysicalDimension
            ? _responsiveHandler._size.height
            : _responsiveHandler._size.width,
        forPortraitMobileScreen ?? forUnInitialDevices,
        forLandscapeMobileScreen ?? forUnInitialDevices,
        forPortraitTabletScreen ?? forUnInitialDevices,
        forLandscapeTabletScreen ?? forUnInitialDevices,
        forDesktopScreen ?? forUnInitialDevices,
        forTVScreen ?? forUnInitialDevices);
  }
  ///return a responsive  value calculated in percentage
  double responsiveWidth(
      {required double forUnInitialDevices,
      double? forPortraitMobileScreen,
      double? forLandscapeMobileScreen,
      double? forPortraitTabletScreen,
      double? forLandscapeTabletScreen,
      double? forDesktopScreen,
      double? forTVScreen}) {
    return _responsiveHandler.responsiveLength(
        _responsiveHandler._size.width,
        _responsiveHandler._responsiveForChangeableOrientation ==
                ResponsiveForChangeableOrientation.fromPhysicalDimension
            ? _responsiveHandler._size.width
            : _responsiveHandler._size.height,
        forPortraitMobileScreen ?? forUnInitialDevices,
        forLandscapeMobileScreen ?? forUnInitialDevices,
        forPortraitTabletScreen ?? forUnInitialDevices,
        forLandscapeTabletScreen ?? forUnInitialDevices,
        forDesktopScreen ?? forUnInitialDevices,
        forTVScreen ?? forUnInitialDevices);
  }

  double responsiveValue(
      {required double forUnInitialDevices,
      double? forPortraitMobileScreen,
      double? forLandscapeMobileScreen,
      double? forPortraitTabletScreen,
      double? forLandscapeTabletScreen,
      double? forDesktopScreen,
      double? forTVScreen}) {
    return _responsiveHandler.responsiveLength(
        _responsiveHandler._size.shortestSide,
        _responsiveHandler._size.shortestSide,
        forPortraitMobileScreen ?? forUnInitialDevices,
        forLandscapeMobileScreen ?? forUnInitialDevices,
        forPortraitTabletScreen ?? forUnInitialDevices,
        forLandscapeTabletScreen ?? forUnInitialDevices,
        forDesktopScreen ?? forUnInitialDevices,
        forTVScreen ?? forUnInitialDevices);
  }
  ///return  a responsive  widget depending on screen type
  Widget responsiveWidget(
      {required Widget forUnInitialDevices,
      Widget? forPortraitMobileScreen,
      Widget? forLandscapeMobileScreen,
      Widget? forPortraitTabletScreen,
      Widget? forLandscapeTabletScreen,
      Widget? forDesktopScreen,
      Widget? forTVScreen}) {
    if (_responsiveHandler._screenType == ScreenType.phone)
      return (_responsiveHandler._deviceInfo.orientation == Orientation.portrait
              ? forPortraitMobileScreen
              : forLandscapeMobileScreen) ??
          forUnInitialDevices;
    else if (_responsiveHandler._screenType == ScreenType.tabletOrIpad)
      return (_responsiveHandler._deviceInfo.orientation == Orientation.portrait
              ? forPortraitTabletScreen
              : forLandscapeTabletScreen) ??
          forUnInitialDevices;
    else if (_responsiveHandler._screenType == ScreenType.desktop ||
        _responsiveHandler._screenType == ScreenType.website)
      return forDesktopScreen ?? forUnInitialDevices;
    else
      return forTVScreen ?? forUnInitialDevices;
  }
///Use to return different function depending on screen type.
  responsiveFunction(
      {required Function forUnInitialDevices,
      Function? forPortraitMobileScreen,
      Function? forLandscapeMobileScreen,
      Function? forPortraitTabletScreen,
      Function? forLandscapeTabletScreen,
      Function? forDesktopScreen,
      Function? forTVScreen}) {
    if (_responsiveHandler._screenType == ScreenType.phone)
      return (_responsiveHandler._deviceInfo.orientation == Orientation.portrait
              ? forPortraitMobileScreen
              : forLandscapeMobileScreen) ??
          forUnInitialDevices;
    else if (_responsiveHandler._screenType == ScreenType.tabletOrIpad)
      return (_responsiveHandler._deviceInfo.orientation == Orientation.portrait
              ? forPortraitTabletScreen
              : forLandscapeTabletScreen) ??
          forUnInitialDevices;
    else if (_responsiveHandler._screenType == ScreenType.desktop ||
        _responsiveHandler._screenType == ScreenType.website)
      return forDesktopScreen ?? forUnInitialDevices;
    else
      return forTVScreen ?? forUnInitialDevices;
  }
}
