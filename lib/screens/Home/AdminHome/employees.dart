// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_catch_clause, use_build_context_synchronously

import 'dart:io';

import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/components/rounded_password_field.dart';
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/custom_page_route.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/screens/Home/AdminHome/add_employee.dart';
import 'package:csv/csv.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Employees extends StatefulWidget {
  const Employees({Key? key}) : super(key: key);

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newValueController = TextEditingController();

  late List liveData = [];
  late List liveData2 = [];
  List selectedData = [];
  late List mainItem = [];

  final fields = {
    '',
    'Firstname',
    'Lastname',
    'Gender',
    // 'EmailAddress',
    'Nationality',
    'StateOfOrigin',
    'PhoneNumber',
    'HomeAddress',
    'Designation',
    'Password',
  };
  DropdownMenuItem<String> buildFields(String field) => DropdownMenuItem(
      value: field,
      child: Text(
        field,
      ));

  changeIsSearchToFalse() {
    setState(() {
      isSearchEmployee = false;
    });
  }

  getUserData1() async {
    // await db.adminSignIn(db.HotelName, db.CurrentLoggedInUserEmail,
    //     db.CurrentLoggedInUserPassword);
    changeIsSearchToFalse();
    return db.Employees;
  }

  getUserData1b() async {
    // await db.adminSignIn(db.HotelName, db.CurrentLoggedInUserEmail,
    //     db.CurrentLoggedInUserPassword);
    return db.Employees;
  }

  getUserData2() async {
    await db.fetchEmployees();
    liveData = [];
    liveData2 = [];
    int len = db.Employees.length + 1;
    for (var data in db.Employees) {
      liveData.add(data['hotel']);
      liveData.add(data['firstname']);
      liveData.add(data['lastname']);
      liveData.add(data['gender']);
      liveData.add(data['emailaddress']);
      liveData.add(data['nationality']);
      liveData.add(data['stateoforigin']);
      liveData.add(data['phonenumber']);
      liveData.add(data['homeaddress'].toString());
      liveData.add(data['dateofemployment']);
      liveData.add(data['designation']);
      liveData.add(data['password']);
    }
    late var x = 0;
    late var y = 12;
    for (var i = 1; i < len; i += 1) {
      if (i == 1) {
        liveData2.add(liveData.sublist(x, y));
      } else if (i > 1) {
        x += 12;
        y += 12;
        liveData2.add(liveData.sublist(x, y));
      }
    }
    print('Individual data = $liveData2');
    return getData(liveData);
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
                    "Do you wish to delete these ${selectedData.length} employees?",
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
                                    for (var data in db.Employees) {
                                      if (data['emailaddress'] ==
                                          selectedData[i][4]) {
                                        try {
                                          if (await db.findEmployee(
                                                  selectedData[i][4]) ==
                                              true) {
                                            if (await db.deleteEmployeeRecord(
                                                    selectedData[i][4]) ==
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
                                                    backgroundColor: errorColor,
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
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  setState(() {
                                    emailController.text = '';
                                    isSearchEmployee = null;
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
        for (var data in db.Employees) {
          if (data['emailaddress'] == selectedData[0][4]) {
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
                              if (await db.findEmployee(selectedData[0][4]) ==
                                  true) {
                                if (await db.deleteEmployeeRecord(
                                        selectedData[0][4]) ==
                                    true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: primaryColor2,
                                          content: Text(
                                              "Operation succeeded. Please wait..")));
                                  Navigator.of(context).pop();
                                  setState(() {
                                    emailController.text = '';
                                    isSearchEmployee = null;
                                    selectedData.clear();
                                  });
                                  Navigator.of(context).pop();
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                            child: CircularProgressIndicator());
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
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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

  updateRecord() async {
    if (selectedData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: errorColor, content: Text("No record selected!")));
      return;
    } else {
      if (selectedData.length > 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: errorColor, content: Text("Invalid selection!")));
        return;
      } else {
        for (var data in db.Employees) {
          if (data['emailaddress'] == selectedData[0][4]) {
            print('can update now');
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return Center(child: CircularProgressIndicator());
                });
            try {
              if (await db.updateEmployee(
                      selectedField!.toLowerCase() == 'firstname'
                          ? newValueController.text.trim()
                          : selectedData[0][1],
                      selectedField!.toLowerCase() == 'lastname'
                          ? newValueController.text.trim()
                          : selectedData[0][2],
                      selectedField!.toLowerCase() == 'gender'
                          ? newValueController.text.trim()
                          : selectedData[0][3],
                      selectedData[0][4],
                      selectedField!.toLowerCase() == 'nationality'
                          ? newValueController.text.trim()
                          : selectedData[0][5],
                      selectedField!.toLowerCase() == 'stateoforigin'
                          ? newValueController.text.trim()
                          : selectedData[0][6],
                      selectedField!.toLowerCase() == 'phonenumber'
                          ? newValueController.text.trim()
                          : selectedData[0][7],
                      selectedField!.toLowerCase() == 'homeaddress'
                          ? newValueController.text.trim()
                          : selectedData[0][8],
                      selectedField!.toLowerCase() == 'dateofemployment'
                          ? newValueController.text.trim()
                          : selectedData[0][9],
                      selectedField!.toLowerCase() == 'designation'
                          ? newValueController.text.trim()
                          : selectedData[0][10],
                      selectedField!.toLowerCase() == 'password'
                          ? newValueController.text.trim()
                          : selectedData[0][11]) ==
                  true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: primaryColor2,
                    content: Text("Operation succeeded. Please wait..")));
              } else {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: errorColor,
                    content: Text("Operation failed!")));
              }
            } on Exception catch (error) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: errorColor,
                  content: Text("No internet connection!")));
            }
          }
        }
        Navigator.of(context).pop();
        setState(() {
          emailController.text = '';
          newValueController.text = '';
          selectedField = null;
          isSearchEmployee = null;
          selectedData.clear();
        });
        getUserData1();
        getUserData1b();
        getUserData2();
      }
    }
  }

  getData(List originalList) {
    int len = db.Employees.length + 1;
    late var x = 0;
    late var y = 9;
    for (var i = 1; i < len; i += 1) {
      if (i == 1) {
        mainItem.add(originalList.sublist(x, y));
      } else {
        x += 9;
        y += 9;
        mainItem.add(originalList.sublist(x, y));
      }
    }
  }

  downloadEmployeesRecord() async {
    final downloadFilePathForEmployees =
        "${Directory.current.path}/downloads/employees.csv";
    late List liveData = [];
    late List liveData2 = [];

    final List employeesHeader = [
      [
        'Hotel',
        'First Name',
        'Last Name',
        'Gender',
        'Email Address',
        'Nationality',
        'State of Origin',
        'Phone Number',
        'Home Address',
        'Date of Employment',
        'Designation',
        'Password',
      ]
    ];
    List<List<dynamic>> employeesRow = [];

    await db.fetchEmployees();
    int len2 = db.Employees.length + 1;
    for (var data in db.Employees) {
      liveData.add(data['hotel']);
      liveData.add(data['firstname']);
      liveData.add(data['lastname']);
      liveData.add(data['gender']);
      liveData.add(data['emailaddress']);
      liveData.add(data['nationality']);
      liveData.add(data['stateoforigin']);
      liveData.add(data['phonenumber']);
      liveData.add(data['homeaddress'].toString());
      liveData.add(data['dateofemployment']);
      liveData.add(data['designation']);
      liveData.add(data['password']);
    }
    late var x = 0;
    late var y = 12;
    for (var i = 1; i < len2; i += 1) {
      if (i == 1) {
        liveData2.add(liveData.sublist(x, y));
      } else if (i > 1) {
        x += 12;
        y += 12;
        liveData2.add(liveData.sublist(x, y));
      }
    }

    for (var data in employeesHeader) {
      employeesRow.add(data);
    }
    for (var data in liveData2) {
      employeesRow.add(data);
    }
    String employeesCsv = const ListToCsvConverter().convert(employeesRow);
    try {
      File employeesCsvFile = File(downloadFilePathForEmployees);
      await employeesCsvFile.writeAsString(employeesCsv);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: primaryColor2,
          content: Text("Operation succeeded..")));
    } on FileSystemException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: errorColor,
          content: Text("Please close 'employees.csv' first!")));
    }
  }

  @override
  void initState() {
    getUserData2();
    gender = null;
    nationality = null;
    stateOfOrigin = null;
    designation = null;
    selectedField = null;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    newValueController.dispose();
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
            backgroundColor: errorColor,
            foregroundColor: whiteColor,
            child: Icon(Icons.delete),
            label: 'Delete employee',
            onTap: () async {
              await deleteRecord();
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.teal,
            foregroundColor: whiteColor,
            child: Icon(Icons.update),
            label: 'Update employee',
            onTap: () async {
              final form = _formKey2.currentState!;
              if (selectedData.isNotEmpty) {
                if (selectedField != null) {
                  if (form.validate()) {
                    await updateRecord();
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: errorColor,
                      content: Text("No field selected!")));
                  return;
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: errorColor,
                    content: Text("No record selected!")));
                return;
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.amberAccent,
            foregroundColor: whiteColor,
            child: Icon(Icons.search_rounded),
            label: 'Search employee',
            onTap: () async {
              final form = _formKey.currentState!;
              if (form.validate()) {
                setState(() {
                  selectedData.clear();
                  isSearchEmployee = true;
                });
              }
            },
          ),
          SpeedDialChild(
            backgroundColor: primaryColor,
            foregroundColor: whiteColor,
            child: Icon(Icons.add),
            label: 'Add employee',
            onTap: () async {
              await Navigator.push(
                  context, CustomPageRoute(widget: AddEmployee()));
            },
          ),
          SpeedDialChild(
            backgroundColor: primaryColor2,
            foregroundColor: whiteColor,
            child: Icon(Icons.refresh_rounded),
            label: 'Refresh',
            onTap: () async {
              setState(() {
                selectedData.clear();
                emailController.text = '';
                isSearchEmployee = null;
              });
            },
          ),
        ],
      ),
      backgroundColor: customBackgroundColor,
      appBar: buildAppBar(context, "Employees", blackColor, true),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          buildSearchArea(context),
          SizedBox(height: size.height * 0.005),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info, size: size.width * 0.015),
              SizedBox(width: size.width * 0.002),
              Text('Download employees record?',
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
                  await downloadEmployeesRecord();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SizedBox(height: size.height * 0.005),
          buildTable(context),
        ],
      ),
    );
  }

  Widget buildSearchArea(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.23,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.22,
                child: Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: RoundedInputFieldMain(
                            controller: emailController,
                            width: size.width * 0.17,
                            horizontalGap: size.width * 0.01,
                            verticalGap: size.height * 0.001,
                            radius: size.width * 0.005,
                            mainText: '',
                            labelText: 'Search by email address',
                            icon: Icons.email,
                            isEnabled: true,
                            onChanged: (value) {
                              value = emailController.text.trim();
                            })),
                  ],
                ),
              ),
              SizedBox(width: size.width * 0.12),
              SizedBox(
                height: size.height * 0.22,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: transparentColor, width: 2),
                            color: whiteColor,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text('Select a field'),
                              value: selectedField,
                              iconSize: 30,
                              items: fields.map(buildFields).toList(),
                              onChanged: (value) async => setState(() {
                                selectedField = value;
                              }),
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.01),
                        Form(
                          key: _formKey2,
                          child: RoundedInputFieldMain(
                              controller: newValueController,
                              width: size.width * 0.15,
                              horizontalGap: size.width * 0.01,
                              verticalGap: size.height * 0.001,
                              radius: size.width * 0.005,
                              mainText: '',
                              labelText: 'Enter a new parameter',
                              icon: Icons.edit_note_rounded,
                              isEnabled: true,
                              onChanged: (value) {
                                value = newValueController.text.trim();
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTable(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.53,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: FutureBuilder(
          future: isSearchEmployee == null ? getUserData1() : getUserData1b(),
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
                        minWidth: size.width * 0.91,
                        dataRowColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) =>
                                states.contains(MaterialState.selected)
                                    ? primaryColor
                                    : customBackgroundColor),
                        showCheckboxColumn: false,
                        columns: <DataColumn>[
                          DataColumn(label: Text('Hotel')),
                          DataColumn(label: Text('First Name')),
                          DataColumn(label: Text('Last Name')),
                          DataColumn(label: Text('Gender')),
                          DataColumn(label: Text('Email Address')),
                          DataColumn(label: Text('Nationality')),
                          DataColumn(label: Text('State of Origin')),
                          DataColumn(label: Text('Phone Number')),
                          DataColumn(label: Text('Home Address')),
                          DataColumn(label: Text('Date of Employment')),
                          DataColumn(label: Text('Designation')),
                          DataColumn(label: Text('Password')),
                        ],
                        rows: isSearchEmployee == false
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
                            : <DataRow>[
                                for (var item in liveData2)
                                  if (item[4] == emailController.text.trim())
                                    DataRow(
                                        selected: selectedData.contains(item),
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
