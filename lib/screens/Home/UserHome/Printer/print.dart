// ignore_for_file: avoid_print, prefer_const_constructors, depend_on_referenced_packages, prefer_typing_uninitialized_variables

// import 'dart:typed_data';
// import 'package:JoGenics/screens/Home/UserHome/Printer/imageStoreByte.dart';
// import 'package:JoGenics/screens/Home/UserHome/Printer/printer.dart';
import 'package:flutter/cupertino.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
// import 'dart:io';

class Print {
  Print(
      {required this.context,
      required this.ipAddress,
      required this.fileDirectory,
      required this.imageData,
      required this.screenShotData});

  final BuildContext context;
  final String ipAddress;
  final String fileDirectory;
  final imageData;
  final screenShotData;

  // ScreenshotController screenshotController = ScreenshotController();

  printTest() async {
    print("I'm inside the test print 2");
    // ignore: todo
    // TODO Don't forget to choose printer's paper size
    // const PaperSize paper = PaperSize.mm80;
    // final profile = await CapabilityProfile.load();
    // final printer = NetworkPrinter(paper, profile);

    // final PosPrintResult res = await printer.connect(ipAddress, port: 9100);

    // if (res == PosPrintResult.success) {
    //   // DEMO RECEIPT
    //   await testReceipt(printer, imageData);
    //   print(res.msg);
    //   await Future.delayed(Duration(seconds: 3), () {
    //     print("prinnter desconect");
    //     printer.disconnect();
    //   });
    // }
  }

  printNow() async {
    // screenshotController
    //     .capture(delay: Duration(milliseconds: 10))
    //     .then((capturedImage) async {
    //   theimageThatComesfromThePrinter = capturedImage!;
    //   setState(() {
    //     theimageThatComesfromThePrinter = capturedImage;
    //     printTest(Printer.text, theimageThatComesfromThePrinter);
    //   });
    // }).catchError((onError) {
    //   print(onError);
    // });
  }
}
