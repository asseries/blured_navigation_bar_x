import 'package:flutter/material.dart';

//blured navigation view item
class BluredNavBarXItem {
  final String? title;
  final IconData? icon;
  final Widget? child;

  BluredNavBarXItem({
    this.icon,
    this.title,
    this.child,
  }) : assert(icon != null || child != null);
}
