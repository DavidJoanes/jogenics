// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, must_be_immutable, library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously, unused_catch_clause

import 'dart:io';

import 'package:csv/csv.dart';
import 'dart:math';
import 'package:JoGenics/components/custom_page_route.dart';
import 'package:JoGenics/components/title_case.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/screens/Home/AdminHome/analysis2.dart';
import 'package:JoGenics/screens/Home/AdminHome/chart_model.dart' as chartmodel;
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Analysis extends StatefulWidget {
  const Analysis({Key? key}) : super(key: key);

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  final years = {
    '',
  };
  DropdownMenuItem<String> buildYears(String Year) => DropdownMenuItem(
      value: Year,
      child: Text(
        Year,
      ));

  // Income for each month for both the rooms and the lounge
  late int january = 0, january2 = 0;
  late int febuary = 0, febuary2 = 0;
  late int march = 0, march2 = 0;
  late int april = 0, april2 = 0;
  late int may = 0, may2 = 0;
  late int june = 0, june2 = 0;
  late int july = 0, july2 = 0;
  late int august = 0, august2 = 0;
  late int september = 0, september2 = 0;
  late int october = 0, october2 = 0;
  late int november = 0, november2 = 0;
  late int december = 0, december2 = 0;

  fetchYears() {
    // late List years = [];
    for (var data in db.CustomersRecord) {
      years.add(data['checkindate'].split('-')[2]);
    }
    for (var data in db.InvoicesRecord) {
      years.add(data['date'].split('-')[2]);
    }
  }

  fetchIncome(year) {
    january = 0;
    febuary = 0;
    march = 0;
    april = 0;
    may = 0;
    june = 0;
    july = 0;
    august = 0;
    september = 0;
    october = 0;
    november = 0;
    december = 0;
    num total = 0;
    for (var data in db.CustomersRecord) {
      if (year == data['checkindate'].split('-')[2]) {
        if (data['checkindate'].split('-')[1] == '01') {
          total += int.parse(data['totalcost']);
          january = total as int;
        } else if (data['checkindate'].split('-')[1] == '02') {
          total += int.parse(data['totalcost']);
          febuary = total as int;
        } else if (data['checkindate'].split('-')[1] == '03') {
          total += int.parse(data['totalcost']);
          march = total as int;
        } else if (data['checkindate'].split('-')[1] == '04') {
          total += int.parse(data['totalcost']);
          april = total as int;
        } else if (data['checkindate'].split('-')[1] == '05') {
          total += int.parse(data['totalcost']);
          may = total as int;
        } else if (data['checkindate'].split('-')[1] == '06') {
          total += int.parse(data['totalcost']);
          june = total as int;
        } else if (data['checkindate'].split('-')[1] == '07') {
          total += int.parse(data['totalcost']);
          july = total as int;
        } else if (data['checkindate'].split('-')[1] == '08') {
          total += int.parse(data['totalcost']);
          august = total as int;
        } else if (data['checkindate'].split('-')[1] == '09') {
          total += int.parse(data['totalcost']);
          september = total as int;
        } else if (data['checkindate'].split('-')[1] == '10') {
          total += int.parse(data['totalcost']);
          october = total as int;
        } else if (data['checkindate'].split('-')[1] == '11') {
          total += int.parse(data['totalcost']);
          november = total as int;
        } else {
          total += int.parse(data['totalcost']);
          december = total as int;
        }
      }
    }
  }

  fetchIncome2(year) {
    january2 = 0;
    febuary2 = 0;
    march2 = 0;
    april2 = 0;
    may2 = 0;
    june2 = 0;
    july2 = 0;
    august2 = 0;
    september2 = 0;
    october2 = 0;
    november2 = 0;
    december2 = 0;
    num total = 0;
    for (var data in db.InvoicesRecord) {
      if (year == data['date'].split('-')[2]) {
        if (data['date'].split('-')[1] == '01') {
          total += int.parse(data['totalcost']);
          january2 = total as int;
        } else if (data['date'].split('-')[1] == '02') {
          total += int.parse(data['totalcost']);
          febuary2 = total as int;
        } else if (data['date'].split('-')[1] == '03') {
          total += int.parse(data['totalcost']);
          march2 = total as int;
        } else if (data['date'].split('-')[1] == '04') {
          total += int.parse(data['totalcost']);
          april2 = total as int;
        } else if (data['date'].split('-')[1] == '05') {
          total += int.parse(data['totalcost']);
          may2 = total as int;
        } else if (data['date'].split('-')[1] == '06') {
          total += int.parse(data['totalcost']);
          june2 = total as int;
        } else if (data['date'].split('-')[1] == '07') {
          total += int.parse(data['totalcost']);
          july2 = total as int;
        } else if (data['date'].split('-')[1] == '08') {
          total += int.parse(data['totalcost']);
          august2 = total as int;
        } else if (data['date'].split('-')[1] == '09') {
          total += int.parse(data['totalcost']);
          september2 = total as int;
        } else if (data['date'].split('-')[1] == '10') {
          total += int.parse(data['totalcost']);
          october2 = total as int;
        } else if (data['date'].split('-')[1] == '11') {
          total += int.parse(data['totalcost']);
          november2 = total as int;
        } else {
          total += int.parse(data['totalcost']);
          december2 = total as int;
        }
      }
    }
  }

  int indexForMonthsOfBestSellers = 0;

  @override
  void initState() {
    super.initState();
    year = null;
    fetchYears();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: customBackgroundColor,
        appBar: buildAppBar(context, 'Analysis', blackColor, true),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: transparentColor, width: 2),
                    color: whiteColor,
                  ),
                  child: ListTile(
                    leading:
                        Icon(Icons.calendar_month_rounded, color: primaryColor),
                    title: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text('Select year'),
                        // isExpanded: true,
                        value: year,
                        iconSize: size.width * 0.02,
                        items: years.map(buildYears).toList(),
                        onChanged: (value) async => setState(() {
                          year = value;
                          fetchIncome(year);
                          fetchIncome2(year);
                          chartmodel.fetchBestSellers('jan', year);
                        }),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              db.CustomersRecord.isEmpty && db.InvoicesRecord.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            BuildLeft(
                                year: year as String,
                                january: january,
                                febuary: febuary,
                                march: march,
                                april: april,
                                may: may,
                                june: june,
                                july: july,
                                august: august,
                                september: september,
                                october: october,
                                november: november,
                                december: december,
                                january2: january2,
                                febuary2: febuary2,
                                march2: march2,
                                april2: april2,
                                may2: may2,
                                june2: june2,
                                july2: july2,
                                august2: august2,
                                september2: september2,
                                october2: october2,
                                november2: november2,
                                december2: december2),
                            BuildRight(
                                indexForMonthsOfBestSellers:
                                    indexForMonthsOfBestSellers),
                          ],
                        ),
                        SizedBox(height: size.height * 0.1),
                        Text('LOUNGE ANALYSIS',
                            style: TextStyle(
                                fontSize: size.width * 0.015,
                                fontWeight: FontWeight.bold,
                                color: navyBlueColor)),
                        BuildBottom(),
                        SizedBox(height: size.height * 0.01),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// Inner Left Widget Class
