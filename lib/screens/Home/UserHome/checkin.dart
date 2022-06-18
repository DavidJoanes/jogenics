// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print, unused_catch_clause, use_build_context_synchronously
import 'package:mongo_dart/mongo_dart.dart' show Db;
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/db.dart' as db;
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:JoGenics/components/countries.dart' as fetchcountries;
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/constants.dart';
import 'package:flutter/material.dart';
// import 'package:jiffy/jiffy.dart';

class CheckIn extends StatefulWidget {
  const CheckIn({Key? key}) : super(key: key);

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  final random = Random();
  final _formKey = GlobalKey<FormState>();
  final _formKeySearch = GlobalKey<FormState>();
  final _formKeyPOS_Confirmation = GlobalKey<FormState>();
  final customerIDController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final idController = TextEditingController();
  final discountController = TextEditingController();
  final posRefController = TextEditingController();

  late String customerID = '';
  late String countryCode = '';
  late DateTime timeStamp;
  late DateTime checkInDate = DateTime.now();
  late DateTime checkOutDate = DateTime.now();
  late String timestampDate = '';
  late String timestampHourMinSec = '';
  late String checkin1 = '';
  late String checkin2 = '';
  late DateTime checkin3;
  late String checkout1 = '';
  late String checkout2 = '';
  late DateTime checkout3;
  late int duration = 0;
  late int totalCost = 0;

