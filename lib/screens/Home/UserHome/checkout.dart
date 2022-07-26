// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_catch_clause, use_build_context_synchronously, non_constant_identifier_names

import 'package:JoGenics/components/rounded_password_field.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/components/app_bar.dart';
// import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/constants.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final _formKeyLastName = GlobalKey<FormState>();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();

  late List liveData = [];
  late List liveData2 = [];
  List selectedData = [];
  late DateTime timeStamp;
  late String timestampDate = '';
  late String timestampHourMinSec = '';

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

  changeIsSearchToFalse() {
    setState(() {
      isSearchCustomerCheckOut = 'false';
    });
  }

  getUserData1() async {
    changeIsSearchToFalse();
    return db.CustomersRecord;
  }

  getUserData1b() async {
    return db.CustomersRecord;
  }

  getUserData1c() async {
    return db.CustomersRecord;
  }

  getUserData2() async {
    await db.fetchCustomersRecord();
    liveData = [];
    liveData2 = [];
    int len = db.CustomersRecord.length + 1;
    for (var data in db.CustomersRecord) {
      liveData.add(data['customerid']);
      liveData.add(data['firstname']);
      liveData.add(data['lastname']);
      liveData.add(data['gender']);
      // liveData.add(data['nationality']);
      // liveData.add(data['stateoforigin']);
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
    print('Individual data = $liveData2');
    return liveData2;
  }

  late DateTime dateOfCheckout = DateTime.now();
  late String dateOfCheckout1 = '';
  late String dateOfCheckout2 = '';
  String convertDateTimeDisplay1(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    // final String formatted2 = serverFormater.format(displayDate);
    dateOfCheckout2 = formatted;
    dateOfCheckout1 = formatted;
    return dateOfCheckout2;
  }

  checkOutCustomer() async {
    if (selectedData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: errorColor, content: Text("No record selected!")));
      return;
    } else {
      if (selectedData.length > 1) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return dialog.ReturnDialog4(
                title: Text(''),
                message:
                    "Do you wish to checkout these ${selectedData.length} customers?",
                color: navyBlueColor,
                button1Text: 'No',
                onPressed1: () {
                  Navigator.of(context).pop();
                },
                button2Text: 'Yes',
                onPressed2: () {
                  print('can checkout now - multiple selection');
                  passwordController.text = '';
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Center(
                          child: dialog.ReturnDialog4(
                              title: RoundedPasswordFieldA2(
                                  controller: passwordController),
                              message: '',
                              color: primaryColor,
                              button1Text: 'Cancel',
                              onPressed1: () {
                                Navigator.of(context).pop();
                              },
                              button2Text: 'Confirm',
                              onPressed2: () async {
                                if (passwordController.text
                                        .trim()
                                        .toLowerCase() ==
                                    db.CurrentLoggedInUserPassword) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      });
                                  for (var i = 0;
                                      i < selectedData.length;
                                      i += 1) {
                                    print(i);
                                    for (var data in db.CustomersRecord) {
                                      if (data['customerid'] ==
                                          selectedData[i][0]) {
                                        if (!selectedData[0][0]
                                            .startsWith('demo')) {
                                          try {
                                            if (await db.findCustomerRecordById(
                                                    selectedData[i][0]) ==
                                                true) {
                                              if (await db.updateCustomer(
                                                      selectedData[i][0],
                                                      selectedData[i][1],
                                                      selectedData[i][2],
                                                      selectedData[i][3],
                                                      selectedData[i][4],
                                                      selectedData[i][5],
                                                      selectedData[i][6],
                                                      selectedData[i][7],
                                                      selectedData[i][8],
                                                      selectedData[i][9] + '#',
                                                      selectedData[i][10],
                                                      selectedData[i][11],
                                                      selectedData[i][12],
                                                      selectedData[i][13],
                                                      selectedData[i][14],
                                                      selectedData[i][15],
                                                      selectedData[i][16],
                                                      selectedData[i][17]) ==
                                                  true) {
                                                timeStamp = DateTime.now();
                                                convertDateTimeDisplay3();
                                                await db.insertCheckInCheckOutTimeStamp(
                                                    '${db.CurrentLoggedInUserFirstname} ${db.CurrentLoggedInUserLastname}',
                                                    'checked out',
                                                    selectedData[i][1],
                                                    selectedData[i][2],
                                                    selectedData[i][8],
                                                    selectedData[i][9],
                                                    selectedData[i][10],
                                                    selectedData[i][11],
                                                    selectedData[i][12],
                                                    selectedData[i][13],
                                                    selectedData[i][17],
                                                    timestampDate,
                                                    timestampHourMinSec);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            primaryColor2,
                                                        content: Text(
                                                            "Operation succeeded. Please wait..")));
                                              }
                                            } else {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      backgroundColor:
                                                          errorColor,
                                                      content: Text(
                                                          "Record does not exist!")));
                                            }
                                          } on Exception catch (error) {
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor: errorColor,
                                                    content: Text(
                                                        "No internet connection!")));
                                          }
                                        }
                                      }
                                    }
                                  }
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  setState(() {
                                    lastNameController.text = '';
                                    isSearchCustomerCheckOut = null;
                                    // dateOfCheckin1 = '';
                                    // convertDateTimeDisplay1(
                                    //     dateOfCheckin.toString());
                                    selectedData.clear();
                                  });
                                  getUserData1();
                                  getUserData1b();
                                  getUserData2();
                                } else {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: errorColor,
                                          content: Text("Invalid password!")));
                                }
                              }),
                        );
                      });
                },
              );
            });
      } else {
        for (var data in db.CustomersRecord) {
          if (data['customerid'] == selectedData[0][0]) {
            if (!selectedData[0][0].startsWith('demo')) {
              print('can checkout now - single selection');
              passwordController.text = '';
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Center(
                      child: dialog.ReturnDialog4(
                          title: RoundedPasswordFieldA2(
                              controller: passwordController),
                          message: '',
                          color: primaryColor,
                          button1Text: 'Cancel',
                          onPressed1: () {
                            Navigator.of(context).pop();
                          },
                          button2Text: 'Confirm',
                          onPressed2: () async {
                            if (passwordController.text.trim().toLowerCase() ==
                                db.CurrentLoggedInUserPassword) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  });
                              try {
                                if (await db.findCustomerRecordById(
                                        selectedData[0][0]) ==
                                    true) {
                                  if (await db.updateCustomer(
                                          selectedData[0][0],
                                          selectedData[0][1],
                                          selectedData[0][2],
                                          selectedData[0][3],
                                          selectedData[0][4],
                                          selectedData[0][5],
                                          selectedData[0][6],
                                          selectedData[0][7],
                                          selectedData[0][8],
                                          selectedData[0][9] + '#',
                                          selectedData[0][10],
                                          selectedData[0][11],
                                          selectedData[0][12],
                                          selectedData[0][13],
                                          selectedData[0][14],
                                          selectedData[0][15],
                                          selectedData[0][16],
                                          selectedData[0][17]) ==
                                      true) {
                                    timeStamp = DateTime.now();
                                    convertDateTimeDisplay3();
                                    await db.insertCheckInCheckOutTimeStamp(
                                        '${db.CurrentLoggedInUserFirstname} ${db.CurrentLoggedInUserLastname}',
                                        'checked out',
                                        selectedData[0][1],
                                        selectedData[0][2],
                                        selectedData[0][8],
                                        selectedData[0][9],
                                        selectedData[0][10],
                                        selectedData[0][11],
                                        selectedData[0][12],
                                        selectedData[0][13],
                                        selectedData[0][17],
                                        timestampDate,
                                        timestampHourMinSec);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: primaryColor2,
                                            content: Text(
                                                "Operation succeeded. Please wait..")));
                                    Navigator.of(context).pop();
                                    setState(() {
                                      lastNameController.text = '';
                                      isSearchCustomerCheckOut = null;
                                      // dateOfCheckin1 = '';
                                      // convertDateTimeDisplay1(
                                      //     dateOfCheckin.toString());
                                      selectedData.clear();
                                    });
                                    Navigator.of(context).pop();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        });
                                    getUserData1();
                                    getUserData1b();
                                    getUserData2();
                                    Navigator.of(context).pop();
                                  }
                                } else {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: errorColor,
                                          content:
                                              Text("Record does not exist!")));
                                }
                              } on Exception catch (error) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: errorColor,
                                        content:
                                            Text("No internet connection!")));
                              }
                            } else {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: errorColor,
                                      content: Text("Invalid password!")));
                            }
                          }),
                    );
                  });
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    changeIsSearchToFalse();
    getUserData2();
    convertDateTimeDisplay1(dateOfCheckout.toString());
    super.initState();
  }

  @override
  void dispose() {
    lastNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: primaryColor2,
        overlayColor: navyBlueColor,
        spacing: size.height * 0.02,
        spaceBetweenChildren: size.height * 0.01,
        overlayOpacity: 0.4,
        children: [
          SpeedDialChild(
            backgroundColor: Colors.redAccent,
            foregroundColor: whiteColor,
            child: Icon(Icons.delete),
            label: 'Check out',
            onTap: () async {
              await checkOutCustomer();
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.teal,
            foregroundColor: whiteColor,
            child: Icon(Icons.calendar_month_rounded),
            label: 'Search by date (Check-out)',
            onTap: () async {
              showDatePicker(
                      context: context,
                      initialDate: dateOfCheckout,
                      firstDate: DateTime(1990),
                      lastDate: DateTime(2100))
                  .then((date) => setState(() {
                        dateOfCheckout = date!;
                        convertDateTimeDisplay1(dateOfCheckout.toString());
                        selectedData.clear();
                        isSearchCustomerCheckOut = 'searchByDate';
                      }));
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.amberAccent,
            foregroundColor: whiteColor,
            child: Icon(Icons.search_rounded),
            label: 'Search guest',
            onTap: () async {
              final form = _formKeyLastName.currentState!;
              if (form.validate()) {
                setState(() {
                  selectedData.clear();
                  isSearchCustomerCheckOut = 'true';
                });
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: primaryColor2,
            foregroundColor: whiteColor,
            child: Icon(Icons.refresh_rounded),
            label: 'Refresh',
            onTap: () async {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Please wait..")));
              setState(() {
                selectedData.clear();
                lastNameController.text = '';
                isSearchCustomerCheckOut = null;
              });
            },
          ),
        ],
      ),
      backgroundColor: customBackgroundColor,
      appBar: buildAppBar(context, 'Check Out', blackColor, true),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.01),
          buildSearchArea(context),
          SizedBox(height: size.height * 0.005),
          buildTable(context),
        ],
      ),
    );
  }

  Widget buildSearchArea(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.22,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                    key: _formKeyLastName,
                    child: RoundedInputFieldMain(
                        controller: lastNameController,
                        width: size.width * 0.3,
                        horizontalGap: size.width * 0.01,
                        verticalGap: size.height * 0.001,
                        radius: size.width * 0.005,
                        mainText: '',
                        labelText: 'Search by last name',
                        icon: Icons.person,
                        isEnabled: true,
                        onChanged: (value) {
                          value = lastNameController.text.trim();
                        })),
                SizedBox(width: size.width * 0.04),
                Text(
                    dateOfCheckout1 == dateOfCheckout2
                        ? 'Date (Check-out): $dateOfCheckout1'
                        : dateOfCheckout2,
                    style: TextStyle(color: navyBlueColor, fontWeight: FontWeight.bold, fontSize: size.width*0.015)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTable(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.6,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: FutureBuilder(
          future: isSearchCustomerCheckOut == null
              ? getUserData1()
              : isSearchCustomerCheckOut == 'searchByDate'
                  ? getUserData1b()
                  : getUserData1c(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: DataTable2(
                        columnSpacing: 5,
                        horizontalMargin: 5,
                        bottomMargin: 20,
                        showBottomBorder: true,
                        minWidth: size.width * 0.94,
                        columns: <DataColumn>[
                          DataColumn(label: Text('Customer Id')),
                          DataColumn(label: Text('First Name')),
                          DataColumn(label: Text('Last Name')),
                          DataColumn(label: Text('Gender')),
                          // DataColumn(label: Text('Nationality')),
                          // DataColumn(label: Text('State of Origin')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Phone')),
                          DataColumn(label: Text('Mode of Identification')),
                          DataColumn(label: Text('ID Number')),
                          DataColumn(label: Text('Room Type')),
                          DataColumn(label: Text('Room No')),
                          DataColumn(label: Text('Check-in Date')),
                          DataColumn(label: Text('Check-out Date')),
                          DataColumn(label: Text('Bill Type')),
                          DataColumn(label: Text('Discount')),
                          DataColumn(label: Text('Mode of Payment')),
                          DataColumn(label: Text('POS Ref/Confirmation')),
                          DataColumn(label: Text('Duration')),
                          DataColumn(label: Text('Total Paid')),
                        ],
                        rows: isSearchCustomerCheckOut == 'false'
                            ? <DataRow>[
                                for (var item in liveData2)
                                  DataRow(
                                      selected: selectedData.contains(item),
                                      onSelectChanged: (isSelected) {
                                        setState(() {
                                          final isAdding =
                                              isSelected != null && isSelected;
                                          isAdding
                                              ? selectedData.add(item)
                                              : selectedData.remove(item);
                                        });
                                      },
                                      cells: <DataCell>[
                                        for (var item2 in item.sublist(0))
                                          DataCell(Text(item2)),
                                      ])
                              ]
                            : isSearchCustomerCheckOut == 'searchByDate'
                                ? <DataRow>[
                                    for (var item in liveData2)
                                      if (item[11] == dateOfCheckout2)
                                        DataRow(
                                            selected:
                                                selectedData.contains(item),
                                            onSelectChanged: (isSelected) {
                                              setState(() {
                                                final isAdding =
                                                    isSelected != null &&
                                                        isSelected;
                                                isAdding
                                                    ? selectedData.add(item)
                                                    : selectedData.remove(item);
                                              });
                                            },
                                            cells: <DataCell>[
                                              for (var item2 in item.sublist(0))
                                                DataCell(Text(item2)),
                                            ]),
                                  ]
                                : <DataRow>[
                                    for (var item in liveData2)
                                      if (item[2] ==
                                          lastNameController.text.trim())
                                        DataRow(
                                            selected:
                                                selectedData.contains(item),
                                            onSelectChanged: (isSelected) {
                                              setState(() {
                                                final isAdding =
                                                    isSelected != null &&
                                                        isSelected;
                                                isAdding
                                                    ? selectedData.add(item)
                                                    : selectedData.remove(item);
                                              });
                                            },
                                            cells: <DataCell>[
                                              for (var item2 in item.sublist(0))
                                                DataCell(Text(item2)),
                                            ]),
                                  ]),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
