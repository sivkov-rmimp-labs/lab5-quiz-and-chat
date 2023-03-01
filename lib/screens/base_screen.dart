import 'package:flutter/material.dart';

abstract class Screen extends Widget {
  int get bottomNavigationBarButtonIndex => -1;

  String get appBarTitle => 'Screen';

  List<AppBarAction> get appBarActions => [];
}

class AppBarAction {
  final IconData icon;
  final void Function(BuildContext context) onTap;

  const AppBarAction({required this.icon, required this.onTap});
}
