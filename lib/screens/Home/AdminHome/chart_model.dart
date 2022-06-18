// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_print

import 'dart:math';
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/constants.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarChartModel {
  final String month;
  final int income;
  final charts.Color color;

  BarChartModel(this.month, this.income, this.color);
}

class PieChartModel {
  final String roomType;
  final int total;
  final charts.Color color;
  final Color color2;

  PieChartModel(this.roomType, this.total, this.color, this.color2);
}

final random = Random();

int standard = 0;
int executive = 0;
int presidential = 0;
var map = {};
List generalList = [];

fetchBestSellers(month, year) {
  if (month == 'jan') {
    month = '01';
  } else if (month == 'feb') {
    month = '02';
  } else if (month == 'mar') {
    month = '03';
  } else if (month == 'apr') {
    month = '04';
  } else if (month == 'may') {
    month = '05';
  } else if (month == 'jun') {
    month = '06';
  } else if (month == 'jul') {
    month = '07';
  } else if (month == 'aug') {
    month = '08';
  } else if (month == 'sep') {
    month = '09';
  } else if (month == 'oct') {
    month = '10';
  } else if (month == 'nov') {
    month = '11';
  } else {
    month = '12';
  }
  generalList.clear();
  map = {};
  for (var data in db.CustomersRecord) {
    if (year == data['checkindate'].split('-')[2]) {
      if (month == data['checkindate'].split('-')[1]) {
        generalList.add(data['roomtype']);
      }
    }
  }
  generalList.forEach((x) => map[x] = !map.containsKey(x) ? (1) : (map[x] + 1));
  print(map);
  standard = map.isNotEmpty ? map['standard'] : 0;
  executive = map.isNotEmpty ? map['executive'] : 0;
  presidential = map.isNotEmpty ? map['presidential'] : 0;
  return map;
}

class PieData {
  static List<PieChartModel> data = [
    PieChartModel('Standard', 15, charts.ColorUtil.fromDartColor(Colors.teal),
        Colors.teal),
    PieChartModel('Executive', executive,
        charts.ColorUtil.fromDartColor(Colors.yellow), Colors.yellow),
    PieChartModel('Presidential', presidential,
        charts.ColorUtil.fromDartColor(Colors.orange), Colors.orange),
  ];
}

class Indicators extends StatelessWidget {
  const Indicators({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: PieData.data
            .map((data) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: buildIndicator(
                      color: data.color2, text: data.roomType, isSquare: false),
                ))
            .toList(),
      );

  Widget buildIndicator({
    // required charts.Color color,
    required Color color,
    required String text,
    required bool isSquare,
    double size = 16,
    Color textColor = navyBlueColor,
  }) =>
      Row(children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color),
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
        )
      ]);
}
