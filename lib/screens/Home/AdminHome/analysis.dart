// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, must_be_immutable, library_private_types_in_public_api, prefer_typing_uninitialized_variables

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
    // '2022',
    // '2023',
    // '2024',
    // '2025',
    // '2026',
    // '2027',
    // '2028',
    // '2029',
    // '2030',
    // '2031',
    // '2032',
    // '2033',
    // '2034',
    // '2035'
  };
  DropdownMenuItem<String> buildYears(String Year) => DropdownMenuItem(
      value: Year,
      child: Text(
        Year,
      ));

  // Income for each month
  late int january = 0;
  late int febuary = 0;
  late int march = 0;
  late int april = 0;
  late int may = 0;
  late int june = 0;
  late int july = 0;
  late int august = 0;
  late int september = 0;
  late int october = 0;
  late int november = 0;
  late int december = 0;

  fetchYears() {
    // late List years = [];
    for (var data in db.CustomersRecord) {
      years.add(data['checkindate'].split('-')[2]);
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
                    leading: Icon(Icons.numbers, color: primaryColor),
                    title: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text('Year'),
                        // isExpanded: true,
                        value: year,
                        iconSize: size.width * 0.02,
                        items: years.map(buildYears).toList(),
                        onChanged: (value) async => setState(() {
                          year = value;
                          fetchIncome(year);
                          chartmodel.fetchBestSellers('jan', year);
                        }),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              db.CustomersRecord.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : Row(
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
                            december: december),
                        BuildRight(
                            indexForMonthsOfBestSellers:
                                indexForMonthsOfBestSellers),
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
      required this.december})
      : super(key: key);
  final String year;
  late int january;
  late int febuary;
  late int march;
  late int april;
  late int may;
  late int june;
  late int july;
  late int august;
  late int september;
  late int october;
  late int november;
  late int december;

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
        color: Colors.black,
        fontWeight: FontWeight.bold);
    return SizedBox(
      width: size.width * 0.4,
      height: size.height * 0.75,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.05),
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
                  december: widget.december),
            ),
          ),
          SizedBox(height: size.height * 0.04),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
            child: Row(
              children: [
                Icon(Icons.info, size: size.width * 0.015),
                SizedBox(width: size.width * 0.004),
                Text('Click on each month to view total income for that month.',
                    style: TextStyle(
                        color: navyBlueColor, fontSize: size.width * 0.012)),
              ],
            ),
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
      required this.december})
      : super(key: key);
  final String year;
  late int january;
  late int febuary;
  late int march;
  late int april;
  late int may;
  late int june;
  late int july;
  late int august;
  late int september;
  late int october;
  late int november;
  late int december;

  @override
  _BuildBarChartState createState() => _BuildBarChartState();
}

class _BuildBarChartState extends State<BuildBarChart> {
  final random = Random();

  List<charts.Series<chartmodel.BarChartModel, String>> _createSampleData() {
    var data = [
      chartmodel.BarChartModel('Jan', widget.january,
          charts.ColorUtil.fromDartColor(Colors.orangeAccent)),
      chartmodel.BarChartModel(
          'Feb', widget.febuary, charts.ColorUtil.fromDartColor(Colors.red)),
      chartmodel.BarChartModel(
          'Mar', widget.march, charts.ColorUtil.fromDartColor(Colors.green)),
      chartmodel.BarChartModel(
          'Apr', widget.april, charts.ColorUtil.fromDartColor(Colors.yellow)),
      chartmodel.BarChartModel('May', widget.may,
          charts.ColorUtil.fromDartColor(Colors.lightBlueAccent)),
      chartmodel.BarChartModel(
          'Jun', widget.june, charts.ColorUtil.fromDartColor(Colors.pink)),
      chartmodel.BarChartModel(
          'Jul', widget.july, charts.ColorUtil.fromDartColor(Colors.indigo)),
      chartmodel.BarChartModel(
          'Aug', widget.august, charts.ColorUtil.fromDartColor(Colors.brown)),
      chartmodel.BarChartModel(
          'Sep', widget.september, charts.ColorUtil.fromDartColor(Colors.lime)),
      chartmodel.BarChartModel(
          'Oct', widget.october, charts.ColorUtil.fromDartColor(Colors.purple)),
      chartmodel.BarChartModel('Nov', widget.november,
          charts.ColorUtil.fromDartColor(Colors.deepOrangeAccent)),
      chartmodel.BarChartModel('Dec', widget.december,
          charts.ColorUtil.fromDartColor(Colors.greenAccent)),
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
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      _createSampleData(),
      selectionModels: [
        charts.SelectionModelConfig(
          changedListener: (model) async {
            // setState(() {
            //   var totalIncome = model.selectedSeries[0]
            //       // .domainFn(model.selectedDatum[0].index)
            //       .measureFn(model.selectedDatum[0].index)
            //       .toString();
            //   ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(content: Text("Total income: $totalIncome")));
            // });
            if (year != null && year != '') {
              var month = model.selectedSeries[0]
                  .domainFn(model.selectedDatum[0].index)
                  .toLowerCase();
              await Navigator.push(
                  context,
                  CustomPageRoute(
                      widget: Analysis2(month: month, year: year!)));
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
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.05),
            child: Text(
              'BEST SELLERS  -  Monthly',
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
            child: Row(
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
                  onPressed: () async {},
                ),
              ],
            ),
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
