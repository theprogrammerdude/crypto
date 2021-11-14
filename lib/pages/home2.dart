import 'package:crypto_plus/pages/feed.dart';
import 'package:crypto_plus/pages/market.dart';
import 'package:crypto_plus/pages/portfolio.dart';
import 'package:crypto_plus/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  List<ScreenHiddenDrawer> items = [];

  @override
  void initState() {
    items.add(ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Feed",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.teal,
          selectedStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Feed()));

    items.add(ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Market",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.teal,
          selectedStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Market()));

    items.add(ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Portfolio",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.teal,
          selectedStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Portfolio()));

    items.add(ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Profile",
          baseStyle:
              TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 28.0),
          colorLineSelected: Colors.teal,
          selectedStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Profile()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.purple,
      backgroundColorAppBar: Theme.of(context).primaryColor,
      screens: items,
      elevationAppBar: 0,
    );
  }
}
