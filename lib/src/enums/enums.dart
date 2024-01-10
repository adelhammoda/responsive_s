///have all probably type of screens
enum ScreenType {
  mobileLandscape,
  mobilePortrait,
  desktop,
  tableLandScape,
  tabletPortrait,
  TV,
  smartWatch
}

///The way that the package is respond to the  values
enum ResponsiveForChangeableOrientation {
  ///Meaning from width and height of device without caring about orientation.
  fromPhysicalDimension,

  ///The orientation will be important when this choice is enabled.
  fromRealDimension
}
