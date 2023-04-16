// ignore_for_file: library_private_types_in_public_api

import 'package:blured_navigation_bar_x/blured_nav_bar_x_item.dart';
import 'package:blured_navigation_bar_x/blured_navigation_bar_x.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Blured Navigation Bar X",
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Blured Navigation Bar X'),
          centerTitle: true,
        ),
        //If you want to show body behind the navbar, it should be true
        extendBody: true,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: colorList[_index], //Color.fromARGB(_index, 50, 200, 50),
          child: Center(child: Screen(index: _index)),
        ),
        bottomNavigationBar: BluredNavigationBarX(
          currentIndex: _index,
          labelStatus: LabelStatus.showSelected,
          backgroundColor: Colors.black87.withOpacity(.2),
          browColor: Colors.red,
          border: Border.all(width: 3, color: Colors.red),
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.red,
          items: [
            BluredNavBarXItem(icon: Icons.home, title: 'Home'),
            BluredNavBarXItem(icon: Icons.favorite, title: 'Favorite'),
            BluredNavBarXItem(icon: Icons.message, title: 'Message'),
          ],
          onPressed: (int v) {
            setState(() {
              _index = v;
            });
          },
        ),
      ),
    );
  }
}

//If there are no pictures, the pages should be distinguished by color
List<Color> colorList = [
  Colors.green,
  Colors.blueAccent,
  Colors.orange,
  Colors.black26,
  Colors.white54,
  Colors.tealAccent,
  Colors.deepPurpleAccent,
];

class Screen extends StatefulWidget {
  final int index;

  const Screen({Key? key, required this.index}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.maybeOf(context)?.size.width,
      height: MediaQuery.maybeOf(context)?.size.height,
      child: Image.asset(
        "assets/images/fon${widget.index + 1}.png",
        fit: BoxFit.fill,
      ),
    );
  }
}