class BuildLeft extends StatefulWidget {
  BuildLeft(
      {Key? key,
      required this.year,
      required this.january,
      required this.febuary,
      required this.march,
      required this.april,
      required this.may,
      required this.june,
      required this.july,
      required this.august,
      required this.september,
      required this.october,
      required this.november,
      required this.december,
      required this.january2,
      required this.febuary2,
      required this.march2,
      required this.april2,
      required this.may2,
      required this.june2,
      required this.july2,
      required this.august2,
      required this.september2,
      required this.october2,
      required this.november2,
      required this.december2})
      : super(key: key);
  final String year;
  late int january, january2;
  late int febuary, febuary2;
  late int march, march2;
  late int april, april2;
  late int may, may2;
  late int june, june2;
  late int july, july2;
  late int august, august2;
  late int september, september2;
  late int october, october2;
  late int november, november2;
  late int december, december2;

  @override
  State<BuildLeft> createState() => _BuildLeftState();
}

class _BuildLeftState extends State<BuildLeft> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var style = TextStyle(
        fontSize: size.width * 0.01,
        fontFamily: 'Biko',
        color: navyBlueColor,
        fontWeight: FontWeight.bold);
    return SizedBox(
      width: size.width * 0.4,
      height: size.height * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
            child: Text(
              'TOTAL INCOME  -  Monthly',
              style: style,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: SizedBox(
              height: size.height * 0.5,
              child: BuildBarChart(
                  year: widget.year,
                  january: widget.january,
                  febuary: widget.febuary,
                  march: widget.march,
                  april: widget.april,
                  may: widget.may,
                  june: widget.june,
                  july: widget.july,
                  august: widget.august,
                  september: widget.september,
                  october: widget.october,
                  november: widget.november,
                  december: widget.december,
                  january2: widget.january2,
                  febuary2: widget.febuary2,
                  march2: widget.march2,
                  april2: widget.april2,
                  may2: widget.may2,
                  june2: widget.june2,
                  july2: widget.july2,
                  august2: widget.august2,
                  september2: widget.september2,
                  october2: widget.october2,
                  november2: widget.november2,
                  december2: widget.december2),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: size.width * 0.02,
                      height: size.height * 0.02,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor2),
                    ),
                    SizedBox(width: size.width * 0.01),
                    Text(
                      'Income from Rooms',
                      style: TextStyle(
                        fontSize: size.width * 0.01,
                        color: navyBlueColor,
                      ),
                    )
                  ]),
              SizedBox(width: size.width * 0.05),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: size.width * 0.02,
                      height: size.height * 0.02,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                    ),
                    SizedBox(width: size.width * 0.01),
                    Text(
                      'Income from Lounge',
                      style: TextStyle(
                        fontSize: size.width * 0.01,
                        color: navyBlueColor,
                      ),
                    )
                  ]),
            ],
          ),
          SizedBox(height: size.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info, size: size.width * 0.015),
              SizedBox(width: size.width * 0.004),
              Text('Click on each month to view total income for that month.',
                  style: TextStyle(
                      color: navyBlueColor, fontSize: size.width * 0.012)),
            ],
          ),
        ],
      ),
    );
  }
}

