// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unused_catch_clause, non_constant_identifier_names, file_names
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/background.dart';
import 'package:JoGenics/components/custom_page_route.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/components/rounded_password_field.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/main.dart';
import 'package:JoGenics/screens/Home/UserHome/body.dart';
import 'package:flutter/material.dart';

class SignInBodyUser extends StatefulWidget {
  const SignInBodyUser({Key? key}) : super(key: key);

  @override
  State<SignInBodyUser> createState() => _SignInBodyUserState();
}

class _SignInBodyUserState extends State<SignInBodyUser> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    hotel = null;
    gender = null;
    nationality = null;
    stateOfOrigin = null;
    designation = null;
    securityQ = null;
    securityQ2 = null;
    selectedField = null;
    super.initState();
  }

  @override
  void dispose() {
    hotel = null;
    emailController.dispose();
    passwordController.dispose();
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
            RightSide(email: emailController, password: passwordController)
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
                image: AssetImage('assets/images/loginBody.png'),
                fit: BoxFit.fill,
              )),
            ))
          ],
        ));
  }
}

class RightSide extends StatefulWidget {
  RightSide({Key? key, required this.email, required this.password})
      : super(key: key);
  final TextEditingController email;
  final TextEditingController password;

  void dispose() {
    email.dispose();
    password.dispose();
  }

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  final _formKey = GlobalKey<FormState>();

  DropdownMenuItem<String> buildHotels(String Hotel) => DropdownMenuItem(
      value: Hotel,
      child: Text(
        Hotel,
      ));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Scaffold(
        backgroundColor: customBackgroundColor,
        body: Background(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: SizedBox(height: size.height * 0.005)),
                      Image.asset(
                        "assets/icons/JOGENICS.png",
                        height: size.height * 0.35,
                      ),
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
                      RoundedInputFieldEmailSignIn(
                        controller: widget.email,
                        hintText: "Email address",
                      ),
                      RoundedPasswordFieldA(
                        controller: widget.password,
                      ),
                      SizedBox(height: size.height * 0.01),
                      RoundedButton(
                        text1: 'Sign In',
                        text2: 'Authenticating...',
                        isLoading: false,
                        getData: () {},
                        authenticate: () async {
                          // Navigator.push(
                          //     context, CustomPageRoute(widget: UserHome()));
                          final form = _formKey.currentState!;
                          if (hotel != null && hotel != '') {
                            if (form.validate()) {
                              try {
                                if (await db.employeeSignIn(
                                        hotel,
                                        widget.email.text.trim(),
                                        widget.password.text.trim()) ==
                                    true) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return dialog.ReturnDialog1(
                                          title: Text('Success'),
                                          message:
                                              'Authentication successful..',
                                          color: primaryColor,
                                          buttonText: 'Ok',
                                          onPressed: () {
                                            widget.email.text = '';
                                            widget.password.text = '';
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                              context,
                                              CustomPageRoute(
                                                  widget: UserHome()),
                                            );
                                          },
                                        );
                                      });
                                }else {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return dialog.ReturnDialog1(
                                          title: Text('Error'),
                                          message: 'Authentication failed!',
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
            ),
          ),
        ),
      ),
    );
  }
}
