// ignore_for_file: prefer_const_constructors
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/custom_page_route.dart';
import 'package:JoGenics/components/title_case.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/components/display_picture.dart';
import 'package:JoGenics/screens/Home/UserHome/profile_picture.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var style1 = TextStyle(
        fontSize: size.width * 0.03,
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontFamily: 'Isocpeur');
    var style2 = TextStyle(
        fontSize: size.width * 0.013,
        color: navyBlueColor,
        fontWeight: FontWeight.w400,
        fontFamily: 'Isocpeur');

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/home.png'), fit: BoxFit.fill)
      ),
      child: Scaffold(
        backgroundColor: whiteColor3,
        appBar: buildAppBar(context, "Profile", blackColor, true),
        body: ListView(
          controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          children: [
            ProfilePicture(
              radius: size.width*0.07,
              radius2: size.width*0.018,
              radius3: size.width*0.016,
              isEdit: false,
              pressChangePicture: () {},
              pressEdit: () async {
              },
              imagePath: '',
              onClicked: () async {
                Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                  return DisplayPicture(
                    image:
                        AssetImage('assets/images/default_profile_picture.png'),
                  );
                }));
              },
            ),
            SizedBox(height: size.height * 0.01),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${db.CurrentLoggedInUserFirstname.toTitleCase()} ${db.CurrentLoggedInUserLastname.toTitleCase()}',
                    // '',
                    style: style1,
                  ),
                  Text(
                    db.CurrentLoggedInUserEmail,
                    style: style2,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Divider(),
            SizedBox(height: size.height * 0.03),
            buildDetails(context),
          ],
        ),
      ),
    );
  }

  // Widget buildDetails(User user) => Container(
  Widget buildDetails(context) {
    Size size = MediaQuery.of(context).size;
    final style1 = TextStyle(
      fontSize: size.width * 0.016,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
      // fontFamily: 'Isocpeur'
    );
    final style2 = TextStyle(
      fontSize: size.width * 0.013,
      fontWeight: FontWeight.w400,
      color: navyBlueColor,
      // fontFamily: 'Isocpeur'
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hotel's Name",
            style: style1,
          ),
          SizedBox(height: size.height * 0.007),
          Text(
            db.HotelName.toTitleCase(),
            style: style2,
          ),
          Divider(),
          SizedBox(height: size.height * 0.02),
          Text(
            "Hotel's Email Address",
            style: style1,
          ),
          SizedBox(height: size.height * 0.007),
          Text(
            db.HotelEmailAddress,
            style: style2,
          ),
          Divider(),
          SizedBox(height: size.height * 0.02),
          Text(
            "Hotel's Phone Number",
            style: style1,
          ),
          SizedBox(height: size.height * 0.007),
          Text(
            db.HotelPhone,
            style: style2,
          ),
          Divider(),
          SizedBox(height: size.height * 0.02),
          Text(
            "Hotel's Address",
            style: style1,
          ),
          SizedBox(height: size.height * 0.007),
          Text(
            db.HotelAddress.toTitleCase(),
            style: style2,
          ),
          Divider(),
          SizedBox(height: size.height * 0.02),
          Text(
            'Province',
            style: style1,
          ),
          SizedBox(height: size.height * 0.007),
          Text(
            db.HotelProvince.toTitleCase(),
            style: style2,
          ),
          Divider(),
          SizedBox(height: size.height * 0.02),
          Text(
            'Country',
            style: style1,
          ),
          SizedBox(height: size.height * 0.007),
          Text(
            db.HotelCountry.toTitleCase(),
            style: style2,
          ),
          Divider(),
          SizedBox(height: size.height * 0.02),
          Text(
            'Currency',
            style: style1,
          ),
          SizedBox(height: size.height * 0.007),
          Text(
            db.HotelCurrency.toUpperCase(),
            style: style2,
          ),
          Divider(),
          SizedBox(height: size.height * 0.02),
          Text(
            'Rooms Rate',
            style: style1,
          ),
          SizedBox(height: size.height * 0.007),
          Text(
            'Standard: ${db.StandardRoomRate}, Executive: ${db.ExecutiveRoomRate}, Presidential: ${db.PresidentialRoomRate}',
            style: style2,
          ),
          Divider(),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }
}