  generateCustomerID() async {
    setState(() {
      isSearchForUpdate = false;
    });
    var id = random.nextInt(db.SubscriptionPackage == 'standard'
        ? 1000000
        : db.SubscriptionPackage == 'basic'
            ? 1000
            : 100);
    try {
      if (await db.checkForValidCustomerId(id.toString()) == false) {
        // await generateCustomerID();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return dialog.ReturnDialog4(
                title: Text('Error'),
                message:
                    'Invalid customer id! It is possible that your customer database is full. If error persist after multiple refresh, you may have to purchase the standard package.',
                color: errorColor,
                button1Text: 'Cancel',
                onPressed1: () {
                  Navigator.of(context).pop();
                },
                button2Text: 'Refresh',
                onPressed2: () async {
                  Navigator.of(context).pop();
                  await generateCustomerID();
                },
              );
            });
      } else {
        setState(() {
          customerID = id.toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: primaryColor2,
            content: Text("Customer id generated successfully..")));
      }
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: errorColor,
          content: Text("No internet connection!")));
    }
  }

  final genders = {'', 'MALE', 'FEMALE', 'OTHERS'};
  DropdownMenuItem<String> buildGenders(String Gender) => DropdownMenuItem(
      value: Gender,
      child: Text(
        Gender,
      ));

  final nationalities = {''};
  getCountries() async {
    for (var data in fetchcountries.countries) {
      nationalities.add(data['name']!.toUpperCase());
    }
  }

  DropdownMenuItem<String> buildNationalities(String Nationality) =>
      DropdownMenuItem(
          value: Nationality,
          child: Text(
            Nationality,
          ));

  late var states = {''};
  getProvinces(country) {
    List liveData = [];
    liveData.clear();
    states = {''};
    stateOfOrigin = null;
    for (var data in fetchcountries.provinces) {
      if (country == data['countryName']) {
        liveData.add(data['regions']);
        for (var regions in liveData[0]) {
          states.add(regions['name'].toUpperCase());
        }
      }
    }
    return liveData;
  }

  DropdownMenuItem<String> buildStates(String state) => DropdownMenuItem(
      value: state,
      child: Text(
        state,
      ));

  getCountryCodes(country) {
    List liveData2 = [];
    liveData2.clear();
    countryCode = '';
    for (var data in fetchcountries.countries_and_phone_codes) {
      if (country == data['name']) {
        countryCode = data['dial_code'].toString();
      }
    }
  }

  final identificationCards = {
    '',
    'INTERNATIONAL PASSPORT',
    'NATIONAL IDENTITY CARD',
    // "Voter's card",
    // "Driver's liscense",
    // "Others"
  };
  DropdownMenuItem<String> buildIDs(String id) => DropdownMenuItem(
      value: id,
      child: Text(
        id,
      ));

  final rooms = {
    '',
    'STANDARD',
    'EXECUTIVE',
    "PRESIDENTIAL",
  };
  DropdownMenuItem<String> buildRooms(String room) => DropdownMenuItem(
      value: room,
      child: Text(
        room,
      ));

  late var roomnumbers = {
    '',
  };
  late List rn = [];
  generateRoomNumbers1() async {
    roomnumbers = {''};
    rn = [for (var i = 1; i < 101; i += 1) i];
    for (var data in rn) {
      roomnumbers.add(data.toString());
    }
  }

  generateRoomNumbers2() async {
    roomnumbers = {''};
    rn = [for (var i = 1; i < 101; i += 1) i];
    var source = rn.toList();
    try {
      final database = await Db.create(db.db_url);
      await database.open();
      final dbClient = database.collection(db.db_collection_customers);

      final check = await dbClient.find().toList();
      if (check.isNotEmpty) {
        for (var num in source) {
          for (var data in check) {
            if (room!.toLowerCase() == data['roomtype'] &&
                num.toString() == data['roomnumber']) {
              print('found');
              setState(() {
                rn.remove(num);
              });
            }
          }
        }
      }
      for (var numbers in rn) {
        roomnumbers.add(numbers.toString());
      }
      print('done');
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: errorColor,
          content: Text("No internet connection!")));
    }
  }

  DropdownMenuItem<String> buildRoomNumbers(String RoomNo) => DropdownMenuItem(
      value: RoomNo,
      child: Text(
        RoomNo,
      ));

  String convertDateTimeDisplay1(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    checkin1 = formatted;
    return checkin1;
  }

  String convertDateTimeDisplay1b(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    checkin2 = formatted;
    return checkin2;
  }

  reconvertCheckindate() {
    var splitted = checkin1.split('-');
    var splittedYear = int.parse(splitted[2]);
    var splittedMonth = int.parse(splitted[1]);
    var splittedDay = int.parse(splitted[0]);
    checkin3 = DateTime(splittedYear, splittedMonth, splittedDay);
    return checkin3;
  }

  reconvertCheckoutdate() {
    var splitted = checkout1.split('-');
    var splittedYear = int.parse(splitted[2]);
    var splittedMonth = int.parse(splitted[1]);
    var splittedDay = int.parse(splitted[0]);
    checkout3 = DateTime(splittedYear, splittedMonth, splittedDay);
    return checkout3;
  }

  String convertDateTimeDisplay2(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    checkout1 = formatted;
    return checkout1;
  }

  String convertDateTimeDisplay2b(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    checkout2 = formatted;
    return checkout2;
  }

  String convertDateTimeDisplay3() {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat FormaterDayMonthYear = DateFormat('dd-MM-yyyy');
    final DateFormat FormaterHourMinuteSeconds = DateFormat('HH:mm:ss');
    final DateTime displayDate = displayFormater.parse(timeStamp.toString());
    final String formattedDMY = FormaterDayMonthYear.format(displayDate);
    final String formattedHMS = FormaterHourMinuteSeconds.format(displayDate);
    timestampDate = formattedDMY;
    timestampHourMinSec = formattedHMS;
    return timestampDate;
  }

  final billTypes = {
    '',
    'NO DISCOUNT',
    'DISCOUNTED',
  };
  DropdownMenuItem<String> buildBillTypes(String billtype) => DropdownMenuItem(
      value: billtype,
      child: Text(
        billtype,
      ));

  final modesOfPayment = {
    '',
    'CASH',
    'POS',
    'TRANSFER',
  };
  DropdownMenuItem<String> buildModesOfPayment(String mode) => DropdownMenuItem(
      value: mode,
      child: Text(
        mode,
      ));

  calculateDurationAndCost(selectedroomrate, discount) {
    int days = checkOutDate.difference(checkInDate).inDays + 1;
    num total =
        (days * selectedroomrate) - (discount == '' ? 0 : int.parse(discount));
    setState(() {
      duration = days;
      totalCost = total as int;
    });
  }

  @override
  void initState() {
    isSearchForUpdate = null;
    calculateClicked = null;
    gender = null;
    nationality = null;
    stateOfOrigin = null;
    identification = null;
    room = null;
    roomno = null;
    bill = null;
    posRefOrConfirmation = null;
    convertDateTimeDisplay1(checkInDate.toString());
    convertDateTimeDisplay1b(checkInDate.toString());
    convertDateTimeDisplay2(checkOutDate.toString());
    convertDateTimeDisplay2b(checkOutDate.toString());
    reconvertCheckindate();
    reconvertCheckoutdate();
    generateCustomerID();
    generateRoomNumbers1();
    getCountries();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    idController.dispose();
    discountController.dispose();
    posRefController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: customBackgroundColor,
        appBar: buildAppBar(context, 'Check In', blackColor, true),
        body: SizedBox(
          height: size.height * 0.9,
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: size.height * 0.02),
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Form(
                                  key: _formKeySearch,
                                  child: RoundedInputFieldMain(
                                      controller: customerIDController,
                                      width: size.width * 0.3,
                                      horizontalGap: size.width * 0.01,
                                      verticalGap: size.height * 0.001,
                                      radius: size.width * 0.005,
                                      mainText: '',
                                      labelText: 'Search by customer id',
                                      icon: Icons.perm_identity_rounded,
                                      isEnabled: true,
                                      onChanged: (value) {
                                        value =
                                            customerIDController.text.trim();
                                      }),
                                ),
                                SizedBox(width: size.width * 0.01),
                                Text('ID: $customerID',
                                    style: TextStyle(
                                        fontSize: size.width * 0.01,
                                        fontFamily: 'Biko')),
                                SizedBox(width: size.width * 0.02),
                                RoundedButtonSearch(
                                    color: primaryColor,
                                    size: size.width * 0.025,
                                    onPressed: () async {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Please wait..")));
                                      if (await db.fetchCustomer(
                                              customerIDController.text) ==
                                          true) {
                                        setState(() {
                                          isSearchForUpdate = true;
                                          customerID = '';
                                          firstNameController.text =
                                              db.CustomerRecordForUpdate[0]
                                                  ['firstname'];
                                          lastNameController.text =
                                              db.CustomerRecordForUpdate[0]
                                                  ['lastname'];
                                          gender = db.CustomerRecordForUpdate[0]
                                                  ['gender']
                                              .toUpperCase();
                                          // nationality = db
                                          //     .CustomerRecordForUpdate[0]
                                          //         ['nationality']
                                          //     .toUpperCase();
                                          // stateOfOrigin = db
                                          //     .CustomerRecordForUpdate[0]
                                          //         ['stateoforigin']
                                          //     .toUpperCase();
                                          emailController.text =
                                              db.CustomerRecordForUpdate[0]
                                                  ['emailaddress'];
                                          phoneController.text =
                                              db.CustomerRecordForUpdate[0]
                                                  ['phonenumber'];
                                          identification = db
                                              .CustomerRecordForUpdate[0]
                                                  ['modeofidentification']
                                              .toUpperCase();
                                          idController.text =
                                              db.CustomerRecordForUpdate[0]
                                                  ['idnumber'];
                                          room = db.CustomerRecordForUpdate[0]
                                                  ['roomtype']
                                              .toUpperCase();
                                          roomno = db.CustomerRecordForUpdate[0]
                                              ['roomnumber'];
                                          checkin1 =
                                              db.CustomerRecordForUpdate[0]
                                                  ['checkindate'];
                                          checkout1 =
                                              db.CustomerRecordForUpdate[0]
                                                  ['checkoutdate'];
                                          bill = db.CustomerRecordForUpdate[0]
                                                  ['billtype']
                                              .toUpperCase();
                                          discountController.text =
                                              db.CustomerRecordForUpdate[0]
                                                  ['discount'];
                                          posRefOrConfirmation = db
                                              .CustomerRecordForUpdate[0]
                                                  ['modeofpayment']
                                              .toUpperCase();
                                          posRefController.text = db
                                                  .CustomerRecordForUpdate[0]
                                              ['posreferenceorconfirmation'];
                                          duration = int.parse(
                                              db.CustomerRecordForUpdate[0]
                                                  ['duration']);
                                          totalCost = int.parse(
                                              db.CustomerRecordForUpdate[0]
                                                  ['totalcost']);
                                          reconvertCheckindate();
                                          reconvertCheckoutdate();
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: errorColor,
                                                content: Text(
                                                    "Invalid customer id!")));
                                      }
                                    }),
                                SizedBox(width: size.width * 0.02),
                                RoundedButtonRefresh(
                                    color: primaryColor,
                                    size: size.width * 0.025,
                                    onPressed: () async {
                                      await generateCustomerID();
                                    }),
                              ],
                            ),
                            SizedBox(height: size.height * 0.05),
                            RoundedInputFieldMain(
                                controller: firstNameController,
                                width: size.width * 0.5,
                                horizontalGap: size.width * 0.01,
                                verticalGap: size.height * 0.001,
                                radius: size.width * 0.005,
                                mainText: '',
                                labelText: 'First name',
                                icon: Icons.person,
                                isEnabled: true,
                                onChanged: (value) {
                                  value = firstNameController.text.trim();
                                }),
                            SizedBox(height: size.height * 0.02),
                            RoundedInputFieldMain(
                                controller: lastNameController,
                                width: size.width * 0.5,
                                horizontalGap: size.width * 0.01,
                                verticalGap: size.height * 0.001,
                                radius: size.width * 0.005,
                                mainText: '',
                                labelText: 'Last name',
                                icon: Icons.person,
                                isEnabled: true,
                                onChanged: (value) {
                                  value = lastNameController.text.trim();
                                }),
                            SizedBox(height: size.height * 0.025),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.005),
                                border: Border.all(
                                    color: transparentColor, width: 2),
                                color: whiteColor,
                              ),
                              child: ListTile(
                                leading: Icon(
                                    Icons.supervised_user_circle_rounded,
                                    color: primaryColor),
                                title: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text('Gender'),
                                    isExpanded: true,
                                    value: gender,
                                    iconSize: 30,
                                    items: genders.map(buildGenders).toList(),
                                    onChanged: (value) async => setState(() {
                                      gender = value;
                                    }),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(height: size.height * 0.025),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     borderRadius:
                            //         BorderRadius.circular(size.width * 0.005),
                            //     border: Border.all(
                            //         color: transparentColor, width: 2),
                            //     color: whiteColor,
                            //   ),
                            //   child: ListTile(
                            //     leading: Icon(Icons.edit_location_alt_rounded,
                            //         color: primaryColor),
                            //     title: DropdownButtonHideUnderline(
                            //       child: DropdownButton<String>(
                            //         hint: Text('Nationality'),
                            //         isExpanded: true,
                            //         value: nationality,
                            //         iconSize: 30,
                            //         items: nationalities
                            //             .map(buildNationalities)
                            //             .toList(),
                            //         onChanged: (value) async => setState(() {
                            //           nationality = value;
                            //           getProvinces(nationality ?? '');
                            //           getCountryCodes(nationality ?? '');
                            //         }),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: size.height * 0.025),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     borderRadius:
                            //         BorderRadius.circular(size.width * 0.005),
                            //     border: Border.all(
                            //         color: transparentColor, width: 2),
                            //     color: whiteColor,
                            //   ),
                            //   child: ListTile(
                            //     leading: Icon(Icons.edit_location_rounded,
                            //         color: primaryColor),
                            //     title: DropdownButtonHideUnderline(
                            //       child: DropdownButton<String>(
                            //         hint: Text('State of origin'),
                            //         isExpanded: true,
                            //         value: stateOfOrigin,
                            //         iconSize: 30,
                            //         items: states.map(buildStates).toList(),
                            //         onChanged: (value) async => setState(() {
                            //           stateOfOrigin = value;
                            //         }),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: size.height * 0.03),
                            RoundedInputFieldMain(
                                controller: emailController,
                                width: size.width * 0.5,
                                horizontalGap: size.width * 0.01,
                                verticalGap: size.height * 0.001,
                                radius: size.width * 0.005,
                                mainText: '',
                                labelText: 'Email address',
                                icon: Icons.email,
                                isEnabled: true,
                                onChanged: (value) {
                                  value = emailController.text.trim();
                                }),
                            SizedBox(height: size.height * 0.01),
                            RoundedInputField3b(
                              width: size.width * 0.5,
                              radius: size.width * 0.005,
                              controller: phoneController,
                              hideText: false,
                              mainText: countryCode,
                              hintText: "Phone number",
                              warningText: 'Enter a valid phone number!',
                              icon: Icons.numbers,
                              onChanged: (value) {
                                value = phoneController.text.trim();
                              },
                            ),
                            SizedBox(height: size.height * 0.01),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.005),
                                border: Border.all(
                                    color: transparentColor, width: 2),
                                color: whiteColor,
                              ),
                              child: ListTile(
                                leading: Icon(Icons.perm_identity_rounded,
                                    color: primaryColor),
                                title: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text('Mode of identification'),
                                    isExpanded: true,
                                    value: identification,
                                    iconSize: 30,
                                    items: identificationCards
                                        .map(buildIDs)
                                        .toList(),
                                    onChanged: (value) async => setState(() {
                                      identification = value;
                                    }),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            RoundedInputFieldMain(
                                controller: idController,
                                width: size.width * 0.5,
                                horizontalGap: size.width * 0.01,
                                verticalGap: size.height * 0.001,
                                radius: size.width * 0.005,
                                mainText: '',
                                labelText: 'ID number',
                                icon: Icons.numbers,
                                isEnabled: true,
                                onChanged: (value) {
                                  value = idController.text.trim();
                                }),
                            SizedBox(height: size.height * 0.02),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.005),
                                border: Border.all(
                                    color: transparentColor, width: 2),
                                color: whiteColor,
                              ),
                              child: ListTile(
                                leading: Icon(Icons.room_preferences_rounded,
                                    color: primaryColor),
                                title: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      hint: Text('Room type'),
                                      isExpanded: true,
                                      value: room,
                                      iconSize: 30,
                                      items: rooms.map(buildRooms).toList(),
                                      onChanged: (value) async {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("Please wait..")));
                                        setState(() {
                                          room = value;
                                        });
                                        await generateRoomNumbers2();
                                      }),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.005),
                                border: Border.all(
                                    color: transparentColor, width: 2),
                                color: whiteColor,
                              ),
                              child: ListTile(
                                leading: Icon(Icons.room_preferences_rounded,
                                    color: primaryColor),
                                title: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text('Room number'),
                                    isExpanded: true,
                                    value: roomno,
                                    iconSize: 30,
                                    items: roomnumbers
                                        .map(buildRoomNumbers)
                                        .toList(),
                                    onChanged: (value) async => setState(() {
                                      roomno = value;
                                    }),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.005),
                                border: Border.all(
                                    color: transparentColor, width: 2),
                                color: whiteColor,
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.edit_location_rounded,
                                        color: primaryColor),
                                    title: Text(
                                        checkin1 == checkin2
                                            ? 'Check-in date ($checkin2)'
                                            : 'Check-in date ($checkin1)',
                                        style:
                                            TextStyle(color: Colors.black54)),
                                    trailing: IconButton(
                                      icon: Icon(Icons.calendar_month_rounded,
                                          color: primaryColor),
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: checkin3,
                                                firstDate: DateTime(2022),
                                                lastDate: DateTime(2100))
                                            .then((date) => setState(() {
                                                  checkInDate = date!;
                                                  convertDateTimeDisplay1(
                                                      checkInDate.toString());
                                                  reconvertCheckindate();
                                                }));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.005),
                                border: Border.all(
                                    color: transparentColor, width: 2),
                                color: whiteColor,
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.edit_location_rounded,
                                        color: primaryColor),
                                    title: Text(
                                        checkout1 == checkout2
                                            ? 'Check-out date ($checkout2)'
                                            : 'Check-out date ($checkout1)',
                                        style:
                                            TextStyle(color: Colors.black54)),
                                    trailing: IconButton(
                                      icon: Icon(Icons.calendar_month_rounded,
                                          color: primaryColor),
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: checkout3,
                                                firstDate: DateTime(2022),
                                                lastDate: DateTime(2050))
                                            .then((date) => setState(() {
                                                  checkOutDate = date!;
                                                  convertDateTimeDisplay2(
                                                      checkOutDate.toString());
                                                  reconvertCheckoutdate();
                                                  calculateClicked = false;
                                                }));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.005),
                                border: Border.all(
                                    color: transparentColor, width: 2),
                                color: whiteColor,
                              ),
                              child: ListTile(
                                leading: Icon(Icons.receipt_outlined,
                                    color: primaryColor),
                                title: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text('Bill type'),
                                    isExpanded: true,
                                    value: bill,
                                    iconSize: 30,
                                    items:
                                        billTypes.map(buildBillTypes).toList(),
                                    onChanged: (value) async => setState(() {
                                      bill = value;
                                      setState(() {
                                        bill == 'No discount'
                                            ? discountController.text = '0'
                                            : discountController.text = '';
                                      });
                                    }),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            RoundedInputFieldMain2b(
                                controller: discountController,
                                width: size.width * 0.5,
                                horizontalGap: size.width * 0.01,
                                verticalGap: size.height * 0.001,
                                radius: size.width * 0.005,
                                mainText: '0',
                                labelText: 'Discount',
                                warningText: 'Discount must be an integer',
                                validator: bill,
                                icon: Icons.numbers,
                                onChanged: (value) {
                                  value = discountController.text.trim();
                                }),
                            SizedBox(height: size.height * 0.02),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.005),
                                border: Border.all(
                                    color: transparentColor, width: 2),
                                color: whiteColor,
                              ),
                              child: ListTile(
                                leading: Icon(Icons.payments_rounded,
                                    color: primaryColor),
                                title: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text('Mode of payment'),
                                    isExpanded: true,
                                    value: posRefOrConfirmation,
                                    iconSize: 30,
                                    items: modesOfPayment
                                        .map(buildModesOfPayment)
                                        .toList(),
                                    onChanged: (value) async => setState(() {
                                      posRefOrConfirmation = value;
                                      setState(() {
                                        posRefOrConfirmation == 'Cash'
                                            ? posRefController.text = 'NIL'
                                            : posRefController.text = '';
                                      });
                                    }),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Form(
                              key: _formKeyPOS_Confirmation,
                              child: RoundedInputFieldMain2c(
                                  controller: posRefController,
                                  width: size.width * 0.5,
                                  horizontalGap: size.width * 0.01,
                                  verticalGap: size.height * 0.001,
                                  radius: size.width * 0.005,
                                  mainText: '',
                                  labelText:
                                      'POS reference number/Transfer confirmation',
                                  warningText1:
                                      'Enter a valid POS reference number',
                                  warningText2:
                                      "required! (e.g: 'Comfirmed by ${db.CurrentLoggedInUserEmail})",
                                  currentUser: db.CurrentLoggedInUserEmail,
                                  validator: posRefOrConfirmation,
                                  icon: Icons.numbers,
                                  onChanged: (value) {
                                    value = posRefController.text.trim();
                                  }),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Duration (days): $duration',
                                    style: TextStyle(
                                        fontFamily: 'Biko',
                                        fontSize: size.width * 0.015,
                                        color: navyBlueColor)),
                                Text(
                                    'Total Cost (${db.HotelCurrency.toUpperCase()}): $totalCost',
                                    style: TextStyle(
                                        fontFamily: 'Biko',
                                        fontSize: size.width * 0.015,
                                        color: navyBlueColor)),
                              ],
                            ),
                            SizedBox(height: size.height * 0.05),
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: customBackgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedButtonGeneral(
                  isLoading: false,
                  text1: "Calculate",
                  text2: 'Calculating..',
                  color: primaryColor2,
                  update: () async {
                    setState(() {
                      duration = 0;
                      totalCost = 0;
                    });
                    final form = _formKey.currentState!;
                    if (room != null && room != '') {
                      if ((checkin1 != checkout1) && checkout1 != '') {
                        if (form.validate()) {
                          if (gender != null &&
                              gender != '' &&
                              // nationality != null &&
                              // nationality != '' &&
                              // stateOfOrigin != null &&
                              // stateOfOrigin != '' &&
                              identification != null &&
                              identification != '' &&
                              room != null &&
                              room != '' &&
                              roomno != null &&
                              roomno != '' &&
                              bill != null &&
                              bill != '' &&
                              posRefOrConfirmation != null) {
                            await calculateDurationAndCost(
                                (room!.toLowerCase() == 'standard'
                                    ? db.StandardRoomRate
                                    : room!.toLowerCase() == 'executive'
                                        ? db.ExecutiveRoomRate
                                        : db.PresidentialRoomRate),
                                discountController.text.trim());
                            setState(() {
                              calculateClicked = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: primaryColor2,
                                content: Text("Operation succeeded..")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: errorColor,
                                content: Text(
                                    "Gender, Nationality, State of origin, Mode of identification, Room type, Bill type and Mode of payment are required!")));
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: errorColor,
                            content: Text("Invalid check-out date!")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: errorColor,
                          content: Text("Room type cannot be empty!")));
                    }
                  },
                ),
                RoundedButtonGeneral(
                  isLoading: false,
                  text1: "Update",
                  text2: 'Updating..',
                  color: primaryColor2,
                  update: () async {
                    final form = _formKeySearch.currentState!;
                    final formPOS = _formKeyPOS_Confirmation.currentState!;
                    if (form.validate()) {
                      if (isSearchForUpdate == true) {
                        if (calculateClicked == true) {
                          if (formPOS.validate()) {
                            if (await db.updateCustomer(
                                    customerIDController.text.trim(),
                                    firstNameController.text.trim(),
                                    lastNameController.text.trim(),
                                    gender,
                                    // nationality,
                                    // stateOfOrigin,
                                    emailController.text.trim(),
                                    phoneController.text.trim(),
                                    identification,
                                    idController.text.trim(),
                                    room,
                                    roomno,
                                    checkin1,
                                    checkout1,
                                    bill,
                                    discountController.text.trim(),
                                    posRefOrConfirmation,
                                    posRefController.text.trim(),
                                    duration,
                                    totalCost) ==
                                true) {
                              timeStamp = DateTime.now();
                              convertDateTimeDisplay3();
                              await db.insertUpdateTimeStamp(
                                  '${db.CurrentLoggedInUserFirstname} ${db.CurrentLoggedInUserLastname}',
                                  'updated',
                                  customerIDController.text.trim(),
                                  firstNameController.text.trim(),
                                  lastNameController.text.trim(),
                                  room,
                                  roomno,
                                  checkin1,
                                  checkout1,
                                  bill,
                                  discountController.text.trim(),
                                  totalCost,
                                  timestampDate,
                                  timestampHourMinSec);
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return dialog.ReturnDialog1(
                                      title: Text('Success'),
                                      message: 'Operation succeeded..',
                                      color: primaryColor,
                                      buttonText: 'Ok',
                                      onPressed: () async {
                                        generateCustomerID();
                                        setState(() {
                                          isSearchForUpdate = null;
                                          calculateClicked = null;
                                          customerIDController.text = '';
                                          firstNameController.text = '';
                                          lastNameController.text = '';
                                          gender = null;
                                          // nationality = null;
                                          // stateOfOrigin = null;
                                          emailController.text = '';
                                          phoneController.text = '';
                                          identification = null;
                                          idController.text = '';
                                          room = null;
                                          roomno = null;
                                          checkin1 = '';
                                          checkout1 = '';
                                          convertDateTimeDisplay1(
                                              checkInDate.toString());
                                          bill = null;
                                          discountController.text = '';
                                          posRefOrConfirmation = null;
                                          posRefController.text = '';
                                          duration = 0;
                                          totalCost = 0;
                                          timestampDate = '';
                                          timestampHourMinSec = '';
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: errorColor,
                                      content: Text("Operation failed!")));
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: errorColor,
                              content: Text("Please recalculate first!")));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: errorColor,
                            content: Text("Search for customer id first!")));
                      }
                    }
                  },
                ),
                RoundedButtonGeneral(
                  isLoading: false,
                  text1: "Check In",
                  text2: 'Processing..',
                  color: primaryColor2,
                  update: () async {
                    final form = _formKeyPOS_Confirmation.currentState!;
                    if (isSearchForUpdate != true) {
                      if (calculateClicked == true) {
                        if (form.validate()) {
                          try {
                            if (await db.checkInCustomer(
                                    customerID,
                                    firstNameController.text.trim(),
                                    lastNameController.text.trim(),
                                    gender,
                                    // nationality,
                                    // stateOfOrigin,
                                    emailController.text.trim(),
                                    phoneController.text.trim(),
                                    identification,
                                    idController.text.trim(),
                                    room,
                                    roomno,
                                    checkin1,
                                    checkout1,
                                    bill,
                                    discountController.text.trim(),
                                    posRefOrConfirmation,
                                    posRefController.text.trim(),
                                    duration,
                                    totalCost) ==
                                true) {
                              timeStamp = DateTime.now();
                              convertDateTimeDisplay3();
                              await db.insertCheckInCheckOutTimeStamp(
                                  '${db.CurrentLoggedInUserFirstname} ${db.CurrentLoggedInUserLastname}',
                                  'checked in',
                                  firstNameController.text.trim(),
                                  lastNameController.text.trim(),
                                  room,
                                  roomno,
                                  checkin1,
                                  checkout1,
                                  bill,
                                  discountController.text.trim(),
                                  totalCost,
                                  timestampDate,
                                  timestampHourMinSec);
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return dialog.ReturnDialog1(
                                      title: Text('Success'),
                                      message: 'Operation succeeded..',
                                      color: primaryColor,
                                      buttonText: 'Ok',
                                      onPressed: () async {
                                        setState(() {
                                          generateCustomerID();
                                          firstNameController.text = '';
                                          lastNameController.text = '';
                                          gender = null;
                                          // nationality = null;
                                          // stateOfOrigin = null;
                                          emailController.text = '';
                                          phoneController.text = '';
                                          identification = null;
                                          idController.text = '';
                                          room = null;
                                          roomno = null;
                                          checkin1 = '';
                                          checkout1 = '';
                                          convertDateTimeDisplay1(
                                              checkInDate.toString());
                                          bill = null;
                                          discountController.text = '';
                                          posRefOrConfirmation = null;
                                          posRefController.text = '';
                                          duration = 0;
                                          totalCost = 0;
                                          timestampDate = '';
                                          timestampHourMinSec = '';
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: errorColor,
                                      content: Text("Operation failed!")));
                            }
                          } on Exception catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: errorColor,
                                content: Text("No internet connection!")));
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: errorColor,
                            content: Text("Please calculate first!")));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: errorColor,
                          content: Text(
                              "Cannot check in! Please, update instead!")));
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
