// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, unused_catch_clause

// import 'dart:convert';
// import 'package:JoGenics/components/custom_page_route.dart';
// import 'package:JoGenics/components/user.dart';
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/components/rounded_password_field.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/constants.dart';
// import 'package:JoGenics/screens/Home/AdminHome/body.dart';
import 'package:data_table_2/data_table_2.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Administrators extends StatefulWidget {
  const Administrators({Key? key}) : super(key: key);

  @override
  State<Administrators> createState() => _AdministratorsState();
}

class _AdministratorsState extends State<Administrators> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late List liveData = [];
  late List liveData2 = [];
  List selectedData = [];
  late List mainItem = [];

  changeIsSearchToFalse() {
    setState(() {
      isSearchAdmin = false;
    });
  }

  getUserData1() async {
    await db.adminSignIn(db.HotelName, db.CurrentLoggedInUserEmail,
        db.CurrentLoggedInUserPassword);
    changeIsSearchToFalse();
    return db.Administrators;
  }

  getUserData1b() async {
    // await db.adminSignIn(db.HotelName, db.CurrentLoggedInUserEmail,
    //     db.CurrentLoggedInUserPassword);
    return db.Administrators;
  }

  getUserData2() async {
    await db.fetchAdministrators();
    liveData = [];
    liveData2 = [];
    int len = db.Administrators.length + 1;
    for (var data in db.Administrators) {
      liveData.add(data['firstname']);
      liveData.add(data['lastname']);
      liveData.add(data['gender']);
      liveData.add(data['emailaddress']);
      liveData.add(data['securityquestion']);
      liveData.add(data['securityanswer']);
      liveData.add(data['designation']);
      liveData.add(data['authorizationcode'].toString());
      liveData.add(data['password']);
    }
    late var x = 0;
    late var y = 9;
    for (var i = 1; i < len; i += 1) {
      if (i == 1) {
        liveData2.add(liveData.sublist(x, y));
      } else if (i > 1) {
        x += 9;
        y += 9;
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: errorColor, content: Text("Invalid selection!")));
        return;
      } else {
        for (var data in db.Administrators) {
          if (data['emailaddress'] == selectedData[0][3]) {
            if (selectedData[0][3] == db.CurrentLoggedInUserEmail) {
              print('cant delete');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: errorColor,
                  content: Text("Operation denied!")));
              // return;
            } else {
              if (db.CurrentLoggedInUserDesignation == 'manager' &&
                  data['designation'] == 'owner') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: errorColor,
                    content: Text("Operation failed!")));
              } else {
                print('can delete now');
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
                                  if (await db.findAdmin(selectedData[0][3]) ==
                                      true) {
                                    if (await db.deleteAdminRecord(
                                            selectedData[0][3]) ==
                                        true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: primaryColor2,
                                              content: Text(
                                                  "Operation succeeded. Please wait..")));
                                      Navigator.of(context).pop();
                                      setState(() {
                                        emailController.text = '';
                                        isSearchAdmin = null;
                                        selectedData.clear();
                                      });
                                      Navigator.of(context).pop();
                                      showDialog(
                                          barrierDismissible: false,
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
                                            content: Text(
                                                "Record does not exist!")));
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
  }

  getData(List originalList) {
    int len = db.Administrators.length + 1;
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

  @override
  void initState() {
    getUserData2();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
            backgroundColor: errorColor,
            foregroundColor: whiteColor,
            child: Icon(Icons.delete),
            label: 'Delete admin',
            onTap: () async {
              await deleteRecord();
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.amberAccent,
            foregroundColor: whiteColor,
            child: Icon(Icons.search_rounded),
            label: 'Search admin',
            onTap: () async {
              final form = _formKey.currentState!;
              if (form.validate()) {
                setState(() {
                  isSearchAdmin = true;
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
                emailController.text = '';
                isSearchAdmin = null;
              });
            },
          ),
        ],
      ),
      backgroundColor: customBackgroundColor,
      appBar: buildAppBar(context, "Administrators", blackColor, true),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.01),
          buildSearchArea(context),
          SizedBox(height: size.height * 0.01),
          buildTable(context),
        ],
      ),
    );
  }

  Widget buildSearchArea(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.13,
      child: Center(
        child: Form(
            key: _formKey,
            child: RoundedInputFieldMain(
                controller: emailController,
                width: size.width * 0.21,
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
      ),
    );
  }

  Widget buildTable(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.68,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: FutureBuilder(
          future: isSearchAdmin == null ? getUserData1() : getUserData1b(),
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
                          DataColumn(label: Text('First Name')),
                          DataColumn(label: Text('Last Name')),
                          DataColumn(label: Text('Gender')),
                          DataColumn(label: Text('Email Address')),
                          DataColumn(label: Text('Security Question')),
                          DataColumn(label: Text('Security Answer')),
                          DataColumn(label: Text('Designation')),
                          DataColumn(label: Text('Authorization Code')),
                          DataColumn(label: Text('Password')),
                        ],
                        rows: isSearchAdmin == false
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
                                          // for (var item in mainItem[0])
                                          // for (var item in liveData2.sublist(0, 2))
                                          //   for (var item2 in item.sublist(0, 9))
                                          DataCell(Text(item2)),
                                      ])
                              ]
                            : <DataRow>[
                                for (var item in liveData2)
                                  if (item[3] == emailController.text.trim())
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
