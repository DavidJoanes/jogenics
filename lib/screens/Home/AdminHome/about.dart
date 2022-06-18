// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: customBackgroundColor,
      appBar: buildAppBar(context, 'About', blackColor, true),
      body: Center(
          child: Column(
        children: [
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Check for update ?',
                  style: GoogleFonts.macondo(
                      textStyle: TextStyle(fontSize: size.width * 0.015))),
              SizedBox(width: size.width * 0.01),
              TextButton(
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationIcon: Image.asset('assets/icons/JOGENICS.png'),
                      applicationName: 'JoGenics Hotel Management Software',
                      applicationVersion: '1.0.0',
                      applicationLegalese:
                          'Developed by David Joanes Kemdirim (CEO, Jogenics).',
                    );
                  },
                  child: Text('Check',
                      style: GoogleFonts.macondo(
                          textStyle: TextStyle(
                              fontFamily: 'Biko',
                              color: primaryColor,
                              fontSize: size.width * 0.015))))
            ],
          ),
          SizedBox(height: size.height * 0.05),
          Container(
            alignment: Alignment.center,
            height: size.height * 0.7,
            width: size.width * 0.6,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(size.width * 0.02),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: size.width * 0.03,
                    backgroundColor: whiteColor,
                    backgroundImage: AssetImage('assets/icons/JOGENICS.png'),
                  ),
                  SizedBox(width: size.width*0.3),
                  Text('Email: jogenics@gmail.com\n\nPhone: +2349032688974', style: TextStyle(fontFamily: 'Biko', fontSize: size.width*0.01, color: navyBlueColor, letterSpacing: 0.5))
                ],
              ),
              SizedBox(height: size.height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Divider(),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Text(
                    "Copyright (c) 2022, Jogenics Ltd All Rights Reserved.\n\n\nJoGenics Hotel Management Software is a Software designed and developed solely by David Joanes Kemdirim.\nIt was designed for the purpose of enhancing Hotel businesses accross the world, especially in Nigeria. Currently, this Software is only for the use of Owners, Managers and Receptionists of Hotels accross the world, to aid them in the following aspects:\n\n1) It gives the owner/manager the priviledges to efficiently monitor and regulate almost all the activities in the hotel from anywhere at any time.\n\n2) It assists the owners and managers of hotels to store records of their employees and guests.\n\n3) It assists the owners and managers of hotels to seamlessly analyze the daily, monthly and yearly income of the Hotel via the 'Analysis' tab, without the need for a third party software.\n\n4) It assists the receptionist whom is an employee of the owner/Manager, to either check in or check out a guest in a coherent manner.",
                    style: TextStyle(fontFamily: 'Biko', color: navyBlueColor, letterSpacing: 0.5, fontSize: size.width*0.01),
                    textAlign: TextAlign.justify),
              )
            ]),
          ),
        ],
      )),
    );
  }
}