class BuildBottom extends StatefulWidget {
  const BuildBottom({Key? key}) : super(key: key);

  @override
  State<BuildBottom> createState() => _BuildBottomState();
}

class _BuildBottomState extends State<BuildBottom> {
  final monthsOfBestSellers = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec',
    'nil'
  ];
  late int indexForMonthsOfBestSellers = 0;

  late Set drinks = {};
  late List drinks2 = [];
  late List drinks3 = [];
  late List totalDrinks = [];
  late num totalIncomeForItem = 0;

  // function to get each drink sold and their quantities sold respestively
  fetchDrinksSold(month, year) {
    drinks = {};
    drinks2 = [];
    drinks3 = [];
    totalDrinks = [];
    totalIncomeForItem = 0;
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
    for (var item in db.InvoicesRecord) {
      if (year == item['date'].split('-')[2]) {
        if (month == item['date'].split('-')[1]) {
          for (var item2 in item['cartalog']) {
            drinks.add(item2[0]);
          }
        }
      }
    }
    for (var data in drinks) {
      drinks3.add(data);
    }
    for (var item in drinks) {
      for (var item2 in db.InvoicesRecord) {
        if (year == item2['date'].split('-')[2]) {
          if (month == item2['date'].split('-')[1]) {
            for (var item3 in item2['cartalog']) {
              if (item3[0] == item) {
                drinks2.add(item3);
              }
            }
          }
        }
      }
    }
    for (var item in drinks) {
      totalIncomeForItem = 0;
      for (var item2 in drinks2.where((element) => element[0] == item)) {
        totalIncomeForItem += int.parse(item2[1]);
      }
      totalDrinks.add(totalIncomeForItem.toInt());
    }
    // print(totalDrinks);
    // print(totalDrinks.length);
  }

  List<charts.Series<chartmodel.BarChartModel, String>> _createSampleData() {
    var data = [
      for (var item1 in db.InvoicesRecord)
        for (var item2 in item1['cartalog'])
          chartmodel.BarChartModel(
              '${item2[0]}',
              totalDrinks[drinks3.indexOf(item2[0])],
              charts.ColorUtil.fromDartColor(primaryColor2))
    ];

    return [
      charts.Series(
          id: "Total Income",
          data: data,
          domainFn: (chartmodel.BarChartModel series, _) => series.month,
          measureFn: (chartmodel.BarChartModel series, _) => series.income,
          colorFn: (chartmodel.BarChartModel series, _) => series.color),
    ];
  }

  @override
  void initState() {
    super.initState();
    fetchDrinksSold(monthsOfBestSellers[indexForMonthsOfBestSellers], year);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var style = TextStyle(
        fontSize: size.width * 0.01,
        fontFamily: 'Biko',
        color: navyBlueColor,
        fontWeight: FontWeight.bold);
    return SizedBox(
      width: size.width * 0.9,
      height: size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
            child: Text(
              'Best Sellers (Drinks)  -  Monthly',
              style: style,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  monthsOfBestSellers[indexForMonthsOfBestSellers]
                      .toTitleCase(),
                  style: TextStyle(
                      fontFamily: 'Biko', fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            child: Text('Prev',
                                style: TextStyle(color: primaryColor)),
                            onPressed: () {
                              if (year != null && year != '') {
                                if (indexForMonthsOfBestSellers <
                                    monthsOfBestSellers.length - 1) {
                                  indexForMonthsOfBestSellers != 0
                                      ? setState(() {
                                          indexForMonthsOfBestSellers--;
                                          fetchDrinksSold(
                                              monthsOfBestSellers[
                                                  indexForMonthsOfBestSellers],
                                              year);
                                          _createSampleData();
                                        })
                                      : null;
                                }
                              }
                            }),
                        TextButton(
                            child: Text('Next',
                                style: TextStyle(color: primaryColor)),
                            onPressed: () {
                              if (year != null && year != '') {
                                if (indexForMonthsOfBestSellers <
                                    monthsOfBestSellers.length - 1) {
                                  indexForMonthsOfBestSellers != 11
                                      ? setState(() {
                                          indexForMonthsOfBestSellers++;
                                          fetchDrinksSold(
                                              monthsOfBestSellers[
                                                  indexForMonthsOfBestSellers],
                                              year);
                                          _createSampleData();
                                        })
                                      : null;
                                }
                              }
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: SizedBox(
              height: size.height * 0.5,
              child: drinks.isNotEmpty
                  ? BuildBarChart2(dataList: _createSampleData())
                  : Text('NIL', style: TextStyle(fontSize: size.width * 0.02)),
            ),
          ),
          SizedBox(height: size.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info, size: size.width * 0.015),
              SizedBox(width: size.width * 0.004),
              Text('Click on each drink to view total sold for that month.',
                  style: TextStyle(
                      color: navyBlueColor, fontSize: size.width * 0.012)),
            ],
          ),
        ],
      ),
    );
  }
}

