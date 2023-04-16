# [blured_navigation_bar_x](https://pub.dev/packages/blured_navigation_bar_x)


Bottom Navigation View Library for Flutter

## BLURED BOTTOM NAVIGATION VIEW

> Supported Platforms

>
>  - Android
>  - iOS
>  - Windows
>  - Linux
>  - MacOS
>  - Web

## WITH BORDER
<p  align="center">
<img  src="https://github.com/asseries/blured_navigation_bar_x/blob/main/with_border.gif?raw=true"  width="350"/>
<br>
</p>

## DEFAULT
<p  align="center">
<img  src="https://github.com/asseries/blured_navigation_bar_x/blob/main/default.gif?raw=true"  width="350"/>
<br>
</p>

## SHOW SELECTED LABEL 
<p  align="center">
<img  src="https://github.com/asseries/blured_navigation_bar_x/blob/main/selected_show_label.gif?raw=true"  width="350"/>
<br>
</p>




## How to Use

```yaml
# add this line to your dependencies
blured_navigation_bar_x: ^1.0.1
```

```dart
import 'package:blured_navitation_bar_x/blured_navitation_bar_x.dart';
```


```dart
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


```