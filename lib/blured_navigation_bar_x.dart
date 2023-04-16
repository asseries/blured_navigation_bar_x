
// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:ui';

import 'package:blured_navigation_bar_x/blured_nav_bar_x_item.dart';
import 'package:blured_navigation_bar_x/extensions.dart';
import 'package:blured_navigation_bar_x/utils.dart';
import 'package:flutter/material.dart';

import 'animations.dart';

typedef ItemBuilder = Widget Function(BuildContext context, int index, BluredNavBarXItem items);

class BluredNavigationBarX extends StatefulWidget {
  final List<BluredNavBarXItem> items;
  final int currentIndex;
  final void Function(int v)? onPressed;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Color backgroundColor;
  final double fontSize;
  final double iconSize;
  final double itemBorderRadius;
  BorderRadius? borderRadius;
  final ItemBuilder itemBuilder;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double width;
  final double elevation;
  final double blurRadius;
  final Border? border;
  final Color browColor;
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
      this.itemBorderRadius = 8,
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
            itemBorderRadius: itemBorderRadius,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                      borderRadius: widget.borderRadius,
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
  double? itemBorderRadius,
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(itemBorderRadius!)),
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
                                            : Container(
                                                height: 32,
                                              ),
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
