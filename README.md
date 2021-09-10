<p align="center">
	<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1q4RidNW7-RirwV6Nf4Se7l_4YXvpTqvkSQ&usqp=CAU" height="200" width="200" alt="Responsive Logo" />
</p>
<p align="center">
	<a href="https://pub.dev/packages/responsive_size"><img src="https://img.shields.io/badge/pub-v0.0.1-blue" alt="Pub.dev Badge"></a>
	</p>

# Responsive_s

Build any app with your optional responsive for width ,height and font size.

Responsive give many optional parameters to control responsive way:

- **static size** means the size will be keeping;
- **size change depending on orientation** means the width and height will be bigger or smaller
  depending on orientation of device;
- size change depending on orientation method is not active on website or TV screen;
- The package automatically detect screen type;

## Usage

```dart
//this example shows the normal responsive.
@override
Widget build(BuildContext context) {
  //the default value of responsive method is staticSize.
  //it's only introductory values.you can change it later.
  Responsive responsive = Responsive(context,
      width: 30, height: 40, responsiveMethod: ResponsiveMethod.staticSize);
  return SafeArea(
    child: Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.yellow.shade100,
              //30 mean 30% of screen width.
              width: responsive.setWidth(70),
              //40 mean 40% of screen height.
              height: responsive.setHeight(30),
              child: Text(
                'fontSize:${responsive.setFont(14)
                    .roundToDouble()}\nResponsiveMethod:staticSize\ncustomSize:unActive',
                style: TextStyle(fontSize: responsive.setFont(14)),
              ),
            )
          ]),
    ),
  );
}
```

#### Result:

* phone:

<p align="center">
	<img src="https://github.com/adelhammoda/responsive/blob/master/assets/example1-p.png" height="400" width="200"  alt="test result" />
<img src="https://github.com/adelhammoda/responsive/blob/master/assets/example1-o.png" height="200" width="400"  alt="test result" />
</p>

* web:

<p align="center">
	<img src="https://github.com/adelhammoda/responsive/blob/master/assets/example1-web.png" height="200" width="400"  alt="test result" />
</p>

```dart
//in this example we shows the custom responsive.
//when custom responsive is not null ,the widget  changes
//the width/height to custom width/height when device is flipped.
//NOTE:this property only for phone... the website don't respond to it
@override
Widget build(BuildContext context) {
  Responsive responsive = Responsive(
    context,
  );
  return SafeArea(
    child: Center(
      child: Container(
        //50 mean 50% of width on portrait orientation and 70 mean
        //70% of  width on landscape orientation.
        width: responsive.setWidth(50, customWidth: 70),
        //70 mean 70% of width on portrait orientation and 50 mean
        //50% of  width on landscape orientation.
        height: responsive.setHeight(70, customHeight: 50),
        color: Colors.greenAccent,
        child: Text(
          'fontSize:${responsive.setFont(8)
              .roundToDouble()}\nResponsiveMethod:staticSize\ncustomSize:Active',
          style: TextStyle(fontSize: responsive.setFont(8)),
        ),
      ),
    ),
  );
}
```

#### Result:

* phone:

<p align="center">
	<img src="https://github.com/adelhammoda/responsive/blob/master/assets/example2-p.png" height="400" width="200"  alt="test result" />
<img src="https://github.com/adelhammoda/responsive/blob/master/assets/example2-o.png" height="200" width="400"  alt="test result" />
</p>

* web:

<p align="center">
	<img src="https://github.com/adelhammoda/responsive/blob/master/assets/example2-webpng.png" height="200" width="400"  alt="test result" />
</p>

```dart
//In this example we will show the responsive when  you give
//SizeChangesDependingOnOrientation to responsive methode.
//desktop and TV don't change according to responsive method.
//If the custom property don't equal to null,then the responsive method
//don't have any active.
@override
Widget build(BuildContext context) {
  Responsive responsive = Responsive(context,
      responsiveMethod: ResponsiveMethod.SizeChangesDependingOnOrientation);
  return SafeArea(
      child: Center(
        child: Container(
          color: Colors.orange,
          width: responsive.setWidth(40),
          height: responsive.setHeight(50),
          child: Text(
            'fontSize:${responsive.setFont(4)
                .floor()}\nResponsiveMethod:SizeChangesDependingOnOrientation\ncustomSize:unActive',
            style: TextStyle(fontSize: responsive.setFont(8, customFont: 12)),
          ),
        ),
      ));
}
```

#### Result:

* phone:

<p align="center">
	<img src="https://github.com/adelhammoda/responsive/blob/master/assets/example3-p.png" height="400" width="200"  alt="test result" />
<img src="https://github.com/adelhammoda/responsive/blob/master/assets/example3-o.png" height="200" width="400"  alt="test result" />
</p>

* web:

<p align="center">
	<img src="https://github.com/adelhammoda/responsive/blob/master/assets/example3-web.png" height="200" width="400"  alt="test result" />
</p>

## Overview

Until now,this package offer many responsive function depending on device:

- for phone , tablet and ipad:
    * responsive size and responsive font .
    * optional size and font responsive(when device is flipped).
    * remove padding.
    * custom responsive font.
- for pc/laptop and TV:
    * size and font responsive. 


