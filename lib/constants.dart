import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:JoGenics/db.dart' as db;

const primaryColor = Color.fromARGB(255, 112, 219, 174);
const primaryColor2 = Color.fromARGB(255, 58, 113, 90);
const primaryColor2b = Color.fromARGB(156, 58, 113, 90);
const primaryLightColor = Color.fromARGB(255, 171, 253, 219);
const primaryLightColor2 = Color.fromARGB(255, 176, 222, 215);
const errorColor = Colors.red;
const blackColor = Colors.black;
const whiteColor = Colors.white;
const whiteColor2 = Color.fromARGB(209, 255, 255, 255);
const whiteColor3 = Color.fromARGB(150, 255, 255, 255);
const navyBlueColor = Color.fromARGB(255, 26, 34, 46);
const transparentColor = Colors.transparent;
const transparentColor2 = Color.fromARGB(77, 0, 0, 0);
const customBackgroundColor = Color.fromARGB(255, 242, 242, 242);
const double currentV = 1.0;
String? hotel;
String? gender;
String? nationality;
String? stateOfOrigin;
String? identification;
String? room;
String? roomno;
String? bill;
String? posRefOrConfirmation;
String? designation;
String? securityQ;
String? securityQ2;
String? selectedField;
String? year;
bool usePrefilledData = false;
bool? isSearchAdmin;
bool? isSearchEmployee;
bool? isSearchCustomerCheckOut;
String? isSearchEmployeeTimeStamp1;
// bool? isSearchEmployeeTimeStamp2;
String? isSearchCustomers;
bool? calculateClicked;
bool? isSearchForUpdate;
bool? isSearchForDelete;

fetchTodaysDate() {
  DateTime today = DateTime.now();
  DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  DateFormat serverFormater = DateFormat('dd-MM-yyyy');
  DateTime displayDate = displayFormater.parse(today.toString());
  String formatted = serverFormater.format(displayDate);
  return formatted;
}

fetchNextMonthDate() {
  DateTime today = DateTime.now();
  DateTime nextMonth = DateTime(today.year, today.month + 1, today.day);
  DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  DateFormat serverFormater = DateFormat('dd-MM-yyyy');
  DateTime displayDate = displayFormater.parse(nextMonth.toString());
  String formatted = serverFormater.format(displayDate);
  return formatted;
}

fetchSubscriptionDaysLeft() {
  var today = fetchTodaysDate().split('-')[0];
  var subDate = db.SubscriptionDate.split('-')[0];
  var daysleft = (int.parse(subDate) + 30) - int.parse(today);
  return daysleft;
}
