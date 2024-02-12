// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:ui';

import 'package:blured_navigation_bar_x/blured_nav_bar_x_item.dart';
import 'package:blured_navigation_bar_x/extensions.dart';
import 'package:blured_navigation_bar_x/utils.dart';
import 'package:flutter/material.dart';

typedef ItemBuilder = Widget Function(BuildContext context, int index, BluredNavBarXItem items);

class BluredNavigationBarX extends StatefulWidget {
  //items
  final List<BluredNavBarXItem> items;

  //current index
  final int currentIndex;

  //on pressed
  final void Function(int v)? onPressed;

  //selected item color
  final Color? selectedItemColor;

  //unselected item color
  final Color? unselectedItemColor;

  //background color
  final Color backgroundColor;

  //font size
  final double fontSize;

  //icon size
  final double iconSize;

  //border radius
  BorderRadius? borderRadius;

  //item builder
  final ItemBuilder itemBuilder;

  //The remaining distance from the outside
  final EdgeInsetsGeometry margin;

  //The remaining distance from the inside
  final EdgeInsetsGeometry padding;

  //width
  final double width;

  //shadow
  final double elevation;

  //blur radius
  final double blurRadius;

  //navigation view border
  final Border? border;

  //The color of the animated shape above
  final Color browColor;

  //label status
  //enabled
  //disabled
  //showSelected - > To appear when selected
  final LabelStatus labelStatus;

  BluredNavigationBarX(
      {Key? key,
      required this.items,
      required this.currentIndex,
      required this.onPressed,
      ItemBuilder? itemBuilder,
      this.backgroundColor = Colors.white10,
      this.selectedItemColor = Colors.black87,
      this.iconSize = 24.0,
      this.fontSize = 11.0,
      this.borderRadius,
      this.unselectedItemColor = Colors.white,
      this.margin = const EdgeInsets.all(8),
      this.padding = const EdgeInsets.symmetric(vertical: 8),
      this.width = double.infinity,
      this.elevation = 0.0,
      this.blurRadius = 4,
      this.border,
      this.browColor = Colors.black87,
      this.labelStatus = LabelStatus.enabled})
      : assert(items.length > 1),
        assert(items.length <= 6),
        assert(currentIndex <= items.length),
        assert(width > 50),
        itemBuilder = _itemBuilder(
            unselectedItemColor: unselectedItemColor,
            selectedItemColor: selectedItemColor,
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            fontSize: fontSize,
            width: width,
            backgroundColor: backgroundColor,
            currentIndex: currentIndex,
            iconSize: iconSize,
            items: items,
            onPressed: onPressed,
            browColor: browColor,
            labelStatus: labelStatus),
        super(key: key);

  @override
  _BluredNavigationBarXState createState() => _BluredNavigationBarXState();
}

class _BluredNavigationBarXState extends State<BluredNavigationBarX> {
  List<BluredNavBarXItem> get items => widget.items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.borderRadius = widget.borderRadius ?? BorderRadius.circular(8);

    return BottomAppBar(
      color: Colors.transparent,
      elevation: widget.elevation,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: ScrollController(initialScrollOffset: 15),
        child: Column(
          children: [
            Container(
                padding: widget.padding,
                margin: widget.margin,
                width: widget.width,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: widget.borderRadius,
                    border: widget.border,
                    color: widget.backgroundColor,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                        child: BackdropFilter(
                          filter:
                          ImageFilter.blur(sigmaY: widget.blurRadius, sigmaX: widget.blurRadius),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: items
                                .asMap()
                                .map((i, f) {
                              return MapEntry(i, widget.itemBuilder(context, i, f));
                            })
                                .values
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),

    );
  }
}

ItemBuilder _itemBuilder({
  Function(int val)? onPressed,
  required List<BluredNavBarXItem> items,
  int? currentIndex,
  Color? selectedItemColor,
  Color? unselectedItemColor,
  Color? backgroundColor,
  double width = double.infinity,
  double? fontSize,
  double? iconSize,
  BorderRadius? borderRadius,
  Color? browColor,
  LabelStatus labelStatus = LabelStatus.enabled,
}) {
  return (BuildContext context, int index, BluredNavBarXItem item) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.fastLinearToSlowEaseIn,
            width: MediaQuery.of(context).size.width / (items.length + 4),
            height: index == currentIndex ? (MediaQuery.of(context).size.height * 0.008) : 0.0,
            decoration: BoxDecoration(
              color: browColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.fastLinearToSlowEaseIn,
            width: size.width / (items.length + 4),
            height: index != currentIndex ? (size.height * 0.008) : 0.0,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(borderRadius: borderRadius),
                child: InkWell(
                  onTap: () {
                    onPressed!(index);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: width.isFinite
                        ? (width / items.length - 8)
                        : size.width / items.length - 24,
                    padding:
                        EdgeInsets.symmetric(horizontal: 6, vertical: item.title != null ? 6 : 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          height: index == currentIndex
                              ? ((isLandscape(context) ? size.width : size.height) * 0.045)
                              : (isLandscape(context) ? size.width : size.height) * 0.04,
                          duration: 400.milliseconds,
                          child: Column(
                            children: [
                              item.child == null
                                  ? Expanded(
                                      child: Icon(
                                        item.icon,
                                        color: currentIndex == index
                                            ? selectedItemColor
                                            : unselectedItemColor,
                                        size: iconSize,
                                      ),
                                    )
                                  : item.child!,
                              if (item.title != null)
                                Wrap(
                                  children: [
                                    labelStatus == LabelStatus.enabled
                                        ? Text(
                                            '${item.title}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: currentIndex == index
                                                  ? selectedItemColor
                                                  : unselectedItemColor,
                                              fontSize: fontSize,
                                            ),
                                          )
                                        : (labelStatus == LabelStatus.showSelected) &&
                                                (index == currentIndex)
                                            ? Text(
                                                '${item.title}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: currentIndex == index
                                                      ? selectedItemColor
                                                      : unselectedItemColor,
                                                  fontSize: fontSize,
                                                ),
                                              )
                                            : Container(),
                                  ],
                                )
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          height: index != currentIndex
                              ? ((isLandscape(context) ? size.width : size.height) * 0.005)
                              : (isLandscape(context) ? size.width : size.height) * 0,
                          duration: 400.milliseconds,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  };
}

//

enum LabelStatus { enabled, disabled, showSelected }
