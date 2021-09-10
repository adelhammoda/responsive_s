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

//use single Ticker provider for tabBar View and TabController
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> key =
  GlobalKey<ScaffoldState>(debugLabel: 'app bar');
  late TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(),
      bottomNavigationBar: TabBar(
        controller: tabController,
        labelColor: Colors.black54,
        unselectedLabelColor: Colors.black38,
        tabs: [
          Tab(
            icon: Icon(
              Icons.star,
              color: Colors.blue.shade200,
            ),
            text: 'Example 1',
          ),
          Tab(
            icon: Icon(Icons.star, color: Colors.greenAccent.shade200),
            text: 'Example 2',
          ),
          Tab(
            icon: Icon(Icons.star, color: Colors.redAccent.shade200),
            text: 'Example 3',
          )
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: [Example1(), Example2(), Example3()],
      ),
    );
  }
}

//this example shows the normal responsive.
class Example1 extends StatelessWidget {
  const Example1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //the default value of responsive method is staticSize.
    //it's only introductory values.you can change it later.
    Responsive responsive = Responsive(context,
        width: 30, height: 40, responsiveMethod: ResponsiveOrientationMethod.staticSize);
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
                  'fontSize:${responsive.setFont(14).roundToDouble()}\nResponsiveMethod:staticSize\ncustomSize:unActive',
                  style: TextStyle(fontSize: responsive.setFont(14)),
                ),
              )
            ]),
      ),
    );
  }
}

//in this example we shows the custom responsive.
//when custom responsive is not null ,the widget  changes
//the width/height to custom width/height when device is flipped.
//NOTE:this property only for phone... the website don't respond to it
class Example2 extends StatelessWidget {
  const Example2({
    Key? key,
  }) : super(key: key);

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
            'fontSize:${responsive.setFont(8).roundToDouble()}\nResponsiveMethod:staticSize\ncustomSize:Active',
            style: TextStyle(fontSize: responsive.setFont(8)),
          ),
        ),
      ),
    );
  }
}

//In this example we will show the responsive when  you give
//SizeChangesDependingOnOrientation to responsive methode.
//desktop and TV don't change according to responsive method.
//If the custom property don't equal to null,then the responsive method
//don't have any active.
class Example3 extends StatelessWidget {
  const Example3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context,
        responsiveMethod: ResponsiveOrientationMethod.SizeChangesDependingOnOrientation);
    return SafeArea(
        child: Center(
          child: Container(
            color: Colors.orange,
            width: responsive.setWidth(40),
            height: responsive.setHeight(50),
            child: Text(
              'fontSize:${responsive.setFont(4).floor()}\nResponsiveMethod:SizeChangesDependingOnOrientation\ncustomSize:unActive',
              style: TextStyle(fontSize: responsive.setFont(8, customFont: 12)),
            ),
          ),
        ));
  }
}
