// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable, prefer_typing_uninitialized_variables
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/components/logout.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/restart.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:JoGenics/screens/Home/home.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';
// import 'package:firebase_core/firebase_core.dart';

late var initialSize;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(RestartWidget(child: MyApp(destroyApp: true)));
  doWhenWindowReady(() {
    initialSize = Size(800, 600);
    appWindow.size = initialSize;
    appWindow.minSize = initialSize;
    appWindow.title = "JoGenics HMS";
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
  await db.start();
}

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.destroyApp}) : super(key: key);
  final bool destroyApp;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener {
  // final Future<FirebaseApp> initializationFirebase = Firebase.initializeApp();

  @override
  void initState() {
    windowManager.addListener(this);
    _init();
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    // Add this line to override the default close handler
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
          backgroundColor: whiteColor,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Image.asset('assets/icons/error icon.png'),
                        Text(
                          'Something went wrong! Please restart the application.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: errorColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Report Error',
                              style: TextStyle(
                                color: primaryColor2,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    dialog.launchInBrowser(
                                        dialog.mailtoLinkError.toString());
                                  });
                                }),
                        ])),
                        SizedBox(height: 10),
                        Text('Or'),
                        SizedBox(height: 10),
                        RoundedButtonEditProfile(
                            text: 'Restart',
                            color: primaryColor2,
                            onPressed: () async {
                              RestartWidget.restartApp(context);
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JoGenics Hotel Management System',
      // home: FutureBuilder(
      //   future: initializationFirebase,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       print('Error');
      //     }
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return Scaffold(
      //         body: MainWindow(backButton: Text(''), child: Home()),
      //       );
      //     }
      //     return CircularProgressIndicator();
      //   },
      // )
      home: Scaffold(
        body: MainWindow(backButton: Text(''), destroyApp: widget.destroyApp, child: Home()),
      ),
    );
  }
}

class MainWindow extends StatefulWidget {
  const MainWindow(
      {Key? key,
      required this.child,
      required this.backButton,
      required this.destroyApp})
      : super(key: key);
  final Widget child;
  final Widget backButton;
  final bool destroyApp;

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WindowTitleBarBox(
          child: Row(
            children: [
              widget.backButton,
              Expanded(
                child: MoveWindow(),
              ),
              WindowButtons(destroyApp: widget.destroyApp),
            ],
          ),
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}

class MainWindowNavigation extends StatefulWidget {
  const MainWindowNavigation(
      {Key? key,
      required this.leftChild,
      required this.rightChild,
      required this.isLogout, required this.destroyApp})
      : super(key: key);
  final Widget leftChild;
  final Widget rightChild;
  final bool isLogout;
  final bool destroyApp;

  @override
  State<MainWindowNavigation> createState() => _MainWindowNavigationState();
}

class _MainWindowNavigationState extends State<MainWindowNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainWindow(
        backButton: IconButton(
            onPressed: () => widget.isLogout
                ? buildLogoutWidget(context)
                : Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, color: primaryColor)),
        destroyApp: widget.destroyApp,
        child: Row(
          children: [
            LeftSide(
              child: widget.leftChild,
            ),
            RightSide(child: widget.rightChild)
          ],
        ),
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  LeftSide({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width * 0.2,
        child: Column(
          children: [Expanded(child: child)],
        ));
  }
}

class RightSide extends StatefulWidget {
  RightSide({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: widget.child,
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  WindowButtons({Key? key, required this.destroyApp}) : super(key: key);
  late bool destroyApp;

  var buttonColors = WindowButtonColors(
    iconNormal: primaryColor,
    mouseOver: primaryLightColor,
    mouseDown: transparentColor,
    iconMouseOver: Colors.black54,
    iconMouseDown: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(
          colors: buttonColors,
          onPressed: () {
            closeWindow(context);
          },
        )
      ],
    );
  }

  closeWindow(BuildContext context) {
    destroyApp
        ? showDialog(
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
                    onPressed: () async {
                      Navigator.of(context).pop(true);
                      await windowManager.destroy();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(errorColor),
                    ),
                    child: const Text('Exit'),
                  ),
                ],
              );
            })
        : null;
  }
}
