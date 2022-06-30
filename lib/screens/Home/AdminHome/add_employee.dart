// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_catch_clause

// import 'dart:convert';
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/components/title_case.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/components/rounded_password_field.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/main.dart';
import 'package:JoGenics/screens/Home/AdminHome/body.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
import 'package:JoGenics/components/countries.dart' as fetchcountries;

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  // final int currentIndex = 2;
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  final genders = {'', 'Male', 'Female', 'Others'};
  DropdownMenuItem<String> buildGenders(String Gender) => DropdownMenuItem(
      value: Gender,
      child: Text(
        Gender,
      ));

  final nationalities = {''};
  getCountries() async {
    for (var data in fetchcountries.countries) {
      nationalities.add(data['name'] as String);
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
          states.add(regions['name']);
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

  late String countryCode = '';
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

  final designations = {
    '',
    'Bartender',
    'Cook',
    'Receptionist',
    'Security',
    'Waiter'
  };
  DropdownMenuItem<String> buildDesignations(String Designation) =>
      DropdownMenuItem(
          value: Designation,
          child: Text(
            Designation,
          ));

  late DateTime dateOfEmployment = DateTime.now();
  late String dateOfEmployment1 = '';
  late String dateOfEmployment2 = '';
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    dateOfEmployment1 = formatted;
    return dateOfEmployment1;
  }

  String convertDateTimeDisplay2(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    dateOfEmployment2 = formatted;
    return dateOfEmployment2;
  }

  @override
  void initState() {
    gender = null;
    nationality = null;
    stateOfOrigin = null;
    designation = null;
    convertDateTimeDisplay(dateOfEmployment.toString());
    convertDateTimeDisplay2(dateOfEmployment.toString());
    getCountries();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
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
            selected2: true,
            selected3: false,
            selected4: false,
            selected5: false,
            selected6: false,
            selected7: false,
            selected8: false,
            selectedPage: () => null),
        rightChild: Scaffold(
            backgroundColor: customBackgroundColor,
            appBar: buildAppBar(context, 'Add Employee', blackColor, false),
            body: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.01),
                        RoundedInputField3c(
                            controller: firstNameController,
                            mainText: '',
                            hintText: "First name",
                            icon: Icons.person,
                            onChanged: (value) {
                              value = firstNameController.text.trim();
                            }),
                        SizedBox(height: size.height * 0.01),
                        RoundedInputField3c(
                            controller: lastNameController,
                            mainText: '',
                            hintText: "Last name",
                            icon: Icons.person,
                            onChanged: (value) {
                              value = lastNameController.text.trim();
                            }),
                        SizedBox(height: size.height * 0.02),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: transparentColor, width: 2),
                            color: whiteColor,
                          ),
                          child: ListTile(
                            leading: Icon(Icons.supervised_user_circle_rounded,
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
                        SizedBox(height: size.height * 0.02),
                        RoundedInputField3c(
                            controller: emailController,
                            mainText: '',
                            hintText: "Email address",
                            icon: Icons.email_rounded,
                            onChanged: (value) {
                              value = emailController.text.trim();
                            }),
                        SizedBox(height: size.height * 0.02),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: transparentColor, width: 2),
                            color: whiteColor,
                          ),
                          child: ListTile(
                            leading: Icon(Icons.edit_location_alt_rounded,
                                color: primaryColor),
                            title: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text('Nationality'),
                                isExpanded: true,
                                value: nationality,
                                iconSize: 30,
                                items: nationalities
                                    .map(buildNationalities)
                                    .toList(),
                                onChanged: (value) async => setState(() {
                                  nationality = value;
                                  getProvinces(nationality ?? '');
                                  getCountryCodes(nationality ?? '');
                                }),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: transparentColor, width: 2),
                            color: whiteColor,
                          ),
                          child: ListTile(
                            leading: Icon(Icons.edit_location_rounded,
                                color: primaryColor),
                            title: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text('State of Origin'),
                                isExpanded: true,
                                value: stateOfOrigin,
                                iconSize: 30,
                                items: states.map(buildStates).toList(),
                                onChanged: (value) async => setState(() {
                                  stateOfOrigin = value;
                                }),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        SizedBox(height: size.height * 0.01),
                        RoundedInputField3b(
                          width: size.width * 0.5,
                          radius: 20,
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
                        RoundedInputField3c(
                            controller: addressController,
                            mainText: '',
                            hintText: "Home address",
                            icon: Icons.location_on_rounded,
                            onChanged: (value) {
                              value = addressController.text.trim();
                            }),
                        SizedBox(height: size.height * 0.02),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: transparentColor, width: 2),
                            color: whiteColor,
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.edit_location_rounded,
                                    color: primaryColor),
                                title: Text(
                                    dateOfEmployment1 == dateOfEmployment2
                                        ? 'Date of employment ($dateOfEmployment2)'
                                        : 'Date of employment ($dateOfEmployment1)',
                                    style: TextStyle(color: Colors.black54)),
                                trailing: IconButton(
                                  icon: Icon(Icons.calendar_month_rounded,
                                      color: primaryColor),
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: dateOfEmployment,
                                            firstDate: DateTime(1990),
                                            lastDate: DateTime(2023))
                                        .then((date) => setState(() {
                                              dateOfEmployment = date!;
                                              convertDateTimeDisplay(
                                                  dateOfEmployment.toString());
                                            }));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: transparentColor, width: 2),
                            color: whiteColor,
                          ),
                          child: ListTile(
                            leading: Icon(Icons.edit_note_rounded,
                                color: primaryColor),
                            title: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text('Designation'),
                                isExpanded: true,
                                value: designation,
                                iconSize: 30,
                                items: designations
                                    .map(buildDesignations)
                                    .toList(),
                                onChanged: (value) async => setState(() {
                                  designation = value;
                                }),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        RoundedPasswordFieldB(
                          controller: passwordController,
                          name: 'Password',
                        ),
                        SizedBox(height: size.height * 0.05),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              color: customBackgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundedButtonMain(
                        text1: 'Add',
                        text2: 'Adding...',
                        fontSize1: size.width * 0.01,
                        fontSize2: size.width * 0.008,
                        width: size.width * 0.1,
                        horizontalGap: size.width * 0.01,
                        verticalGap: size.height * 0.02,
                        radius: size.width * 0.02,
                        isLoading: false,
                        function: () async {
                          final form = _formKey.currentState!;
                          if (gender != null &&
                              gender != '' &&
                              nationality != null &&
                              nationality != '' &&
                              stateOfOrigin != null &&
                              stateOfOrigin != '' &&
                              designation != null &&
                              designation != '') {
                            if (form.validate()) {
                              try {
                                if (await db.employeeSignUp(
                                        firstNameController.text.trim(),
                                        lastNameController.text.trim(),
                                        gender,
                                        emailController.text.trim(),
                                        nationality,
                                        stateOfOrigin,
                                        phoneController.text.trim(),
                                        addressController.text.trim(),
                                        dateOfEmployment1,
                                        designation,
                                        passwordController.text.trim()) ==
                                    true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: primaryColor2,
                                          content: Text(
                                              "${lastNameController.text.trim().toTitleCase()} added as $designation. Please restart this tab..")));
                                  Navigator.of(context).pop();
                                } else {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return dialog.ReturnDialog1(
                                          title: Text('Error'),
                                          message: 'Unable to add employee!',
                                          color: errorColor,
                                          buttonText: 'Retry',
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      });
                                }
                              } on Exception catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: errorColor,
                                        content:
                                            Text("No internet connection!")));
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: errorColor,
                                content: Text("All fields are required!")));
                          }
                        }),
                  ],
                ),
              ),
            )),
        isLogout: false, destroyApp: true);
  }
}
