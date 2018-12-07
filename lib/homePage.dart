import 'package:flutter/material.dart';
import 'package:splash_screen/navbar_pages/quiz.dart';
import 'package:splash_screen/navbar_pages/video_page.dart';
import 'dart:async';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Quiz", Icons.pages),
    new DrawerItem("Videos", Icons.pages),
    new DrawerItem("Logout", Icons.close)
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new Quiz();
      case 1:
        return new VideoPage();
      case 2:
      //return new ThirdFragment();

      default:
        return new Text("Home page");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    return new WillPopScope(
        onWillPop: () async => _requestPop(),
        child: new Scaffold(
          appBar: new AppBar(
            // here we display the title corresponding to the fragment
            // you can instead choose to have a static title
            title: new Text(widget.drawerItems[_selectedDrawerIndex]
                .title), //changes title on click of every page
          ),
          drawer: new Drawer(
            child: new Column(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                    accountName: new Text("User Name"),
                    accountEmail: new Text("User Email Address")),
                new Column(children: drawerOptions)
              ],
            ),
          ),
          body: _getDrawerItemWidget(_selectedDrawerIndex),
        ));
  }
}

Future<bool> _requestPop() {
  return new Future.value(false);
}
