// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/screens/Home/AdminHome/FlutterwavePayment/key.dart';
import 'package:JoGenics/screens/Home/AdminHome/FlutterwavePayment/verify.dart';
// import 'package:JoGenics/screens/Home/AdminHome/PaystackPayment/verify_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:paystack_flutter/paystack_flutter.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  final _formKey = GlobalKey<FormState>();
  final String currency = FlutterwaveCurrency.NGN;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  bool useExistingData = false;
  ValueNotifier checkBox = ValueNotifier(usePrefilledData);

  @override
  void initState() {
    super.initState();
    setState(() {
      db.SubscriptionDaysLeft < 1
          ? db.SubscriptionCheck = false
          : db.SubscriptionCheck = true;
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/subscriptions.png'),
              fit: BoxFit.fill)),
      child: Scaffold(
        appBar: buildAppBar(context, 'Subscription', whiteColor, true),
        backgroundColor: whiteColor3,
        body: buildDesktopScreen(context, db.CompanyEmailAddress),
      ),
    );
  }

  Widget buildDesktopScreen(BuildContext context, email) {
    Size size = MediaQuery.of(context).size;
    var style = TextStyle(
      fontSize: size.width * 0.01,
      fontWeight: FontWeight.w800,
      color: navyBlueColor,
    );
    return Column(
      children: [
        SizedBox(height: size.height * 0.15),
        Center(
          child: Image.asset('assets/icons/JOGENICS.png', scale: 0.8),
        ),
        SizedBox(height: size.height * 0.05),
        Container(
          height: size.height * 0.06,
          width: size.width * 0.3,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                db.SubscriptionCheck == true
                    ? db.SubscriptionDaysLeft < 2
                        ? 'You have ${db.SubscriptionDaysLeft} day left on your current plan.'
                        : 'You have ${db.SubscriptionDaysLeft} days left on your current plan.'
                    : 'You currently do not have an active subscription.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: style,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.1),
        Center(
          child: Text(
            "Subscription packages",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  fontSize: size.width * 0.008,
                  color: navyBlueColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
          child: Divider(color: navyBlueColor),
        ),
        SizedBox(height: size.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: size.width * 0.1),
            SizedBox(
              height: size.height * 0.25,
              width: size.width * 0.35,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: packages.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return dialog.ReturnDialog2(
                                title: Row(children: [
                                  RoundedButtonEditProfile(
                                    text: 'Transfer',
                                    color: primaryColor,
                                    onPressed: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return dialog.ReturnDialog4(
                                              title: Text(
                                                  "Payment with Transfer ($currency ${packages[index]['price']})"),
                                              message:
                                                  "Once you make payment, click on 'Done' to send us a mail with a proof of payment attached. Upon receiving your mail, it can take a minimum of 1 hour and a maximum of 12 hours for us to confirm your payment.\n\nAccount Number: ${db.AccountNumber}\nAccount Name: ${db.AccountName.toUpperCase()}\nBank: ${db.Bank.toUpperCase()}",
                                              color: navyBlueColor,
                                              button1Text: 'Cancel',
                                              onPressed1: () {
                                                Navigator.of(context).pop();
                                              },
                                              button2Text: 'Done',
                                              onPressed2: () {
                                                setState(() {
                                                  dialog.launchInBrowser(dialog
                                                      .mailtoLinkPayment
                                                      .toString());
                                                });
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          });
                                    },
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  RoundedButtonEditProfile(
                                    text: 'Flutterwave',
                                    color: primaryColor,
                                    onPressed: () {
                                      db.registeredJoGenics
                                          ? showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return dialog.ReturnDialog3(
                                                    title: Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        children: [
                                                          RoundedInputField3c(
                                                              controller:
                                                                  firstNameController,
                                                              mainText: '',
                                                              hintText:
                                                                  "First name",
                                                              icon:
                                                                  Icons.person,
                                                              onChanged:
                                                                  (value) {
                                                                value =
                                                                    firstNameController
                                                                        .text
                                                                        .trim();
                                                              }),
                                                          SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.01),
                                                          RoundedInputField3c(
                                                              controller:
                                                                  lastNameController,
                                                              mainText: '',
                                                              hintText:
                                                                  "Last name",
                                                              icon:
                                                                  Icons.person,
                                                              onChanged:
                                                                  (value) {
                                                                value =
                                                                    lastNameController
                                                                        .text
                                                                        .trim();
                                                              }),
                                                          SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.01),
                                                          RoundedInputField3b(
                                                            width: size.width *
                                                                0.4,
                                                            radius: 20,
                                                            controller:
                                                                phoneController,
                                                            hideText: false,
                                                            mainText: '',
                                                            hintText:
                                                                "Phone number",
                                                            warningText:
                                                                'Enter a valid phone number!',
                                                            icon: Icons.numbers,
                                                            onChanged: (value) {
                                                              value =
                                                                  phoneController
                                                                      .text
                                                                      .trim();
                                                            },
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.01),
                                                          RoundedInputFieldEmail(
                                                              controller:
                                                                  emailController,
                                                              hintText:
                                                                  'Email address'),
                                                          SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.01),
                                                          ValueListenableBuilder(
                                                              valueListenable:
                                                                  checkBox,
                                                              builder: (context,
                                                                  value,
                                                                  child) {
                                                                return CheckboxListTile(
                                                                    title: Text(
                                                                        'Use existing hotel details?'),
                                                                    value: checkBox
                                                                        .value,
                                                                    onChanged:
                                                                        (newValue) {
                                                                      // newValue = true;
                                                                      setState(
                                                                          () {
                                                                        // useExistingData =
                                                                        //     !useExistingData;
                                                                        checkBox.value =
                                                                            newValue;
                                                                      });
                                                                    });
                                                              })
                                                        ],
                                                      ),
                                                    ),
                                                    message: '',
                                                    color: navyBlueColor,
                                                    buttonText1: 'Cancel',
                                                    onPressed1: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    buttonText2: 'Pay',
                                                    onPressed2: () async {
                                                      final form = _formKey
                                                          .currentState!;
                                                      if (checkBox.value) {
                                                        MakePayment(
                                                                context:
                                                                    context,
                                                                currency:
                                                                    currency,
                                                                fullname: db
                                                                    .HotelName,
                                                                phonenumber: db
                                                                    .HotelPhone,
                                                                emailaddress: db
                                                                    .HotelEmailAddress,
                                                                amount: packages[
                                                                            index]
                                                                        [
                                                                        'price']
                                                                    .toString(),
                                                                encryptionkey:
                                                                    ConstantKey
                                                                        .FLUTTERWAVE_ENCRYPTION_KEY,
                                                                publickey:
                                                                    ConstantKey
                                                                        .FLUTTERWAVE_PUBLIC_KEY)
                                                            .makeFlutterwavePayment();
                                                      } else {
                                                        if (form.validate()) {
                                                          MakePayment(
                                                                  context:
                                                                      context,
                                                                  currency:
                                                                      currency,
                                                                  fullname:
                                                                      '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
                                                                  phonenumber:
                                                                      phoneController
                                                                          .text
                                                                          .trim(),
                                                                  emailaddress:
                                                                      emailController
                                                                          .text
                                                                          .trim(),
                                                                  amount:
                                                                      '${packages[index]['price']}',
                                                                  encryptionkey:
                                                                      ConstantKey
                                                                          .FLUTTERWAVE_ENCRYPTION_KEY,
                                                                  publickey:
                                                                      ConstantKey
                                                                          .FLUTTERWAVE_PUBLIC_KEY)
                                                              .makeFlutterwavePayment();
                                                        }
                                                      }
                                                    }
                                                    // },
                                                    );
                                              })
                                          : showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return dialog.ReturnDialog1(
                                                  title: Text('Coming soon!'),
                                                  message: 'This payment method is currently under maintenance. Please, use the Transfer method and follow the instructions carefully. We apologize for any inconvinience this may cause you.',
                                                  color: navyBlueColor,
                                                  buttonText: 'Ok',
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                              });
                                    },
                                  ),
                                ]),
                                buttonText: 'Cancel',
                                color: primaryColor,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.007),
                        height: size.height * 0.2,
                        width: size.height * 0.2,
                        decoration: BoxDecoration(
                          color: primaryColor2b,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: size.width * 0.015,
                              left: size.width * 0.01,
                              child: Text(packages[index]['name'],
                                  style: TextStyle(
                                      fontFamily: 'Biko',
                                      fontSize: size.width * 0.018,
                                      color: whiteColor)),
                            ),
                            Positioned(
                              top: size.width * 0.036,
                              left: size.width * 0.01,
                              child: Text(
                                  '${currency.toString()} ${packages[index]['price'].toString()}/month',
                                  style: TextStyle(
                                      fontFamily: 'Biko',
                                      fontSize: size.width * 0.008,
                                      color: whiteColor)),
                            ),
                            Positioned(
                              bottom: size.width * 0.02,
                              left: size.width * 0.01,
                              child: Text(
                                packages[index]['description'],
                                style: TextStyle(
                                    fontSize: size.width * 0.0055,
                                    color: whiteColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ],
    );
  }

  List packages = [
    {
      'name': 'Basic',
      'price': db.BasicPackagePrice,
      'description': '- Limited customer database size.'
    },
    {
      'name': 'Standard',
      'price': db.StandardPackagePrice,
      'description':
          '- Unlimited customer database size.\n\n- Complete access to the analysis tab.'
    },
  ];
}
