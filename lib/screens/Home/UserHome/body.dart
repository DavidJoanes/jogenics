// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, must_be_immutable
import 'package:JoGenics/components/title_case.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/main.dart';
import 'package:JoGenics/screens/Home/UserHome/checkin.dart';
import 'package:JoGenics/screens/Home/UserHome/checkout.dart';
import 'package:JoGenics/screens/Home/UserHome/profile.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late int currentIndex = 0;

  late List pages = [
    Center(
      child: Profile(),
    ),
    Center(
      child: CheckIn(),
    ),
    Center(
      child: CheckOut(),
    ),
    // Center(
    //   child: Text('About'),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MainWindowNavigation(
      leftChild: buildLeftChild(
          fullname: db.CurrentLoggedInUserLastname.toTitleCase(),
          emailaddress: db.CurrentLoggedInUserEmail,
          selected0: true,
          selected1: false,
          selected2: false,
          selected3: false,
          selected4: false,
          selected5: false,
          selected6: false,
          selectedPage: (value) async {
            setState(() {
              currentIndex = value;
            });
          }),
      rightChild: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: pages[currentIndex],
        ),
      ),
      isLogout: true,
    );
  }
}

class buildLeftChild extends StatefulWidget {
  buildLeftChild(
      {Key? key,
      required this.fullname,
      required this.emailaddress,
      required this.selected0,
      required this.selected1,
      required this.selected2,
      required this.selected3,
      required this.selected4,
      required this.selected5,
      required this.selected6,
      required this.selectedPage})
      : super(key: key);
  final String fullname;
  final String emailaddress;
  late bool selected0,
      selected1,
      selected2,
      selected3,
      selected4,
      selected5,
      selected6;
  late Function selectedPage;

  @override
  State<buildLeftChild> createState() => _buildLeftChildState();
}

class _buildLeftChildState extends State<buildLeftChild> {
  late bool selected0 = widget.selected0;
  late bool selected1 = widget.selected1;
  late bool selected2 = widget.selected2;
  late bool selected3 = widget.selected3;
  late bool selected4 = widget.selected4;
  late bool selected5 = widget.selected5;
  late bool selected6 = widget.selected6;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor2,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.01, vertical: size.height * 0.02),
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              buildHeader(
                size1: size.width * 0.017,
                size2: size.width * 0.008,
                size3: size.width * 0.01,
                radius: size.width * 0.02,
                urlImage: AssetImage('assets/images/default_profile_picture.png'),
                name: widget.fullname,
                email: widget.emailaddress,
                onClicked: () {
                  setState(() {
                    selected0 = true;
                    selected1 = false;
                    selected2 = false;
                    selected3 = false;
                    selected4 = false;
                    selected5 = false;
                    selected6 = false;
                  });
                  widget.selectedPage(0);
                },
              ),
              SizedBox(height: size.height * 0.01),
              Divider(color: whiteColor),
              SizedBox(height: size.height * 0.03),
              buildNavigationButton(
                  size1: size.width * 0.01,
                  size2: size.width * 0.028,
                  size3: size.height * 0.02,
                  text: 'Check In',
                  icon: Icons.check_box_outlined,
                  selected: selected1,
                  onClicked: () {
                    setState(() {
                      selected0 = false;
                      selected1 = true;
                      selected2 = false;
                      selected3 = false;
                      selected4 = false;
                      selected5 = false;
                      selected6 = false;
                    });
                    widget.selectedPage(1);
                  }),
              SizedBox(height: size.height * 0.02),
              buildNavigationButton(
                  size1: size.width * 0.01,
                  size2: size.width * 0.028,
                  size3: size.height * 0.02,
                  text: 'Check Out',
                  icon: Icons.output_rounded,
                  selected: selected2,
                  onClicked: () {
                    setState(() {
                      selected0 = false;
                      selected1 = false;
                      selected2 = true;
                      selected3 = false;
                      selected4 = false;
                      selected5 = false;
                      selected6 = false;
                    });
                    widget.selectedPage(2);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader({
    required double size1,
    size2,
    size3,
    radius,
    required String name,
    required String email,
    required var urlImage,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: size2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size3),
            color: selected0 ? Colors.black12 : transparentColor,
          ),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: radius,
                backgroundImage: urlImage,
                backgroundColor: Colors.white,
              ),
              SizedBox(width: size3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: size1,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Isocpeur',
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                        fontSize: size2,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Widget buildNavigationButton({
    required double size1,
    size2,
    size3,
    required String text,
    required IconData icon,
    required bool selected,
    required Function onClicked,
  }) {
    const color = whiteColor;

    return ListTile(
      horizontalTitleGap: size3,
      minVerticalPadding: 24,
      leading: Icon(icon, color: color, size: size2),
      title: Text(
        text,
        style: TextStyle(
            color: color, fontWeight: FontWeight.w500, fontSize: size1),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: selected ? whiteColor : transparentColor),
      ),
      onTap: () {
        onClicked();
      },
    );
  }
}
