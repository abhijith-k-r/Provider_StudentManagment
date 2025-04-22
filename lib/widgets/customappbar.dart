import 'package:flutter/material.dart';

class CustomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final double? elevation;
  final Color? shadowColor;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;
  final bool? centerTitle;
  final double height;
  final PreferredSizeWidget? bottom;

  const CustomeAppBar({
    super.key,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.leading,
    this.actions,
    this.title,
    this.centerTitle,
    this.height = kTextTabBarHeight,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shadowColor: shadowColor,
      leading: leading,
      actions: actions,
      title: title,
      centerTitle: centerTitle,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    final additionalHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(height + additionalHeight);
  }
}
