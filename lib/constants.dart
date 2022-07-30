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
const double currentV = 1.1;
bool? isAdmin;
String? hotel;
String? gender;
String? lounge;
String? waiter;
String? category;
String? subCategory;
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
bool? isSearchInventory;
bool? isSearchInventory2;
bool? isCartalog;
String? isSearchCustomerCheckOut;
String? isSearchEmployeeTimeStamp1;
String? isSearchInvoice;
String? isSearchCustomers;
bool? calculateClicked;
bool? isSearchForUpdate;
bool? isSearchForDelete;
String? tutorialQuestion;

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
  final int daysLeft;
  var today = int.parse(fetchTodaysDate().split('-')[0]);
  var subDateDay = int.parse(db.SubscriptionDate.split('-')[0]);
  var subDateMonth = int.parse(db.SubscriptionDate.split('-')[1]);
  // var subDateYear = int.parse(db.SubscriptionDate.split('-')[2]);
  var subExpiryDateDay = int.parse(db.SubscriptionExpiryDate.split('-')[0]);
  var subExpiryDateMonth = int.parse(db.SubscriptionExpiryDate.split('-')[1]);
  // var subExpiryDateYear = int.parse(db.SubscriptionExpiryDate.split('-')[2]);
  if (subExpiryDateMonth - subDateMonth == 1) {
    daysLeft = subExpiryDateDay+30 - today;
  } else if (subExpiryDateMonth - subDateMonth == 2) {
    daysLeft = (subExpiryDateDay + 60) - today;
  } else if (subExpiryDateMonth - subDateMonth == 3) {
    daysLeft = (subExpiryDateDay + 90) - today;
  } else if (subExpiryDateMonth - subDateMonth == 4) {
    daysLeft = (subExpiryDateDay + 120) - today;
  } else if (subExpiryDateMonth - subDateMonth == 5) {
    daysLeft = (subExpiryDateDay + 150) - today;
  } else if (subExpiryDateMonth - subDateMonth == 6) {
    daysLeft = (subExpiryDateDay + 180) - today;
  } else if (subExpiryDateMonth - subDateMonth == 7) {
    daysLeft = (subExpiryDateDay + 210) - today;
  } else if (subExpiryDateMonth - subDateMonth == 8) {
    daysLeft = (subExpiryDateDay + 240) - today;
  } else if (subExpiryDateMonth - subDateMonth == 9) {
    daysLeft = (subExpiryDateDay + 270) - today;
  } else if (subExpiryDateMonth - subDateMonth == 10) {
    daysLeft = (subExpiryDateDay + 300) - today;
  } else if (subExpiryDateMonth - subDateMonth == 11) {
    daysLeft = (subExpiryDateDay + 330) - today;
  } else if (subExpiryDateMonth - subDateMonth == 12) {
    daysLeft = (subExpiryDateDay + 360) - today;
  } else {
    daysLeft = subExpiryDateDay - subDateDay;
  }
  // var daysleft = (int.parse(subDate)) - int.parse(today);
  return daysLeft;
}
