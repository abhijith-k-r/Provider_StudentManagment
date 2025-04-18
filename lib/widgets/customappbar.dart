import 'package:flutter/material.dart';

class CustomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final double? elevation;
  final Color? shadowColor;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;
  final bool? centerTitle;

  const CustomeAppBar({
    super.key,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.leading,
    this.actions,
    this.title,
    this.centerTitle,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}