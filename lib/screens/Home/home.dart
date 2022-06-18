// ignore_for_file: prefer_const_constructors

import 'package:JoGenics/components/custom_page_route.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/screens/SignIn/bodyAdmin.dart';
import 'package:JoGenics/screens/SignIn/bodyUser.dart';
import 'package:flutter/material.dart';
import 'package:JoGenics/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('JoGenics HMS'),
                content: const Text('Do you wish to exit?',
                    textAlign: TextAlign.center),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                    ),
                    child: const Text('Exit'),
                  ),
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var style1 = TextStyle(
        fontSize: size.width * 0.03,
        fontWeight: FontWeight.bold,
        color: whiteColor);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(children: [
          Positioned(
            top: size.height * 0.3,
            left: size.width * 0.35,
            child: Text("It's good to have you back..",
                style: GoogleFonts.dancingScript(
                  textStyle: style1,
                )),
          ),
          Positioned(
            top: size.height * 0.4,
            left: size.width * 0.25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundedButtonHome(
                  text: 'Admin',
                  icon: Icon(
                    Icons.admin_panel_settings_rounded,
                    size: size.width * 0.05,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      CustomPageRoute(widget: SignInBodyAdmin()),
                    );
                  },
                ),
                SizedBox(width: size.width * 0.1),
                RoundedButtonHome(
                  text: 'User',
                  icon: Icon(
                    Icons.supervised_user_circle_rounded,
                    size: size.width * 0.05,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      CustomPageRoute(widget: SignInBodyUser()),
                    );
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
