// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_constructors, prefer_typing_uninitialized_variables
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/core/flutterwave.dart';

class MakePayment {
  MakePayment(
      {required this.context,
      required this.currency,
      required this.fullname,
      required this.phonenumber,
      required this.emailaddress,
      required this.amount,
      required this.encryptionkey,
      required this.publickey,
      required this.function});
  final BuildContext context;
  final currency;
  final String fullname;
  final String phonenumber;
  final String emailaddress;
  final String amount;
  final String encryptionkey;
  final String publickey;
  late Function function;

  makeFlutterwavePayment() async {
    try {
      Flutterwave flutterwave = Flutterwave.forUIPayment(
        context: context,
        currency: currency,
        fullName: fullname,
        phoneNumber: phonenumber,
        email: emailaddress,
        amount: amount,
        encryptionKey: encryptionkey,
        publicKey: publickey,
        txRef: DateTime.now().toIso8601String(),
        isDebugMode: true,
        acceptCardPayment: true,
        acceptBankTransfer: true,
        acceptUSSDPayment: true,
      );

      final response = await flutterwave.initializeForUiPayments();
      if (response.message == "Transaction fetched successfully") {
        await function();
        print(response.data);
        print(response.message);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return dialog.ReturnDialog1(
                title: Text('Success'),
                message: 'Transaction successful..\nPlease restart the application for changes to take effect completely.',
                buttonText: 'Okay',
                color: primaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              );
            });
      } else {
        print(response.message);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return dialog.ReturnDialog1(
                title: Text('Error'),
                message: 'Transaction failed!',
                buttonText: 'Retry',
                color: errorColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            });
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
