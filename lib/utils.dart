import 'package:flutter/material.dart';

//The code that determines the screen orientation
bool isLandscape(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.landscape) {
    return true;
  } else {
    return false;
  }
}