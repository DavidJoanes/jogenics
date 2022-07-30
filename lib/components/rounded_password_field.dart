// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:JoGenics/components/text_field_container.dart';
import 'package:JoGenics/constants.dart';
// import 'package:http/http.dart' as http;

class RoundedPasswordFieldA extends StatefulWidget {
  final TextEditingController controller;
  // final ValueChanged<String> onChanged;
  const RoundedPasswordFieldA({
    Key? key,
    required this.controller,
    // required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordFieldA> createState() => _RoundedPasswordFieldAState();
}

class _RoundedPasswordFieldAState extends State<RoundedPasswordFieldA> {
  late bool isObscurePassword = false;
  var isObscurePasswordIcon1 =
      Icon(Icons.visibility_off_rounded, color: primaryColor);
  var isObscurePasswordIcon2 =
      Icon(Icons.remove_red_eye_rounded, color: primaryColor);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      width: size.width*0.4,
      radius: 20,
      child: TextFormField(
        obscureText:
            widget.controller.text.isNotEmpty ? isObscurePassword : false,
        controller: widget.controller,
        // onChanged: widget.onChanged,
        keyboardType: TextInputType.text,
        validator: (value) => value == '' ? 'Password cannot be blank!' : null,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: const Icon(
            Icons.lock,
            color: primaryColor,
          ),
          suffixIcon: IconButton(
            icon: isObscurePassword
                ? isObscurePasswordIcon2
                : isObscurePasswordIcon1,
            onPressed: () {
              setState(() {
                isObscurePassword = !isObscurePassword;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedPasswordFieldA2 extends StatefulWidget {
  final TextEditingController controller;
  const RoundedPasswordFieldA2({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<RoundedPasswordFieldA2> createState() => _RoundedPasswordFieldA2State();
}

class _RoundedPasswordFieldA2State extends State<RoundedPasswordFieldA2> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer2(
      child: TextFormField(
        obscureText: true,
        controller: widget.controller,
        keyboardType: TextInputType.text,
        validator: (value) => value == '' ? 'Password cannot be blank!' : null,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          labelText: "Current password",
          icon: const Icon(
            Icons.lock,
            color: primaryColor,
          ),
          // border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedPasswordFieldB extends StatefulWidget {
  final TextEditingController controller;
  final String name;
  const RoundedPasswordFieldB({
    Key? key,
    required this.controller,
    required this.name,
  }) : super(key: key);

  @override
  State<RoundedPasswordFieldB> createState() => _RoundedPasswordFieldBState();
}

class _RoundedPasswordFieldBState extends State<RoundedPasswordFieldB> {
  late bool isObscurePassword = false;
  var isObscurePasswordIcon1 =
      const Icon(Icons.visibility_off_rounded, color: primaryColor);
  var isObscurePasswordIcon2 =
      const Icon(Icons.remove_red_eye_rounded, color: primaryColor);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      width: size.width*0.4,
      radius: 20,
      child: Column(
        children: [
          TextField(
            obscureText:
                widget.controller.text.isNotEmpty ? isObscurePassword : false,
            controller: widget.controller,
            keyboardType: TextInputType.text,
            cursorColor: primaryColor,
            decoration: InputDecoration(
              labelText: widget.name,
              icon: const Icon(
                Icons.lock,
                color: primaryColor,
              ),
              suffixIcon: IconButton(
                icon: isObscurePassword
                    ? isObscurePasswordIcon2
                    : isObscurePasswordIcon1,
                onPressed: () {
                  setState(() {
                    isObscurePassword = !isObscurePassword;
                  });
                },
              ),
              border: InputBorder.none,
            ),
          ),
          FlutterPwValidator(
              controller: widget.controller,
              minLength: 8,
              numericCharCount: 1,
              specialCharCount: 1,
              width: size.width * 0.35,
              height: size.height * 0.15,
              onSuccess: () => success(widget.controller),
              onFail: failure(widget.controller)),
        ],
      ),
    );
  }

  success(value) {
    value != null ? null : 'Password cannot be blank!';
  }

  failure(value) {
    value == null ? 'Password cannot be blank!' : null;
    // return 'Password must be alphanumeric!';
  }
}

class RoundedPasswordFieldB2 extends StatefulWidget {
  final TextEditingController controller;
  const RoundedPasswordFieldB2({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<RoundedPasswordFieldB2> createState() => _RoundedPasswordFieldB2State();
}

class _RoundedPasswordFieldB2State extends State<RoundedPasswordFieldB2> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer2(
      child: Column(
        children: [
          TextField(
            obscureText: true,
            controller: widget.controller,
            keyboardType: TextInputType.emailAddress,
            cursorColor: primaryColor,
            decoration: InputDecoration(
              labelText: "Password",
              icon: const Icon(
                Icons.lock,
                color: primaryColor,
              ),
              border: InputBorder.none,
            ),
          ),
          FlutterPwValidator(
              controller: widget.controller,
              minLength: 6,
              uppercaseCharCount: 1,
              numericCharCount: 1,
              specialCharCount: 1,
              width: 400,
              height: 160,
              onSuccess: () => success(widget.controller),
              onFail: failure(widget.controller)),
        ],
      ),
    );
  }

  success(value) {
    value != null ? null : 'Password cannot be blank!';
  }

  failure(value) {
    value == null ? 'Password must be alphanumeric!' : null;
    // return 'Password must be alphanumeric!';
  }
}

class RoundedRetypePasswordField extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final String name;
  const RoundedRetypePasswordField({
    Key? key,
    required this.controller1,
    required this.controller2,
    required this.name,
  }) : super(key: key);

  @override
  State<RoundedRetypePasswordField> createState() => _RoundedRetypePasswordFieldState();
}

class _RoundedRetypePasswordFieldState extends State<RoundedRetypePasswordField> {
  late bool isObscurePassword = false;
  var isObscurePasswordIcon1 =
      const Icon(Icons.visibility_off_rounded, color: primaryColor);
  var isObscurePasswordIcon2 =
      const Icon(Icons.remove_red_eye_rounded, color: primaryColor);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      width: size.width*0.4,
      radius: 20,
      child: TextFormField(
        obscureText:
            widget.controller2.text.isNotEmpty ? isObscurePassword : false,
        controller: widget.controller2,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == '') return 'Password cannot be blank!';
          if (value != widget.controller1.text) {
            return 'Passwords do not match!';
          }

          return null;
        },
        cursorColor: primaryColor,
        decoration: InputDecoration(
          labelText: widget.name,
          icon: const Icon(
            Icons.lock,
            color: primaryColor,
          ),
          suffixIcon: IconButton(
            icon: isObscurePassword
                ? isObscurePasswordIcon2
                : isObscurePasswordIcon1,
            onPressed: () {
              setState(() {
                isObscurePassword = !isObscurePassword;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedConfirmPasswordField extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  const RoundedConfirmPasswordField({
    Key? key,
    required this.controller1,
    required this.controller2,
  }) : super(key: key);

  @override
  State<RoundedConfirmPasswordField> createState() => _RoundedConfirmPasswordFieldState();
}

class _RoundedConfirmPasswordFieldState extends State<RoundedConfirmPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer2(
      child: TextFormField(
        obscureText: true,
        controller: widget.controller2,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == '') return 'Password cannot be blank!';
          if (value != widget.controller1.text) {
            return 'Passwords do not match!';
          }

          return null;
        },
        cursorColor: primaryColor,
        decoration: InputDecoration(
          labelText: "Confirm password",
          icon: const Icon(
            Icons.lock,
            color: primaryColor,
          ),
          // border: InputBorder.none,
        ),
      ),
    );
  }
}
