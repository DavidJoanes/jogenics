// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, depend_on_referenced_packages

import 'package:JoGenics/components/title_case.dart';
import 'package:JoGenics/constants.dart';
import 'package:flutter/material.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:mailto/mailto.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

final mailtoLinkError = Mailto(
  to: [db.CompanyEmailAddress],
  // cc: ['cc1@example.com', 'cc2@example.com'],
  subject: 'Unknown Error Occured',
  body: 'Greetings,\n',
);
final mailtoLinkPayment = Mailto(
  to: [db.CompanyEmailAddress],
  subject: 'Subscription Package Purchased',
  body:
      "Greetings,\n\nI wish to state that I have just purchased the {package name} subscription package.\nPlease, find attached a proof of payment as I duly await your confirmation.\n\nHotel Name:  ${db.HotelName.toTitleCase()}\nHotel's Email Address:  ${db.HotelEmailAddress}\n ",
);

Future<void> launchInBrowser(String url) async {
  if (await UrlLauncherPlatform.instance.canLaunch(url)) {
    await UrlLauncherPlatform.instance.launch(
      url,
      useSafariVC: false,
      useWebView: false,
      enableJavaScript: false,
      enableDomStorage: false,
      universalLinksOnly: false,
      headers: <String, String>{},
    );
  } else {
    throw 'Could not launch $url';
  }
}

Widget launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
  if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
  } else {
    return const Text('');
  }
}

// const Padding(padding: EdgeInsets.all(16.0)),
// FutureBuilder<void>(future: _launched, builder: _launchStatus),

class ReturnDialog1 extends StatefulWidget {
  ReturnDialog1(
      {Key? key,
      required this.title,
      required this.message,
      required this.buttonText,
      required this.color,
      required this.onPressed})
      : super(key: key);
  final Widget title;
  final String message;
  final String buttonText;
  final Color color;
  final Function onPressed;

  @override
  State<ReturnDialog1> createState() => _ReturnDialog1State();
}

class _ReturnDialog1State extends State<ReturnDialog1> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      content: Text(
        widget.message,
        style: TextStyle(
          color: widget.color,
        ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            widget.onPressed();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
          ),
          child: Text(widget.buttonText),
        ),
      ],
    );
  }
}

class ReturnDialog2 extends StatefulWidget {
  ReturnDialog2(
      {Key? key,
      required this.title,
      required this.buttonText,
      required this.color,
      required this.onPressed})
      : super(key: key);
  final Widget title;
  final String buttonText;
  final Color color;
  final Function onPressed;

  @override
  State<ReturnDialog2> createState() => _ReturnDialog2State();
}

class _ReturnDialog2State extends State<ReturnDialog2> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            widget.onPressed();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
          ),
          child: Text(widget.buttonText),
        ),
      ],
    );
  }
}

class ReturnDialog3 extends StatefulWidget {
  ReturnDialog3(
      {Key? key,
      required this.title,
      required this.message,
      required this.buttonText1,
      required this.buttonText2,
      required this.color,
      required this.onPressed1,
      required this.onPressed2})
      : super(key: key);
  final Widget title;
  final String message;
  final String buttonText1;
  final String buttonText2;
  final Color color;
  final Function onPressed1;
  final Function onPressed2;

  @override
  State<ReturnDialog3> createState() => _ReturnDialog3State();
}

class _ReturnDialog3State extends State<ReturnDialog3> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      content: Text(
        widget.message,
        style: TextStyle(
          color: widget.color,
        ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            widget.onPressed1();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
          ),
          child: Text(widget.buttonText1),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onPressed2();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
          ),
          child: Text(widget.buttonText2),
        ),
      ],
    );
  }
}

class ReturnDialog4 extends StatefulWidget {
  ReturnDialog4(
      {Key? key,
      required this.title,
      required this.message,
      required this.button1Text,
      required this.button2Text,
      required this.color,
      required this.onPressed1,
      required this.onPressed2,})
      : super(key: key);
  final Widget title;
  final String message;
  final String button1Text;
  final String button2Text;
  final Color color;
  final Function onPressed1;
  final Function onPressed2;

  @override
  State<ReturnDialog4> createState() => _ReturnDialog4State();
}

class _ReturnDialog4State extends State<ReturnDialog4> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      content: Text(
        widget.message,
        style: TextStyle(
          color: widget.color,
        ),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            widget.onPressed1();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(errorColor),
          ),
          child: Text(widget.button1Text),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onPressed2();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
          ),
          child: Text(widget.button2Text),
        ),
      ],
    );
  }
}
