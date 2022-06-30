// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_catch_clause, use_build_context_synchronously

import 'package:JoGenics/components/rounded_password_field.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/constants.dart';
import 'package:data_table_2/data_table_2.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

class CustomerRecords extends StatefulWidget {
  const CustomerRecords({Key? key}) : super(key: key);

  @override
  State<CustomerRecords> createState() => _CustomerRecordsState();
}

class _CustomerRecordsState extends State<CustomerRecords> {
  final _formKeyLastName = GlobalKey<FormState>();
  final _formKeyEmployeeFullName = GlobalKey<FormState>();
  final lastNameController = TextEditingController();
  final employeeFullNameController = TextEditingController();
  final passwordController = TextEditingController();

  late List liveData = [];
  late List liveData2 = [];
  List selectedData = [];
  late List liveData3 = [];
  late List liveData4 = [];
  late List liveData5 = [];
  late List liveData6 = [];

  changeIsSearchToFalse() {
    setState(() {
      isSearchCustomers = 'false';
    });
  }

  changeIsSearchToSearchByDate() {
    setState(() {
      isSearchCustomers = 'searchByDate';
    });
  }

  changeIsSearchEmployeeTS1tofalse() {
    setState(() {
      isSearchEmployeeTimeStamp1 = 'false';
    });
  }

  changeIsSearchEmployeeTS1toSearchByDate() {
    setState(() {
      isSearchEmployeeTimeStamp1 = 'searchByDate';
    });
  }

  getUserData1() async {
    changeIsSearchToFalse();
    return db.CustomerRecordForUpdate;
  }

  getUserData1b() async {
    changeIsSearchToSearchByDate();
    return db.CustomerRecordForUpdate;
  }

  getUserData1c() async {
    // await db.adminSignIn(db.HotelName, db.CurrentLoggedInUserEmail,
    //     db.CurrentLoggedInUserPassword);
    return db.CustomersRecord;
  }

  getUserData1d() async {
    changeIsSearchEmployeeTS1tofalse();
    return db.CustomerRecordForUpdate;
  }

  getUserData1e() async {
    changeIsSearchEmployeeTS1toSearchByDate();
    return db.CustomerRecordForUpdate;
  }

  getUserData1f() async {
    return db.CustomerRecordForUpdate;
  }

  // getUserData1f() async {
  //   changeIsSearchEmployeeTS2tofalse();
  //   return db.CustomerRecordForUpdate;
  // }

  // getUserData1g() async {
  //   return db.CustomerRecordForUpdate;
  // }

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

