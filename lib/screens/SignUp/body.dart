// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, unused_catch_clause

import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/background.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/components/rounded_password_field.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/main.dart';
import 'package:flutter/material.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final hotelController = TextEditingController();
  final emailController = TextEditingController();
  final authCodeController = TextEditingController();
  final securityAnswerController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    hotel = null;
    gender = null;
    designation = null;
    securityQ = null;
    securityQ2 = null;
    super.initState();
  }

  @override
  void dispose() {
    hotel = null;
    firstnameController.dispose();
    lastnameController.dispose();
    hotelController.dispose();
    gender = null;
    emailController.dispose();
    authCodeController.dispose();
    securityAnswerController.dispose();
    designation = null;
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainWindow(
        backButton: BackButton(color: primaryColor),
        destroyApp: true,
        child: Row(
          children: [
            LeftSide(),
            RightSide(
              fname: firstnameController,
              lname: lastnameController,
              hotelName: hotelController,
              email: emailController,
              password: passwordController,
              confirmPassword: confirmPasswordController,
              authCode: authCodeController,
              securityAnswer: securityAnswerController,
            )
          ],
        ),
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width * 0.4,
        child: Column(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/signupBody.png'),
                fit: BoxFit.fill,
              )),
            ))
          ],
        ));
  }
}

class RightSide extends StatefulWidget {
  RightSide({
    Key? key,
    required this.fname,
    required this.lname,
    required this.hotelName,
    required this.email,
    required this.authCode,
    required this.password,
    required this.confirmPassword,
    required this.securityAnswer,
  }) : super(key: key);
  final TextEditingController fname;
  final TextEditingController lname;
  final TextEditingController hotelName;
  final TextEditingController email;
  final TextEditingController authCode;
  final TextEditingController securityAnswer;
  final TextEditingController password;
  final TextEditingController confirmPassword;

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  final _formKey = GlobalKey<FormState>();
  final genders = {"", "Male", "Female", "Others"};
  final questions = {
    "",
    "Mother's maiden name",
    "Favourite color",
    "Favourite celebrity"
  };
  final designations = {'', 'Owner', 'Manager'};

  DropdownMenuItem<String> buildHotels(String Hotel) => DropdownMenuItem(
      value: Hotel,
      child: Text(
        Hotel,
      ));

  DropdownMenuItem<String> buildDesignations(String Designation) =>
      DropdownMenuItem(
          value: Designation,
          child: Text(
            Designation,
          ));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Scaffold(
        backgroundColor: customBackgroundColor,
        body: Background(
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: size.height * 0.05),
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: size.height * 0.05),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: transparentColor, width: 2),
                          color: whiteColor,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.edit_location_rounded,
                              color: primaryColor),
                          title: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text('Select your Hotel'),
                              isExpanded: true,
                              value: hotel,
                              iconSize: 30,
                              items: db.Hotels.map(buildHotels).toList(),
                              onChanged: (value) async => setState(() {
                                hotel = value;
                              }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      RoundedInputField2a(
                        controller: widget.fname,
                        warningText: 'First name cannot be blank!',
                        hintText: 'First name',
                        icon: Icons.person,
                        onChanged: (value) {
                          value = widget.fname.text;
                        },
                      ),
                      RoundedInputField2a(
                        controller: widget.lname,
                        warningText: 'Last name cannot be blank!',
                        hintText: 'Last name',
                        icon: Icons.person,
                        onChanged: (value) {
                          value = widget.lname.text;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: transparentColor, width: 2),
                          color: whiteColor,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.supervised_user_circle_rounded,
                              color: primaryColor),
                          title: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text('Gender'),
                              value: gender,
                              iconSize: 30,
                              items: genders.map(selectGender).toList(),
                              onChanged: (value) async => setState(() {
                                gender = value;
                              }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      RoundedInputFieldEmail(
                        controller: widget.email,
                        hintText: "Email address",
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: transparentColor, width: 2),
                          color: whiteColor,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.edit_note_rounded,
                              color: primaryColor),
                          title: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text('Security Question'),
                              value: securityQ,
                              iconSize: 30,
                              items: questions.map(selectQuestion).toList(),
                              onChanged: (value) async => setState(() {
                                securityQ = value;
                              }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      RoundedInputField3a(
                          controller: widget.securityAnswer,
                          hintText: 'Security answer',
                          onChanged: (value) {
                            value = widget.securityAnswer.text;
                          }),
                      SizedBox(height: size.height * 0.02),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: transparentColor, width: 2),
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
                              items:
                                  designations.map(buildDesignations).toList(),
                              onChanged: (value) async => setState(() {
                                designation = value;
                              }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      RoundedInputField3b(
                        width: size.width * 0.4,
                        radius: 20,
                        controller: widget.authCode,
                        hideText: true,
                        mainText: '',
                        hintText: 'Authorization code',
                        warningText: 'Enter a valid authorization code!',
                        onChanged: (value) {
                          value = widget.authCode.text;
                        },
                      ),
                      RoundedPasswordFieldB(
                        controller: widget.password,
                        name: 'Password',
                      ),
                      RoundedRetypePasswordField(
                        controller1: widget.password,
                        controller2: widget.confirmPassword,
                        name: 'Retype password',
                      ),
                      SizedBox(height: size.height * 0.01),
                      RoundedButton(
                        text1: 'Sign Up',
                        text2: 'Creating account...',
                        isLoading: false,
                        getData: () {},
                        authenticate: () async {
                          final form = _formKey.currentState!;
                          if (hotel != null && hotel != '') {
                            if (form.validate()) {
                              if (gender != null &&
                                  gender != '' &&
                                  securityQ != null &&
                                  securityQ != '' &&
                                  designation != null &&
                                  designation != '') {
                                try {
                                  if (await db.adminSignUp(
                                          hotel,
                                          widget.fname.text.trim(),
                                          widget.lname.text.trim(),
                                          gender,
                                          widget.email.text.trim(),
                                          securityQ,
                                          widget.securityAnswer.text.trim(),
                                          designation,
                                          widget.authCode.text.trim(),
                                          widget.password.text.trim()) ==
                                      true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: primaryColor,
                                            content: Text(
                                                "Account created successfully..")));
                                    Navigator.of(context).pop();
                                  } else {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return dialog.ReturnDialog1(
                                            title: Text('Error'),
                                            message: 'Account creation failed!',
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
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: errorColor,
                                        content:
                                            Text("All fields are required!")));
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: errorColor,
                                content: Text("Select your hotel!")));
                            return;
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.05),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> selectGender(String Gender) => DropdownMenuItem(
      value: Gender,
      child: Text(
        Gender,
      ));
  DropdownMenuItem<String> selectQuestion(String question) => DropdownMenuItem(
      value: question,
      child: Text(
        question,
      ));
}
