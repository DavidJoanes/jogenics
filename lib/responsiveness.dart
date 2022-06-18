import 'package:flutter/material.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key, required this.desktopScreen, required this.tabletScreen}) : super(key: key);
  final Widget? desktopScreen;
  final Widget? tabletScreen;

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1200) {
        return widget.desktopScreen!;
      } else {
        return widget.tabletScreen!;
      }
    });    
  }
}