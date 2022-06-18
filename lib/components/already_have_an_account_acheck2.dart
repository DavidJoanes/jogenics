// ignore_for_file: prefer_const_constructors

import 'package:JoGenics/components/custom_page_route.dart';
import 'package:JoGenics/screens/SignUp/body.dart';
import 'package:flutter/material.dart';
import 'package:JoGenics/constants.dart';

class AlreadyHaveAnAccountCheck2a extends StatelessWidget {
  final Function press;
  const AlreadyHaveAnAccountCheck2a({
    Key? key,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              GestureDetector(
                child: const Text(
                  "Don't have an Account ?",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(width: 7),
              GestureDetector(
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      CustomPageRoute(widget: SignUpBody()),
                    );
                  }),
            ],
          ),
        )
      ],
    );
  }
}

class ForgotPassword extends StatelessWidget {
  final String text1;
  final String text2;
  final Function onTap;
  const ForgotPassword({
    Key? key,
    required this.text1,
    required this.text2,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 1),
          child: Row(
            children: [
              GestureDetector(
                child: Text(
                  text1,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(width: 7),
              GestureDetector(
                  child: Text(
                    text2,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    onTap();
                  }),
            ],
          ),
        )
      ],
    );
  }
}
