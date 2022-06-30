// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/background.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/components/rounded_password_field.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/main.dart';
import 'package:flutter/material.dart';

class ResetPasswordBody extends StatefulWidget {
  const ResetPasswordBody({Key? key}) : super(key: key);

  @override
  State<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<ResetPasswordBody> {
  final emailController = TextEditingController();
  final securityAnswerController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    securityQ = null;
    securityQ2 = null;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    securityAnswerController.dispose();
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
              email: emailController,
              securityAnswer: securityAnswerController,
              password: passwordController,
              confirmPassword: confirmPasswordController,
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
                image: AssetImage('assets/images/forgotPasswordBody.png'),
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
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.securityAnswer,
  }) : super(key: key);
  final TextEditingController email;
  final TextEditingController securityAnswer;
  final TextEditingController password;
  final TextEditingController confirmPassword;

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  final _formKey = GlobalKey<FormState>();

  final questions = {
    "",
    "Mother's maiden name",
    "Favourite color",
    "Favourite celebrity"
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Scaffold(
        backgroundColor: customBackgroundColor,
        body: Background(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
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
                              value: securityQ2,
                              iconSize: 30,
                              items: questions.map(selectQuestion).toList(),
                              onChanged: (value) async => setState(() {
                                securityQ2 = value;
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
                      RoundedPasswordFieldB(
                        controller: widget.password,
                        name: 'New password',
                      ),
                      RoundedRetypePasswordField(
                        controller1: widget.password,
                        controller2: widget.confirmPassword,
                        name: 'Retype password',
                      ),
                      SizedBox(height: size.height * 0.01),
                      RoundedButton(
                        text1: 'Reset',
                        text2: 'Reseting...',
                        isLoading: false,
                        getData: () {},
                        authenticate: () async {
                          final form = _formKey.currentState!;
                          if (form.validate()) {
                            try {
                              if (await db.resetPassword(widget.email.text, securityQ2,
                                      widget.securityAnswer.text, widget.password.text) ==
                                  true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: primaryColor2,
                                        content: Text("Reset successful..")));
                                Navigator.of(context).pop();
                              } else {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return dialog.ReturnDialog1(
                                            title: Text('Error'),
                                            message: 'Operation failed!\nPlease note: New password must not be the same as old password.',
                                            color: errorColor,
                                            buttonText: 'Retry',
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        });

                              }
                            } on Exception {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: errorColor,
                                      content:
                                          Text("No internet connection!")));
                            }
                          }
                        },
                      ),
                      SizedBox(height: size.height * 0.05),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> selectQuestion(String question) => DropdownMenuItem(
      value: question,
      child: Text(
        question,
      ));
}
