import 'package:flutter/material.dart';

class PopupMenue extends StatelessWidget {
  final List<PopupMenuEntry> menueList;
  final Widget? icon;
  PopupMenue({required this.menueList, this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => menueList,
      icon: icon,
    );
  }
}