  deleteRecord() async {
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
                    "Do you wish to delete these ${selectedData.length} customers record?",
                color: navyBlueColor,
                button1Text: 'No',
                onPressed1: () {
                  Navigator.of(context).pop();
                },
                button2Text: 'Yes',
                onPressed2: () {
                  print('can delete now - multiple selection');
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
                                        .toLowerCase()
                                        .hashCode
                                        .toString() ==
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
                                              if (await db.deleteCustomerRecord(
                                                      selectedData[i][0]) ==
                                                  true) {
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
                                    isSearchCustomers = null;
                                    dateOfCheckin1 = '';
                                    convertDateTimeDisplay1(
                                        dateOfCheckin.toString());
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
              print('can delete now - single selection');
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
                                    .toLowerCase()
                                    .hashCode
                                    .toString() ==
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
                                  if (await db.deleteCustomerRecord(
                                          selectedData[0][0]) ==
                                      true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: primaryColor2,
                                            content: Text(
                                                "Operation succeeded. Please wait..")));
                                    Navigator.of(context).pop();
                                    setState(() {
                                      lastNameController.text = '';
                                      isSearchCustomers = null;
                                      dateOfCheckin1 = '';
                                      convertDateTimeDisplay1(
                                          dateOfCheckin.toString());
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

  getEmployeeTimeStamp() async {
    await db.fetchEmployeeTimeStampCheckin_out();
    liveData3 = [];
    liveData4 = [];
    int len = db.EmployeetimeStampCheckin_out.length + 1;
    for (var data in db.EmployeetimeStampCheckin_out) {
      liveData3.add(data['employee']);
      liveData3.add(data['alert']);
      liveData3.add(data['checkindate']);
      liveData3.add(data['checkoutdate']);
      liveData3.add(data['billtype']);
      liveData3.add(data['discount']);
      liveData3.add(data['totalcost']);
      liveData3.add(data['date']);
      liveData3.add(data['time']);
    }
    late var x = 0;
    late var y = 9;
    for (var i = 1; i < len; i += 1) {
      if (i == 1) {
        liveData4.add(liveData3.sublist(x, y));
      } else if (i > 1) {
        x += 9;
        y += 9;
        liveData4.add(liveData3.sublist(x, y));
      }
    }
    print('Time stamp 1 = $liveData4');

    await db.fetchEmployeeTimeStampUpdate();
    liveData5 = [];
    liveData6 = [];
    int len2 = db.EmployeetimeStampUpdate.length + 1;
    for (var data in db.EmployeetimeStampUpdate) {
      liveData5.add(data['employee']);
      liveData5.add(data['alert']);
      liveData5.add(data['newroomtype']);
      liveData5.add(data['newroomnumber']);
      liveData5.add(data['newcheckindate']);
      liveData5.add(data['newcheckoutdate']);
      liveData5.add(data['newbilltype']);
      liveData5.add(data['newdiscount']);
      liveData5.add(data['newtotalcost']);
      liveData5.add(data['date']);
      liveData5.add(data['time']);
    }
    late var a = 0;
    late var b = 11;
    for (var i = 1; i < len2; i += 1) {
      if (i == 1) {
        liveData6.add(liveData5.sublist(a, b));
      } else if (i > 1) {
        a += 11;
        b += 11;
        liveData6.add(liveData5.sublist(a, b));
      }
    }
    print('Time stamp 2 = $liveData6');
    return liveData6;
  }

  late DateTime dateOfCheckin = DateTime.now();
  late DateTime timeStampDate = DateTime.now();
  late String dateOfCheckin1 = '';
  late String dateOfCheckin2 = '';
  late String timeStampDate1 = '';
  late String timeStampDate2 = '';
  String convertDateTimeDisplay1(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    dateOfCheckin2 = formatted;
    return dateOfCheckin2;
  }

  String convertDateTimeDisplay1b(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    dateOfCheckin1 = formatted;
    return dateOfCheckin1;
  }

  String convertDateTimeDisplay2(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    timeStampDate2 = formatted;
    return timeStampDate2;
  }

  String convertDateTimeDisplay2b(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    timeStampDate1 = formatted;
    return timeStampDate1;
  }

  @override
  void initState() {
    getUserData2();
    convertDateTimeDisplay1(dateOfCheckin.toString());
    convertDateTimeDisplay1b(dateOfCheckin.toString());
    convertDateTimeDisplay2(dateOfCheckin.toString());
    convertDateTimeDisplay2b(dateOfCheckin.toString());
    changeIsSearchToFalse();
    changeIsSearchEmployeeTS1tofalse();
    getEmployeeTimeStamp();
    super.initState();
  }

  @override
  void dispose() {
    lastNameController.dispose();
    employeeFullNameController.dispose();
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
          // SpeedDialChild(
          //   backgroundColor: errorColor,
          //   foregroundColor: whiteColor,
          //   child: Icon(Icons.delete),
          //   label: 'Delete record',
          //   onTap: () async {
          //     await deleteRecord();
          //   },
          // ),
          SpeedDialChild(
            backgroundColor: Colors.teal,
            foregroundColor: whiteColor,
            child: Icon(Icons.calendar_month_rounded),
            label: 'Search by date (Time stamp)',
            onTap: () async {
              showDatePicker(
                      context: context,
                      initialDate: timeStampDate,
                      firstDate: DateTime(1990),
                      lastDate: DateTime(2100))
                  .then((date) => setState(() {
                        timeStampDate = date!;
                        convertDateTimeDisplay2(timeStampDate.toString());
                        isSearchEmployeeTimeStamp1 = 'searchByDate';
                      }));
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.amberAccent,
            foregroundColor: whiteColor,
            child: Icon(Icons.search_rounded),
            label: 'Search by employee (Time stamp)',
            onTap: () async {
              final form = _formKeyEmployeeFullName.currentState!;
              if (form.validate()) {
                setState(() {
                  isSearchEmployeeTimeStamp1 = 'true';
                });
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: primaryColor2,
            foregroundColor: whiteColor,
            child: Icon(Icons.refresh_rounded),
            label: 'Refresh (Time stamp)',
            onTap: () async {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Please wait..")));
              setState(() {
                employeeFullNameController.text = '';
                isSearchEmployeeTimeStamp1 = null;
                timeStampDate1 = '';
                convertDateTimeDisplay2(timeStampDate.toString());
              });
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.teal,
            foregroundColor: whiteColor,
            child: Icon(Icons.calendar_month_rounded),
            label: 'Search by date (Customers record)',
            onTap: () async {
              showDatePicker(
                      context: context,
                      initialDate: dateOfCheckin,
                      firstDate: DateTime(1990),
                      lastDate: DateTime(2100))
                  .then((date) => setState(() {
                        dateOfCheckin = date!;
                        convertDateTimeDisplay1(dateOfCheckin.toString());
                        selectedData.clear();
                        isSearchCustomers = 'searchByDate';
                      }));
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.amberAccent,
            foregroundColor: whiteColor,
            child: Icon(Icons.search_rounded),
            label: 'Search by last name (Customers record)',
            onTap: () async {
              final form = _formKeyLastName.currentState!;
              if (form.validate()) {
                setState(() {
                  selectedData.clear();
                  isSearchCustomers = 'true';
                });
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: primaryColor2,
            foregroundColor: whiteColor,
            child: Icon(Icons.refresh_rounded),
            label: 'Refresh (Customers record)',
            onTap: () async {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Please wait..")));
              setState(() {
                lastNameController.text = '';
                isSearchCustomers = null;
                dateOfCheckin1 = '';
                convertDateTimeDisplay1(dateOfCheckin.toString());
                selectedData.clear();
              });
            },
          ),
        ],
      ),
      backgroundColor: customBackgroundColor,
      appBar: buildAppBar(context, "Records", blackColor, true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01),
            Center(
                child: Text('Customer Records',
                    style: TextStyle(
                        fontFamily: 'Biko',
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.02))),
            SizedBox(height: size.height * 0.05),
            buildSearchArea(context),
            SizedBox(height: size.height * 0.01),
            buildTable1(context),
            Divider(),
            SizedBox(height: size.height * 0.05),
            Center(
                child: Text('Time Stamp',
                    style: TextStyle(
                        fontFamily: 'Biko',
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.02))),
            buildSearchArea2(context),
            buildTable2(context),
            Divider(),
            SizedBox(height: size.height * 0.05),
            buildTable3(context),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }

  Widget buildSearchArea(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.24,
      width: size.width * 0.9,
      child: Column(
        children: [
          Column(
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
              SizedBox(height: size.height * 0.01),
              Column(
                children: [
                  Container(
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.005),
                      border: Border.all(color: transparentColor, width: 2),
                      color: whiteColor,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                            leading: Icon(Icons.calendar_month_rounded,
                                color: primaryColor),
                            title: Text(
                                dateOfCheckin1 == dateOfCheckin2
                                    ? 'Date: ($dateOfCheckin1)'
                                    : dateOfCheckin2,
                                style: TextStyle(color: Colors.black54))),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTable1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: FutureBuilder(
          future: isSearchCustomers == null
              ? getUserData1()
              : isSearchCustomers == 'searchByDate'
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
                        dataRowColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) =>
                                states.contains(MaterialState.selected)
                                    ? primaryColor
                                    : customBackgroundColor),
                        showCheckboxColumn: false,
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
                        rows: isSearchCustomers == 'false'
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
                            : isSearchCustomers == 'searchByDate'
                                ? <DataRow>[
                                    for (var item in liveData2)
                                      if (item[10] == dateOfCheckin2)
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
                                      if (item[2].startsWith(
                                          lastNameController.text.trim()))
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

  Widget buildSearchArea2(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.25,
      width: size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              key: _formKeyEmployeeFullName,
              child: RoundedInputFieldMain(
                  controller: employeeFullNameController,
                  width: size.width * 0.3,
                  horizontalGap: size.width * 0.01,
                  verticalGap: size.height * 0.001,
                  radius: size.width * 0.005,
                  mainText: '',
                  labelText: 'Search by employee',
                  icon: Icons.person,
                  isEnabled: true,
                  onChanged: (value) {
                    value = employeeFullNameController.text.trim();
                  })),
          SizedBox(height: size.height * 0.01),
          Column(
            children: [
              Container(
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.005),
                  border: Border.all(color: transparentColor, width: 2),
                  color: whiteColor,
                ),
                child: ListTile(
                  leading:
                      Icon(Icons.edit_location_rounded, color: primaryColor),
                  title: Text(
                      timeStampDate1 == timeStampDate2
                          ? 'Date: ($timeStampDate1)'
                          : timeStampDate2,
                      style: TextStyle(color: Colors.black54)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTable2(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: FutureBuilder(
          future: isSearchEmployeeTimeStamp1 == null
              ? getUserData1d()
              : isSearchEmployeeTimeStamp1 == 'searchByDate'
                  ? getUserData1e()
                  : getUserData1f(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Center(
                      child: Text('Initial Entry',
                          style: TextStyle(
                              fontFamily: 'Biko',
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.013))),
                  Expanded(
                    child: DataTable2(
                        columnSpacing: 5,
                        horizontalMargin: 5,
                        bottomMargin: 20,
                        showBottomBorder: true,
                        minWidth: size.width * 0.65,
                        dataRowColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) =>
                                states.contains(MaterialState.selected)
                                    ? primaryColor
                                    : customBackgroundColor),
                        showCheckboxColumn: false,
                        columns: <DataColumn>[
                          DataColumn(label: Text('Employee')),
                          DataColumn(label: Text('Message')),
                          DataColumn(label: Text('Check-in Date')),
                          DataColumn(label: Text('Check-out Date')),
                          DataColumn(label: Text('Bill Type')),
                          DataColumn(label: Text('Discount')),
                          DataColumn(label: Text('Total Paid')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Time')),
                        ],
                        rows: isSearchEmployeeTimeStamp1 == 'false'
                            ? <DataRow>[
                                for (var item in liveData4)
                                  DataRow(
                                      // selected: selectedData.contains(item),
                                      cells: <DataCell>[
                                        for (var item2 in item.sublist(0))
                                          DataCell(Text(item2)),
                                      ])
                              ]
                            : isSearchEmployeeTimeStamp1 == 'searchByDate'
                                ? <DataRow>[
                                    for (var item in liveData4)
                                      if (item[7] == timeStampDate2)
                                        DataRow(cells: <DataCell>[
                                          for (var item2 in item.sublist(0))
                                            DataCell(Text(item2)),
                                        ]),
                                  ]
                                : <DataRow>[
                                    for (var item in liveData4)
                                      if (item[0].startsWith(
                                          employeeFullNameController.text
                                              .trim()))
                                        DataRow(cells: <DataCell>[
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

  Widget buildTable3(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: FutureBuilder(
          future: isSearchEmployeeTimeStamp1 == null
              ? getUserData1d()
              : isSearchEmployeeTimeStamp1 == 'searchByDate'
                  ? getUserData1e()
                  : getUserData1f(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Center(
                      child: Text('Updated Entry',
                          style: TextStyle(
                              fontFamily: 'Biko',
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.013))),
                  Expanded(
                    child: DataTable2(
                        columnSpacing: 5,
                        horizontalMargin: 5,
                        bottomMargin: 20,
                        showBottomBorder: true,
                        minWidth: size.width * 0.75,
                        dataRowColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) =>
                                states.contains(MaterialState.selected)
                                    ? primaryColor
                                    : customBackgroundColor),
                        showCheckboxColumn: false,
                        columns: <DataColumn>[
                          DataColumn(label: Text('Employee')),
                          DataColumn(label: Text('Message')),
                          DataColumn(label: Text('Room Type')),
                          DataColumn(label: Text('Room Number')),
                          DataColumn(label: Text('Check-in Date')),
                          DataColumn(label: Text('Check-out Date')),
                          DataColumn(label: Text('Bill Type')),
                          DataColumn(label: Text('Discount')),
                          DataColumn(label: Text('Total Paid')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Time')),
                        ],
                        rows: isSearchEmployeeTimeStamp1 == 'false'
                            ? <DataRow>[
                                for (var item in liveData6)
                                  DataRow(
                                      // selected: selectedData.contains(item),
                                      cells: <DataCell>[
                                        for (var item2 in item.sublist(0))
                                          DataCell(Text(item2)),
                                      ])
                              ]
                            : isSearchEmployeeTimeStamp1 == 'searchByDate'
                                ? <DataRow>[
                                    for (var item in liveData6)
                                      if (item[9] == timeStampDate2)
                                        DataRow(cells: <DataCell>[
                                          for (var item2 in item.sublist(0))
                                            DataCell(Text(item2)),
                                        ]),
                                  ]
                                : <DataRow>[
                                    for (var item in liveData6)
                                      if (item[0].startsWith(
                                          employeeFullNameController.text
                                              .trim()))
                                        DataRow(cells: <DataCell>[
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
