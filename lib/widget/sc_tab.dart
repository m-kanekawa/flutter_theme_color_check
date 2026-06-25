import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_theme_color_check/widget/tab_color.dart';
import 'package:flutter_theme_color_check/widget/tab_component.dart';
import 'package:flutter_theme_color_check/widget/tab_pick.dart';

class ScTab extends HookConsumerWidget {
  const ScTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentPageIndex = 0;
    // final modeN = ref.read(screenModeProvider.notifier);

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Theme Color Checker"),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: 'pick', icon: Icon(Icons.cloud_outlined)),
              Tab(text: 'color', icon: Icon(Icons.beach_access_sharp)),
              Tab(text: 'component', icon: Icon(Icons.brightness_5_sharp)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[TabPick(), TabColor(), TabComponent()],
        ),
        bottomNavigationBar: NavigationBar(
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
              icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
              label: 'Messages',
            ),
          ],
        ),
      ),
    );
  }
}
