// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/title_case.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/main.dart';
import 'package:JoGenics/screens/Home/AdminHome/body.dart';
import 'package:flutter/material.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:intl/intl.dart';

class Analysis2 extends StatefulWidget {
  const Analysis2({Key? key, required this.month, required this.year})
      : super(key: key);
  final String month, year;

  @override
  State<Analysis2> createState() => _Analysis2State();
}

class _Analysis2State extends State<Analysis2> {
  late DateTime dateOfIncome = DateTime.now();
  late String date1 = '';
  late String date2 = '';
  String convertDateTimeDisplay1(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    date2 = formatted;
    return date2;
  }

  String convertDateTimeDisplay1b(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    date1 = formatted;
    return date1;
  }

  num totalIncome = 0;
  late var startDate;
  late var endDate;
  fetchDailyIncome(date, month, year) {
    final List monthList = [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12'
    ];
    late List monthlyData = [];
    totalIncome = 0;
    if (month == 'jan') {
      month = monthList[0];
    } else if (month == 'feb') {
      month = monthList[1];
    } else if (month == 'mar') {
      month = monthList[2];
    } else if (month == 'apr') {
      month = monthList[3];
    } else if (month == 'may') {
      month = monthList[4];
    } else if (month == 'jun') {
      month = monthList[5];
    } else if (month == 'jul') {
      month = monthList[6];
    } else if (month == 'aug') {
      month = monthList[7];
    } else if (month == 'sep') {
      month = monthList[8];
    } else if (month == 'oct') {
      month = monthList[9];
    } else if (month == 'nov') {
      month = monthList[10];
    } else if (month == 'dec') {
      month = monthList[11];
    }

    for (var data in db.CustomersRecord) {
      if (year == data['checkindate'].split('-')[2]) {
        if (month == data['checkindate'].split('-')[1]) {
          monthlyData.add(data);
        }
      }
    }
    startDate = DateTime(int.parse(year), int.parse(month), 01);
    endDate = DateTime(int.parse(year), int.parse(month) + 1);

    for (var data in monthlyData) {
      if (date == data['checkindate']) {
        totalIncome += int.parse(data['totalcost']);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    convertDateTimeDisplay1(dateOfIncome.toString());
    convertDateTimeDisplay1b(dateOfIncome.toString());
    fetchDailyIncome(date1, widget.month, widget.year);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MainWindowNavigation(
        leftChild: buildLeftChild(
            fullname: db.CurrentLoggedInUserLastname != ''
                ? db.CurrentLoggedInUserLastname.toTitleCase()
                : db.CurrentLoggedInUserLastname,
            emailaddress: db.CurrentLoggedInUserEmail,
            selected0: false,
            selected1: false,
            selected2: false,
            selected3: false,
            selected4: true,
            selected5: false,
            selected6: false,
            selectedPage: () => null),
        rightChild: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/money.jpg'),
                  fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: whiteColor2,
            appBar: buildAppBar(context, 'Daily Analysis', blackColor, false),
            body: Center(
                child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                Container(
                  width: size.width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * 0.005),
                    border: Border.all(color: transparentColor, width: 2),
                    color: whiteColor,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.edit_location_rounded,
                            color: primaryColor),
                        title: Text('Search by date ($date2)',
                            style: TextStyle(color: Colors.black54)),
                        trailing: IconButton(
                          icon: Icon(Icons.calendar_month_rounded,
                              color: primaryColor),
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: startDate,
                                    firstDate: startDate!,
                                    lastDate: endDate!)
                                .then((date) => setState(() {
                                      dateOfIncome = date!;
                                      convertDateTimeDisplay1(
                                          dateOfIncome.toString());
                                      fetchDailyIncome(
                                          date2, widget.month, widget.year);
                                    }));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.07),
                Container(
                  height: size.height * 0.6,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * 0.02),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        primaryColor,
                        primaryColor2,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.month.toTitleCase(), style: TextStyle(fontFamily: 'Biko', fontSize: size.width*0.02, color: whiteColor)),
                      SizedBox(height: size.height * 0.015),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          child: Divider()),
                      SizedBox(height: size.height * 0.015),
                      CircleAvatar(
                        radius: size.width * 0.08,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/money5.jpg'),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          child: Divider()),
                      SizedBox(height: size.height * 0.015),
                      Text(
                          "${db.HotelCurrency.toUpperCase()} ${totalIncome as int}",
                          style: TextStyle(
                              fontFamily: 'Biko',
                              fontSize: size.width * 0.03,
                              color: whiteColor,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
        isLogout: false);
  }
}