// BarChart
class BuildBarChart extends StatefulWidget {
  BuildBarChart(
      {Key? key,
      required this.year,
      required this.january,
      required this.febuary,
      required this.march,
      required this.april,
      required this.may,
      required this.june,
      required this.july,
      required this.august,
      required this.september,
      required this.october,
      required this.november,
      required this.december,
      required this.january2,
      required this.febuary2,
      required this.march2,
      required this.april2,
      required this.may2,
      required this.june2,
      required this.july2,
      required this.august2,
      required this.september2,
      required this.october2,
      required this.november2,
      required this.december2})
      : super(key: key);
  final String year;
  late int january, january2;
  late int febuary, febuary2;
  late int march, march2;
  late int april, april2;
  late int may, may2;
  late int june, june2;
  late int july, july2;
  late int august, august2;
  late int september, september2;
  late int october, october2;
  late int november, november2;
  late int december, december2;

  @override
  _BuildBarChartState createState() => _BuildBarChartState();
}

class _BuildBarChartState extends State<BuildBarChart> {
  final random = Random();

  List<charts.Series<chartmodel.BarChartModel, String>> _createSampleData() {
    var data = [
      chartmodel.BarChartModel(
          'Jan', widget.january, charts.ColorUtil.fromDartColor(primaryColor2)),
      chartmodel.BarChartModel(
          'Feb', widget.febuary, charts.ColorUtil.fromDartColor(primaryColor2)),
      chartmodel.BarChartModel(
          'Mar', widget.march, charts.ColorUtil.fromDartColor(primaryColor2)),
      chartmodel.BarChartModel(
          'Apr', widget.april, charts.ColorUtil.fromDartColor(primaryColor2)),
      chartmodel.BarChartModel(
          'May', widget.may, charts.ColorUtil.fromDartColor(primaryColor2)),
      chartmodel.BarChartModel(
          'Jun', widget.june, charts.ColorUtil.fromDartColor(primaryColor2)),
      chartmodel.BarChartModel(
          'Jul', widget.july, charts.ColorUtil.fromDartColor(primaryColor2)),
      chartmodel.BarChartModel(
          'Aug', widget.august, charts.ColorUtil.fromDartColor(primaryColor2)),
      chartmodel.BarChartModel('Sep', widget.september,
          charts.ColorUtil.fromDartColor(primaryColor2)),
      chartmodel.BarChartModel(
          'Oct', widget.october, charts.ColorUtil.fromDartColor(primaryColor2)),
      chartmodel.BarChartModel('Nov', widget.november,
          charts.ColorUtil.fromDartColor(primaryColor2)),
      chartmodel.BarChartModel('Dec', widget.december,
          charts.ColorUtil.fromDartColor(primaryColor2)),
    ];
    var data2 = [
      chartmodel.BarChartModel(
          'Jan', widget.january2, charts.ColorUtil.fromDartColor(primaryColor)),
      chartmodel.BarChartModel(
          'Feb', widget.febuary2, charts.ColorUtil.fromDartColor(primaryColor)),
      chartmodel.BarChartModel(
          'Mar', widget.march2, charts.ColorUtil.fromDartColor(primaryColor)),
      chartmodel.BarChartModel(
          'Apr', widget.april2, charts.ColorUtil.fromDartColor(primaryColor)),
      chartmodel.BarChartModel(
          'May', widget.may2, charts.ColorUtil.fromDartColor(primaryColor)),
      chartmodel.BarChartModel(
          'Jun', widget.june2, charts.ColorUtil.fromDartColor(primaryColor)),
      chartmodel.BarChartModel(
          'Jul', widget.july2, charts.ColorUtil.fromDartColor(primaryColor)),
      chartmodel.BarChartModel(
          'Aug', widget.august2, charts.ColorUtil.fromDartColor(primaryColor)),
      chartmodel.BarChartModel('Sep', widget.september2,
          charts.ColorUtil.fromDartColor(primaryColor)),
      chartmodel.BarChartModel(
          'Oct', widget.october2, charts.ColorUtil.fromDartColor(primaryColor)),
      chartmodel.BarChartModel('Nov', widget.november2,
          charts.ColorUtil.fromDartColor(primaryColor)),
      chartmodel.BarChartModel('Dec', widget.december2,
          charts.ColorUtil.fromDartColor(primaryColor)),
    ];
    return [
      charts.Series(
          id: "Rooms",
          data: data,
          domainFn: (chartmodel.BarChartModel series, _) => series.month,
          measureFn: (chartmodel.BarChartModel series, _) => series.income,
          colorFn: (chartmodel.BarChartModel series, _) => series.color),
      charts.Series(
          id: "Lounge",
          data: data2,
          domainFn: (chartmodel.BarChartModel series, _) => series.month,
          measureFn: (chartmodel.BarChartModel series, _) => series.income,
          colorFn: (chartmodel.BarChartModel series, _) => series.color),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      _createSampleData(),
      selectionModels: [
        charts.SelectionModelConfig(
          changedListener: (model) async {
            if (year != null && year != '') {
              var id = model.selectedSeries[0].displayName;
              var monthIncome = model.selectedSeries[0]
                  .measureFn(model.selectedDatum[0].index)
                  .toString();
              var month = model.selectedSeries[0]
                  .domainFn(model.selectedDatum[0].index)
                  .toLowerCase();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: primaryColor2,
                  content: Text(
                      "Total income for ${month.toTitleCase()} $year, ($id): ${db.HotelCurrency.toUpperCase()} $monthIncome")));
              await Navigator.push(
                  context,
                  CustomPageRoute(
                      widget: Analysis2(
                    month: month,
                    year: year!,
                    isRoom: id == 'Rooms' ? true : false,
                  )));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: errorColor,
                  content: Text("No year selected!")));
            }
          },
        )
      ],
    );
  }
}

