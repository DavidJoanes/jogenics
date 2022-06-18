// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:JoGenics/components/text_field_container.dart';
import 'package:JoGenics/constants.dart';

class RoundedInputFieldEmail extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  RoundedInputFieldEmail({
    Key? key,
    required this.controller,
    required this.hintText,
    this.icon = Icons.mail,
  }) : super(key: key);

  @override
  State<RoundedInputFieldEmail> createState() => _RoundedInputFieldEmailState();
}

class _RoundedInputFieldEmailState extends State<RoundedInputFieldEmail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      width: size.width * 0.4,
      radius: 20,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        validator: (value) => value != null && !EmailValidator.validate(value)
            ? 'Enter a valid email!'
            : null,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
          ),
          labelText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedInputFieldEmailSignIn extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  RoundedInputFieldEmailSignIn({
    Key? key,
    required this.controller,
    required this.hintText,
    this.icon = Icons.mail,
  }) : super(key: key);

  @override
  State<RoundedInputFieldEmailSignIn> createState() =>
      _RoundedInputFieldEmailSignInState();
}

class _RoundedInputFieldEmailSignInState
    extends State<RoundedInputFieldEmailSignIn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      width: size.width * 0.4,
      radius: 20,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        validator: (value) => value != null && !EmailValidator.validate(value)
            ? 'Enter a valid email!'
            : null,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedInputField2a extends StatefulWidget {
  final TextEditingController controller;
  final String warningText;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField2a({
    Key? key,
    required this.controller,
    required this.warningText,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedInputField2a> createState() => _RoundedInputField2aState();
}

class _RoundedInputField2aState extends State<RoundedInputField2a> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      width: size.width * 0.4,
      radius: 20,
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        validator: (value) =>
            value == null || value == '' ? widget.warningText : null,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
          ),
          suffixIcon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          labelText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedInputField3a extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField3a({
    Key? key,
    required this.controller,
    required this.hintText,
    this.icon = Icons.question_answer_rounded,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedInputField3a> createState() => _RoundedInputField3aState();
}

class _RoundedInputField3aState extends State<RoundedInputField3a> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      width: size.width * 0.4,
      radius: 20,
      child: TextFormField(
        style: TextStyle(color: Colors.grey.shade900),
        controller: widget.controller,
        onChanged: widget.onChanged,
        cursorColor: primaryColor,
        validator: (value) => value == null || value == '' ? 'Required!' : null,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
          ),
          labelText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedInputField3b extends StatefulWidget {
  final double width;
  final double radius;
  final TextEditingController controller;
  final bool hideText;
  final String mainText;
  final String hintText;
  final String warningText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField3b({
    Key? key,
    required this.width,
    required this.radius,
    required this.controller,
    required this.hideText,
    required this.mainText,
    required this.hintText,
    required this.warningText,
    this.icon = Icons.numbers_rounded,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedInputField3b> createState() => _RoundedInputField3bState();
}

class _RoundedInputField3bState extends State<RoundedInputField3b> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: widget.width,
      radius: widget.radius,
      child: TextFormField(
        style: TextStyle(color: Colors.grey.shade900),
        controller: widget.controller,
        obscureText: widget.hideText,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9, +]')),
        ],
        validator: (value) =>
            value == null || value == '' || value.startsWith(' ')
                ? widget.warningText
                : null,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
          ),
          labelText: widget.hintText,
          hintText: widget.mainText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedInputField3b2 extends StatefulWidget {
  final double width;
  final double radius;
  final TextEditingController controller;
  final String mainText;
  final String hintText;
  final String warningText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField3b2({
    Key? key,
    required this.width,
    required this.radius,
    required this.controller,
    required this.mainText,
    required this.hintText,
    required this.warningText,
    this.icon = Icons.numbers_rounded,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedInputField3b2> createState() => _RoundedInputField3b2State();
}

class _RoundedInputField3b2State extends State<RoundedInputField3b2> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: widget.width,
      radius: widget.radius,
      child: TextFormField(
        style: TextStyle(color: Colors.grey.shade900),
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9, +]')),
        ],
        validator: (value) => value == null ||
                value == '' ||
                value.startsWith(' ') ||
                value.startsWith('0')
            ? widget.warningText
            : null,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
          ),
          labelText: widget.hintText,
          hintText: widget.mainText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class RoundedInputField3c extends StatefulWidget {
  final TextEditingController controller;
  final String mainText;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField3c({
    Key? key,
    required this.controller,
    required this.mainText,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedInputField3c> createState() => _RoundedInputField3cState();
}

class _RoundedInputField3cState extends State<RoundedInputField3c> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFieldContainer(
      width: size.width * 0.4,
      radius: 20,
      child: TextFormField(
        style: TextStyle(color: Colors.grey.shade900),
        controller: widget.controller,
        onChanged: widget.onChanged,
        cursorColor: primaryColor,
        keyboardType: TextInputType.emailAddress,
        validator: (value) => value == null || value == '' ? 'Required!' : null,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
          ),
          labelText: widget.hintText,
          hintText: widget.mainText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// MAIN ENTRY FIELD
class RoundedInputFieldMain extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final double horizontalGap;
  final double verticalGap;
  final double radius;
  final String mainText;
  final String labelText;
  final IconData icon;
  final bool isEnabled;
  final ValueChanged<String> onChanged;
  const RoundedInputFieldMain({
    Key? key,
    required this.controller,
    required this.width,
    required this.horizontalGap,
    required this.verticalGap,
    required this.radius,
    required this.mainText,
    required this.labelText,
    required this.icon,
    required this.isEnabled,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedInputFieldMain> createState() => _RoundedInputFieldMainState();
}

class _RoundedInputFieldMainState extends State<RoundedInputFieldMain> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer3(
      width: widget.width,
      horizontalGap: widget.horizontalGap,
      verticalGap: widget.verticalGap,
      radius: widget.radius,
      child: TextFormField(
        style: TextStyle(color: Colors.grey.shade900),
        controller: widget.controller,
        onChanged: widget.onChanged,
        cursorColor: primaryColor,
        enabled: widget.isEnabled ? true : false,
        keyboardType: TextInputType.emailAddress,
        validator: (value) => value == null || value == '' ? 'Required!' : null,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
          ),
          labelText: widget.labelText,
          hintText: widget.mainText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// MAIN ENTRY FIELD 2
class RoundedInputFieldMain2 extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final double horizontalGap;
  final double verticalGap;
  final double radius;
  final String mainText;
  final String labelText;
  final String warningText;
  final validator;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputFieldMain2({
    Key? key,
    required this.controller,
    required this.width,
    required this.horizontalGap,
    required this.verticalGap,
    required this.radius,
    required this.mainText,
    required this.labelText,
    required this.warningText,
    required this.validator,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedInputFieldMain2> createState() => _RoundedInputFieldMain2State();
}

class _RoundedInputFieldMain2State extends State<RoundedInputFieldMain2> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer3(
      width: widget.width,
      horizontalGap: widget.horizontalGap,
      verticalGap: widget.verticalGap,
      radius: widget.radius,
      child: TextFormField(
        style: TextStyle(color: Colors.grey.shade900),
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        onChanged: widget.onChanged,
        cursorColor: primaryColor,
        validator: (value) =>
            (widget.validator != null && widget.validator != '') &&
                        value == null ||
                    value == '' ||
                    value!.startsWith(' ')
                ? widget.warningText
                : null,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
          ),
          labelText: widget.labelText,
          hintText: widget.mainText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// MAIN ENTRY FIELD 2b
class RoundedInputFieldMain2b extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final double horizontalGap;
  final double verticalGap;
  final double radius;
  final String mainText;
  final String labelText;
  final String warningText;
  final validator;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputFieldMain2b({
    Key? key,
    required this.controller,
    required this.width,
    required this.horizontalGap,
    required this.verticalGap,
    required this.radius,
    required this.mainText,
    required this.labelText,
    required this.warningText,
    required this.validator,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedInputFieldMain2b> createState() =>
      _RoundedInputFieldMain2bState();
}

class _RoundedInputFieldMain2bState extends State<RoundedInputFieldMain2b> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer3(
      width: widget.width,
      horizontalGap: widget.horizontalGap,
      verticalGap: widget.verticalGap,
      radius: widget.radius,
      child: TextFormField(
        style: TextStyle(color: Colors.grey.shade900),
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        onChanged: widget.onChanged,
        cursorColor: primaryColor,
        validator: (value) =>(widget.validator == 'DISCOUNTED') &&
                (value == '' || value!.startsWith(' '))
            ? widget.warningText
            : null,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
          ),
          labelText: widget.labelText,
          hintText: widget.mainText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// MAIN ENTRY FIELD 2c
class RoundedInputFieldMain2c extends StatefulWidget {
  final TextEditingController controller;
  final double width;
  final double horizontalGap;
  final double verticalGap;
  final double radius;
  final String mainText;
  final String labelText;
  final String warningText1;
  final String warningText2;
  final String currentUser;
  final validator;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputFieldMain2c({
    Key? key,
    required this.controller,
    required this.width,
    required this.horizontalGap,
    required this.verticalGap,
    required this.radius,
    required this.mainText,
    required this.labelText,
    required this.warningText1,
    required this.warningText2,
    required this.currentUser,
    required this.validator,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedInputFieldMain2c> createState() =>
      _RoundedInputFieldMain2cState();
}

class _RoundedInputFieldMain2cState extends State<RoundedInputFieldMain2c> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer3(
      width: widget.width,
      horizontalGap: widget.horizontalGap,
      verticalGap: widget.verticalGap,
      radius: widget.radius,
      child: TextFormField(
        style: TextStyle(color: Colors.grey.shade900),
        controller: widget.controller,
        onChanged: widget.onChanged,
        cursorColor: primaryColor,
        validator: (value) => (widget.validator == 'POS') &&
                (value == '' || value!.startsWith(' '))
            ? widget.warningText1
            : (widget.validator == 'TRANSFER') &&
                    (value == null ||
                        value == '' ||
                        value.startsWith(' ') ||
                        !value.contains(widget.currentUser))
                ? widget.warningText2
                : null,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
          ),
          labelText: widget.labelText,
          hintText: widget.mainText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
