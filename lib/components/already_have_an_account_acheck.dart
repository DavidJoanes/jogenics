import 'package:flutter/material.dart';
import 'package:JoGenics/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            login ? "Don’t have an Account ? " : "Already have an Account ? ",
            style: const TextStyle(
              color: primaryLightColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        GestureDetector(
          onTap: press(),
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: const TextStyle(
              color: primaryLightColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