class BuildBarChart2 extends StatefulWidget {
  BuildBarChart2({Key? key, required this.dataList}) : super(key: key);
  var dataList;

  @override
  _BuildBarChart2State createState() => _BuildBarChart2State();
}

class _BuildBarChart2State extends State<BuildBarChart2> {
  final random = Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      widget.dataList,
      selectionModels: [
        charts.SelectionModelConfig(
          changedListener: (model) async {
            var totalSold = model.selectedSeries[0]
                .measureFn(model.selectedDatum[0].index)
                .toString();
            var itemName =
                model.selectedSeries[0].domainFn(model.selectedDatum[0].index);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: primaryColor2,
                content: Text("Total bottles of $itemName sold: $totalSold")));
          },
        )
      ],
    );
  }
}

// Inner Right Widget Class
class BuildRight extends StatefulWidget {
  BuildRight({Key? key, required this.indexForMonthsOfBestSellers})
      : super(key: key);
  late int indexForMonthsOfBestSellers;

  @override
  State<BuildRight> createState() => _BuildRightState();
}

class _BuildRightState extends State<BuildRight> {
  final monthsOfBestSellers = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec',
    'nil'
  ];

  List<charts.Series<chartmodel.PieChartModel, String>> _createSampleData2() {
    var data2 = [
      chartmodel.PieChartModel(
          '${chartmodel.standard}\nStandard',
          chartmodel.standard,
          charts.ColorUtil.fromDartColor(Colors.teal),
          Colors.teal),
      chartmodel.PieChartModel(
          '${chartmodel.executive}\nExecutive',
          chartmodel.executive,
          charts.ColorUtil.fromDartColor(Colors.yellow),
          Colors.yellow),
      chartmodel.PieChartModel(
          '${chartmodel.presidential}\nPresidential',
          chartmodel.presidential,
          charts.ColorUtil.fromDartColor(Colors.orange),
          Colors.orange),
    ];
    return [
      charts.Series(
          id: "Best Sellers",
          data: data2,
          domainFn: (chartmodel.PieChartModel series, _) =>
              chartmodel.map.isNotEmpty ? series.roomType : '',
          measureFn: (chartmodel.PieChartModel series, _) => series.total,
          colorFn: (chartmodel.PieChartModel series, _) => series.color),
    ];
  }

  downloadCustomersRecord() async {
    final downloadFilePathForCustomers =
        "${Directory.current.path}/downloads/customers.csv";
    late List liveData = [];
    late List liveData2 = [];

    final List customersHeader = [
      [
        'Customer ID',
        'First Name',
        'Last Name',
        'Gender',
        'Email Address',
        'Phone Number',
        'Mode of Identification',
        'ID Number',
        'Room Type',
        'Room Number',
        'Checkin',
        'Checkout',
        'Bill Type',
        'Discount',
        'Mode of Payment',
        'POS Ref/Confirmation',
        'Duration',
        'Total Paid (${db.HotelCurrency.toUpperCase()})'
      ]
    ];
    List<List<dynamic>> customersRow = [];

    await db.fetchCustomersRecord();
    int len = db.CustomersRecord.length + 1;
    for (var data in db.CustomersRecord) {
      liveData.add(data['customerid']);
      liveData.add(data['firstname']);
      liveData.add(data['lastname']);
      liveData.add(data['gender']);
      liveData.add(data['emailaddress']);
      liveData.add(data['phonenumber']);
      liveData.add(data['modeofidentification']);
      liveData.add(data['idnumber']);
      liveData.add(data['roomtype']);
      liveData.add(data['roomnumber']);
      liveData.add(data['checkindate']);
      liveData.add(data['checkoutdate']);
      liveData.add(data['billtype']);
      liveData.add(data['discount']);
      liveData.add(data['modeofpayment']);
      liveData.add(data['posreferenceorconfirmation']);
      liveData.add(data['duration']);
      liveData.add(data['totalcost']);
    }
    late var x = 0;
    late var y = 18;
    for (var i = 1; i < len; i += 1) {
      if (i == 1) {
        liveData2.add(liveData.sublist(x, y));
      } else if (i > 1) {
        x += 18;
        y += 18;
        liveData2.add(liveData.sublist(x, y));
      }
    }

    for (var data in customersHeader) {
      customersRow.add(data);
    }
    for (var data in liveData2) {
      customersRow.add(data);
    }
    String customersCsv = const ListToCsvConverter().convert(customersRow);
    try {
      File customersCsvFile = File(downloadFilePathForCustomers);
      await customersCsvFile.writeAsString(customersCsv);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: primaryColor2,
          content: Text("Operation succeeded..")));
    } on FileSystemException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: errorColor,
          content: Text("Please close 'customers.csv' first!")));
    }
  }

  @override
  void initState() {
    chartmodel.fetchBestSellers(
        monthsOfBestSellers[widget.indexForMonthsOfBestSellers], year);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var style = TextStyle(
        fontSize: size.width * 0.01,
        fontFamily: 'Biko',
        color: Colors.black,
        fontWeight: FontWeight.bold);
    return SizedBox(
      width: size.width * 0.4,
      height: size.height * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
            child: Text(
              'BEST SELLERS (Rooms)  -  Monthly',
              style: style,
            ),
          ),
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: size.width * 0.05),
                Text(
                  monthsOfBestSellers[widget.indexForMonthsOfBestSellers]
                      .toTitleCase(),
                  style: TextStyle(
                      fontSize: size.width * 0.01, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: size.width * 0.15),
                TextButton(
                  child: Text('Prev', style: TextStyle(color: primaryColor)),
                  onPressed: () {
                    if (year != null && year != '') {
                      if (widget.indexForMonthsOfBestSellers <
                          monthsOfBestSellers.length - 1) {
                        widget.indexForMonthsOfBestSellers != 0
                            ? setState(() {
                                widget.indexForMonthsOfBestSellers--;
                                chartmodel.fetchBestSellers(
                                    monthsOfBestSellers[
                                        widget.indexForMonthsOfBestSellers],
                                    year);
                                chartmodel.standard = chartmodel.map.isNotEmpty
                                    ? chartmodel.map['standard']
                                    : 0;
                                chartmodel.executive = chartmodel.map.isNotEmpty
                                    ? chartmodel.map['executive']
                                    : 0;
                                chartmodel.presidential =
                                    chartmodel.map.isNotEmpty
                                        ? chartmodel.map['presidential']
                                        : 0;
                              })
                            : null;
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: errorColor,
                          content: Text("No year selected!")));
                    }
                  },
                ),
                SizedBox(width: 4),
                Text('|'),
                SizedBox(width: 4),
                TextButton(
                  child: Text(
                    'Next',
                    style: TextStyle(color: primaryColor),
                  ),
                  onPressed: () {
                    if (year != null && year != '') {
                      if (widget.indexForMonthsOfBestSellers <
                          monthsOfBestSellers.length - 1) {
                        widget.indexForMonthsOfBestSellers != 11
                            ? setState(() {
                                widget.indexForMonthsOfBestSellers++;
                                chartmodel.fetchBestSellers(
                                    monthsOfBestSellers[
                                        widget.indexForMonthsOfBestSellers],
                                    year);
                                chartmodel.standard = chartmodel.map.isNotEmpty
                                    ? chartmodel.map['standard']
                                    : 0;
                                chartmodel.executive = chartmodel.map.isNotEmpty
                                    ? chartmodel.map['executive']
                                    : 0;
                                chartmodel.presidential =
                                    chartmodel.map.isNotEmpty
                                        ? chartmodel.map['presidential']
                                        : 0;
                              })
                            : null;
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: errorColor,
                          content: Text("No year selected!")));
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Center(
              child: SizedBox(
                height: size.height * 0.4,
                child: BuildPieChart(data: _createSampleData2()),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [chartmodel.Indicators()],
          ),
          SizedBox(height: size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info, size: size.width * 0.015),
              SizedBox(width: size.width * 0.002),
              Text('Download customer records?',
                  style: TextStyle(
                      color: navyBlueColor, fontSize: size.width * 0.012)),
              SizedBox(width: size.width * 0.004),
              TextButton(
                child: Text(
                  'Download',
                  style: TextStyle(
                      color: primaryColor, fontSize: size.width * 0.012),
                ),
                onPressed: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Center(child: CircularProgressIndicator());
                      });
                  await downloadCustomersRecord();
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BuildPieChart extends StatefulWidget {
  BuildPieChart({Key? key, required this.data}) : super(key: key);
  var data;

  @override
  State<BuildPieChart> createState() => _BuildPieChartState();
}

class _BuildPieChartState extends State<BuildPieChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return AspectRatio(
      aspectRatio: 2.0,
      child: charts.PieChart(widget.data,
          defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [
            charts.ArcLabelDecorator(
                labelPosition: chartmodel.map.isNotEmpty
                    ? charts.ArcLabelPosition.inside
                    : charts.ArcLabelPosition.outside)
          ])),
    );
  }
}
