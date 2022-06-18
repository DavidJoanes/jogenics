import 'package:JoGenics/constants.dart';
import 'package:flutter/material.dart';

Future<dynamic> buildLogoutWidget(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('JoGenics HMS'),
          content:
              const Text('Do you wish to logout?', textAlign: TextAlign.center),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor),
              ),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(errorColor),
              ),
              child: const Text('Yes'),
            ),
          ],
        );
      });
}
