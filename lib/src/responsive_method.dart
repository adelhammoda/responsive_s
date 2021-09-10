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
        systemEnvironment = Platform.operatingSystem;
      } else if (realWidth > 480 && realWidth < 1200) {
        _screenType = ScreenType.tabletOrIpad;
        systemEnvironment = Platform.operatingSystem;
      } else if (realWidth >= 1200 && realWidth <= 1600) {
        _screenType = ScreenType.desktop;
        systemEnvironment = Platform.operatingSystem;
      } else {
        _screenType = ScreenType.TV;
        systemEnvironment = Platform.operatingSystem;
      }
    } catch (e) {
      _screenType = ScreenType.website;
      systemEnvironment = 'un supported operation:maybe website or another ';
      print('$e');
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
      _screenDimensionDet(height, width);
    }
  }
}
///is the percent of width and height.

class ResponsiveHandler extends _ScreenDetector {
  ///customUserWidth and customUserHeight is used
  ///for phone or tabletOrIpad screen type and return optional width and height when
  ///orientation is equal to landscape => NOTE: only for phone and tablet or ipad.
  double _customUserWidth, _customUserHeight;
  double _userWidth, _userHeight;


  ///when responsiveMethod is equal to staticSize it mean width and height don't
  ///change when the device rotation.
  ///
  ///  for example: on portrait width =60% =370.6 ,height=30%=220.3.on landscape width =370.6 ,height=220.3
  ///when responsiveMethod is equal to SizeChangesDependingOnOrientation
  ///it mean width and height percentage is taken from real size of device and
  ///they will change when device rotation.
  ///
  ///for example: on portrait width =60% =370.6 ,height=30%=220.3  .on landscape width = 520.2 , height =114.9
  ResponsiveOrientationMethod _responsiveOrientationMethod;

  ///remove the padding of screen.
  bool _removePadding;
  late Size _size;

  ResponsiveHandler(
      BuildContext context,
      this._responsiveOrientationMethod,
      this._customUserHeight,
      this._customUserWidth,
      this._userHeight,
      this._userWidth,
      this._removePadding)
      : super(context) {
    if (_userWidth < 0 ||
        _userHeight < 0 ||
        _customUserHeight < 0 ||
        _customUserWidth < 0) {
      throw 'width or height is equal to negative number .';
    }
    // print(context.);
    _updateSize();
  }

  _updateSize() {
    _size = Size(
        _userWidth *
            (_deviceInfo.size.width -
                (_removePadding
                    ? (_deviceInfo.padding.right + _deviceInfo.padding.left) /
                    window.devicePixelRatio
                    : 0)) /
            100,
        _userHeight *
            (_deviceInfo.size.height -
                (_removePadding
                    ? (_deviceInfo.padding.top / window.devicePixelRatio)
                    : 0)) /
            100);
  }

  Size basicResponsive() {
    _updateSize();
    if ((_screenType == ScreenType.phone ||
        _screenType == ScreenType.tabletOrIpad) &&
        _responsiveOrientationMethod ==
            ResponsiveOrientationMethod.SizeChangesDependingOnOrientation &&
        _deviceInfo.orientation == Orientation.landscape) {
      return Size(
          _userWidth *
              (_deviceInfo.size.height -
                  (_removePadding
                      ? (_deviceInfo.padding.top /
                      window.devicePixelRatio)
                      : 0)) /
              100,
          _userHeight *
              (_deviceInfo.size.width -
                  (_removePadding
                      ? (_deviceInfo.padding.top /
                      window.devicePixelRatio)
                      : 0)) /
              100);

    } else
      return _size;
  }

  Size optionalResponsive() {
    _updateSize();
    if ((_screenType == ScreenType.phone ||
        _screenType == ScreenType.tabletOrIpad)&&_deviceInfo
        .orientation ==
        Orientation.landscape)
      return Size(_customUserWidth * _deviceInfo.size.height / 100,
          _customUserHeight * _deviceInfo.size.width / 100);
    else
      return Size(_userWidth * _deviceInfo.size.width / 100,
          _userHeight * _deviceInfo.size.height / 100);
  }
}

enum ResponsiveOrientationMethod { staticSize, SizeChangesDependingOnOrientation }

class Responsive extends  ResponsiveHandler {
  Responsive(BuildContext context,
      {double width = 0,
        double height = 0,
        double customWidth = 0,
        double customHeight = 0,
        responsiveMethod = ResponsiveOrientationMethod.staticSize,
        bool removePadding = false})
      : super(context, responsiveMethod, customHeight, customWidth, height,
      width, removePadding);

  double setWidth(double width, {double customWidth = -1}) {
    super._userWidth = width;
    print('${super._userWidth}');
    if (customWidth >= 0) {
      super._customUserWidth = customWidth;
      return super.optionalResponsive().width;
    } else {
      print('i am here');
      return super.basicResponsive().width;
    }
  }

  double setHeight(double height, {double customHeight = -1}) {
    super._userHeight = height;
    if (customHeight >= 0) {
      super._customUserHeight = customHeight;
      return super.optionalResponsive().height;
    } else {
      return super.basicResponsive().height;
    }
  }

  double get width {
    return super.basicResponsive().width;
  }

  double get height {
    return super.basicResponsive().height;
  }

  double setFont(double fontSize, {double customFont = -1}) {
    double temp = super._userWidth;
    super._userWidth = 100;
    double font;
    if (customFont >= 0) {
      font = super.optionalResponsive().width * fontSize / 100;
    } else {
      font = super.basicResponsive().width * fontSize / 100;
    }
    super._userWidth = temp;
    return font;
  }

  double setRadius(double radius, {double customRadius = -1}) {
    double temp = super._userWidth;
    super._userWidth = 100;
    double font;
    if (customRadius >= 0) {
      font = super.optionalResponsive().width * customRadius / 100;
    } else {
      font = super.basicResponsive().width * customRadius / 100;
    }
    super._userWidth = temp;
    return font;
  }
}
