import 'package:example/desktop_widget.dart';
import 'package:example/mobile_landscape_widget.dart';
import 'package:example/mobile_widget.dart';
import 'package:example/tablet_landscape_widget.dart';
import 'package:example/tablet_widget.dart';
import 'package:example/tv_widget.dart';
import 'package:example/watch_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_s/responsive_s.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWrapper(
      addHeightInCalculating: true,
      child: MaterialApp(
        title: 'Responsive',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Responsive overview'),
      ),
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
    return Scaffold(
      appBar: AppBar(),
      body: ResponsiveLayout(
        defaultWidget: DesktopWidget(),
        mobile: MobileWidget(),
        tablet:TabletWidget(),
        desktop: DesktopWidget(),
        mobileLandscape:MobileLandscapeWidget() ,
        smartWatch:SmartWatchWidget() ,
        tabletLandscape:TabletLandscapeWidget() ,
        tvScreen:TvWidget(),
        unresolvedBoundaryWidget: Text('Unresolved'),
      ),
    );
  }
}
