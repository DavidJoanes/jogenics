// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';
import 'package:JoGenics/screens/Home/AdminHome/PaystackPayment/constant_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class MakePayment {
  MakePayment(
      {required this.context, required this.price, required this.email});
  BuildContext context;
  int price;
  String email;

  //Reference
  String getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    print('ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}');
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  //GetUi
  PaymentCard _getCardUI() {
    return PaymentCard(number: "", cvc: "", expiryMonth: 0, expiryYear: 0);
  }

  final paystack = PaystackPlugin();
  Future initializePlugin() async {
    await paystack.initialize(publicKey: ConstantKey.PAYSTACK_KEY);
  }

  //Method Charging card
  chargeCardAndMakePayment() async {
    await initializePlugin().then((_) async {
      Charge charge = Charge()
        ..reference = getReference()
        ..amount = price * 100
        ..email = email
        ..card = _getCardUI();

      CheckoutResponse response = await paystack.checkout(
        context,
        charge: charge,
        method: CheckoutMethod.card,
        fullscreen: true,
        logo: Image.asset('assets/icons/JOGENICS.png'),
      );

      print("Response $response");

      if (response.status == true) {
        print("Transaction successful");
      } else {
        print("Transaction failed");
      }
    });
  }
}
