// ignore_for_file: prefer_const_constructors

import 'package:JoGenics/components/logout.dart';
import 'package:JoGenics/constants.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String name, Color color, bool isLogout) {
  Size size = MediaQuery.of(context).size;
  var style = TextStyle(
    fontSize: size.width*0.012,
    fontWeight: FontWeight.w800,
    color: color,
  );

  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_new_rounded),
      color: primaryColor,
      onPressed: () {
        isLogout
        ? buildLogoutWidget(context)
        : Navigator.of(context).pop(context);
      },
    ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Text(
      name,
      style: style,
    ),
  );
}
