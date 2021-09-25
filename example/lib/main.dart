import 'package:flutter/material.dart';
import 'package:responsive_s/responsive_s.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Responsive overview'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Responsive _responsive = new Responsive(context);
    List<Widget> _circularAvatar = List<Widget>.generate(
        3,
            (index) =>
            CircleAvatar(
              radius: _responsive.responsiveValue(
                  forUnInitialDevices: 5,
                  forDesktopScreen: 10,
                  forPortraitMobileScreen:5),
            ));

    Container _container = Container(
        color: Colors.red,
        child: Text(_responsive.screenType.toString(),style: TextStyle(
          fontSize: _responsive.responsiveValue(forUnInitialDevices: 5)
        ),),
        width: _responsive.responsiveWidth(forUnInitialDevices: 80),
        height: _responsive.responsiveHeight(forUnInitialDevices: 60));
   Widget _mobile=Column(
      mainAxisSize: MainAxisSize.max ,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: _circularAvatar,
        ),
        _container
      ],
    );
   Widget _desktop = Row(
     mainAxisSize: MainAxisSize.max,
     children: [
       Column(
         mainAxisSize: MainAxisSize.max,
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: _circularAvatar,
       ),
       SizedBox(width: _responsive.responsiveWidth(forUnInitialDevices:2),),
       _container
     ],
   );
    return Scaffold(
        appBar: AppBar(),
        body: _responsive.responsiveWidget(
                forUnInitialDevices: _desktop,
                forPortraitMobileScreen:_mobile,
                forPortraitTabletScreen:_mobile)
        );
  }
}
