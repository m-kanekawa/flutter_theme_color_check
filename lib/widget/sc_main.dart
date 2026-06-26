import 'package:flutter/material.dart';
import 'package:flutter_theme_color_check/widget/tab_color.dart';
import 'package:flutter_theme_color_check/widget/tab_component.dart';
import 'package:flutter_theme_color_check/widget/tab_pick.dart';
import 'package:flutter_theme_color_check/widget/tab_code.dart';

class ScMain extends StatefulWidget {
  const ScMain({super.key});

  @override
  ScMainState createState() => ScMainState();
}

class ScMainState extends State<ScMain> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentPageIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Theme Color Checker"),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: 'pick', icon: Icon(Icons.cloud_outlined)),
            Tab(text: 'color', icon: Icon(Icons.beach_access_sharp)),
            Tab(text: 'component', icon: Icon(Icons.brightness_5_sharp)),
            Tab(text: 'code', icon: Icon(Icons.favorite_border_sharp)),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: <Widget>[TabPick(), TabColor(), TabComponent(), TabCode()],
      ),

      bottomNavigationBar: (_tabController.index == 2)
          ? NavigationBar(
              onDestinationSelected: (int index) {},
              selectedIndex: currentPageIndex,
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Badge(child: Icon(Icons.notifications_sharp)),
                  label: 'Notifications',
                ),
                NavigationDestination(
                  icon: Badge(
                    label: Text('2'),
                    child: Icon(Icons.messenger_sharp),
                  ),
                  label: 'Messages',
                ),
              ],
            )
          : null,
    );
  }
}
