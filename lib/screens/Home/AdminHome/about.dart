// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_catch_clause
import 'dart:io';
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:dio/dio.dart';
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  late bool isUpdate = false;

  Future<void> checkForUpdate() async {
    await db.fetchHotelData();
    if (double.parse(db.LatestAppVersion) > currentV) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return dialog.ReturnDialog1(
              title: Text('Update found'),
              message:
                  "Version:  ${db.LatestAppVersion}\nPlease contact us via email for the update.",
              color: navyBlueColor,
              buttonText: 'Ok',
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  isUpdate = true;
                });
              },
            );
          });
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return dialog.ReturnDialog1(
              title: Text('No Update found'),
              message: "The latest updates have been installed.",
              color: primaryColor,
              buttonText: 'Ok',
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
    }
  }

  late bool isDownloading;
  Future downloadNewVersion(String appPath) async {
    final fileName = appPath.split("/").last;
    isDownloading = true;
    setState(() {});

    final dio = Dio();

    final downloadFilePath = "${Directory.current.path}/$fileName";

    // var tempDirectory = await getTemporaryDirectory();
    // String fullPath = tempDirectory.path + fileName;

    await dio.downloadUri(
        Uri.parse(
            "https://doc-14-54-docs.googleusercontent.com/docs/securesc/b7lfd6866pc9s174pju4qvdhb8i68sts/lbi1464ctsilhth9ts3jje00p8r6hu9m/1655639625000/00372701968336813252/00372701968336813252/1wfNzAG0ogfBhYSfd1UXLgKXoPjkmRKVF?e=download&ax=ACxEAsbl4iGkINWZCQrYMu9hlhZ42UUyNKeU7HP8v8VqHEhvk2kvW3dMQ3AMSLBE20UoZmvdY3LkL9ECOWr9iPli0S9nZnnDUE_76Eqy1C-bSnMaYCgU-6MFEh7lW6Zh7P68RAv64w-DnSPlP851crlrJtUdSed45ysH4bzV8U49cKeMgWzy2UANn2nhBmee3vcwo8tWQaXeuI77CJ3pBT4s4nlOBJ8KwJmqZLAzdCOOAtt2QgM-CKMz0BZ4E-3kIVSbdlJlASbkXJipD-IFwEDBmkUWpsQnzs407Z27JT2qYnNPM6S4MjJgLjC1nssRhng_nh8vau4afMzldtqQ3XhKFpBnIGVf_yLoMZm-N4L17NbnOOeXzWEEB_qrXzAeTmqQNBEMenQN9pQQgM8T2q2TjG37fkPMmHDs8NNTIlPFXdFijyCyrTqmznzMlvALMP1Si2yqWY-4YETE_9MUe3eUG-0SuA2iSR6Vjym2PKRDTbQqyUQD4F2W7K9k9CM7Ox1IjKM7QRtTsz8AxPRRdpqiBaJx-kf9a7PVYZo8ai0PPiZJKuuAywvKFPqi8eT3lOuhewQt5kYSwTID-K6_qRR0aRKsA6yOFwGRdH-ltGUyB1knMVz_CwFaX-KwTaWW-Fe2CMYrZjETvjMZlW2h6ewErj5B5BNEKzhHiM6aFednaAtENgIsU1FKr2jFPim9Oj5VGNQjGI0xuwrE-RNRm2qFOx5vAktKbgzWWT4H5TS31No-KRl8&authuser=0&nonce=c68k6568eel30&user=00372701968336813252&hash=9pnjshhkcj1hfavkqe1s9c2vjvlseias"),
        // Uri.parse(
        //     "https://github.com/DavidJoanes/jogenics/blob/master/app_version_check/version.json?$appPath"),
        downloadFilePath, onReceiveProgress: (received, total) {
      final progress = (received / total) / 1000;
      debugPrint("Received: $received, Total: $progress%");
      // final downloadProgress = double.parse(progress.toStringAsFixed(1));
      setState(() {});
    });
    debugPrint("File download path:  $downloadFilePath");
    if (Platform.isWindows) {
      await openExeFile(downloadFilePath);
    }
    isDownloading = false;
    setState(() {});
  }

  Future<void> openExeFile(String filePath) async {
    await Process.start(filePath, ["-t", "-l", "1000"]).then((value) {});
  }

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
              RoundedButtonMain(
                text1: 'Check',
                text2: 'Checking..',
                fontSize1: size.width * 0.01,
                fontSize2: size.width * 0.008,
                width: size.width * 0.1,
                radius: size.width * 0.03,
                horizontalGap: size.width * 0.01,
                verticalGap: size.height * 0.02,
                color: primaryColor,
                isLoading: false,
                function: () async {
                  try {
                  await checkForUpdate();
                  } on Exception catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: errorColor,
                        content: Text("Service unavailable!")));
                  }
                },
              ),
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
                  SizedBox(width: size.width * 0.3),
                  Text('Email: jogenics@gmail.com\n\nPhone: +2349032688974',
                      style: TextStyle(
                          fontFamily: 'Biko',
                          fontSize: size.width * 0.01,
                          color: navyBlueColor,
                          letterSpacing: 0.5))
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
                    style: TextStyle(
                        fontFamily: 'Biko',
                        color: navyBlueColor,
                        letterSpacing: 0.5,
                        fontSize: size.width * 0.01),
                    textAlign: TextAlign.justify),
              )
            ]),
          ),
        ],
      )),
    );
  }
}
