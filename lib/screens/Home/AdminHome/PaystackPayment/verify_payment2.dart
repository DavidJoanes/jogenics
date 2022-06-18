// // ignore_for_file: avoid_print

// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:paystack_manager/paystack_pay_manager.dart';

// class MakePayment {
//   MakePayment(
//       {required this.context,
//       required this.price,
//       required this.email,
//       required this.firstname,
//       required this.lastname});
//   BuildContext context;
//   int price;
//   String email, firstname, lastname;

//   void checkPayment() {
//     try {
//       PaystackPayManager(context: context)
//         ..setSecretKey("YOUR-SECRET-KEY")
//         ..setCompanyAssetImage(Image.asset('assets/icons/JOGENICS.png'))
//         ..setAmount(price*100)
//         ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
//         ..setCurrency("NGN")
//         ..setEmail(email)
//         ..setFirstName(firstname)
//         ..setLastName(lastname)
//         ..setMetadata(
//           {
//             "custom_fields": [
//               {
//                 "value": "TechWithSam",
//                 "display_name": "Payment_to",
//                 "variable_name": "Payment_to"
//               }
//             ]
//           },
//         )
//         ..onSuccesful(_onPaymentSuccessful)
//         ..onPending(_onPaymentPending)
//         ..onFailed(_onPaymentFailed)
//         ..onCancel(_onCancel)
//         ..initialize();
//     } catch (error) {
//       print('Payment Error ==> $error');
//     }
//   }

//   void _onPaymentSuccessful(Transaction transaction) {
//     print('Transaction succesful');
//     print(
//         "Transaction message ==> ${transaction.message}, Ref ${transaction.refrenceNumber}");
//   }

//   void _onPaymentPending(Transaction transaction) {
//     print('Transaction Pending');
//     print("Transaction Ref ${transaction.refrenceNumber}");
//   }

//   void _onPaymentFailed(Transaction transaction) {
//     print('Transaction Failed');
//     print("Transaction message ==> ${transaction.message}");
//   }

//   void _onCancel(Transaction transaction) {
//     print('Transaction Cancelled');
//   }
// }
