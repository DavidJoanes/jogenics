// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:JoGenics/constants.dart';

class ProfilePicture extends StatelessWidget {
  ProfilePicture({
    Key? key,
    required this.imagePath,
    required this.radius,
    required this.radius2,
    required this.radius3,
    required this.isEdit,
    required this.onClicked,
    required this.pressEdit,
    required this.pressChangePicture,
  }) : super(key: key);

  final String imagePath;
  final double radius;
  final double radius2;
  final double radius3;
  final bool isEdit;
  final VoidCallback onClicked;
  final VoidCallback pressEdit;
  late Function pressChangePicture;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Stack(
      children: [
        Container(
          height: size.height * 0.35,
          width: double.infinity,
          decoration: BoxDecoration(
            color: primaryColor,
            image: DecorationImage(
                image: AssetImage('assets/images/home.png'), fit: BoxFit.cover),
          )
        ),
        Container(
          height: size.height*0.37,
          width: double.infinity,
          color: transparentColor,
        ),
        Positioned(
          bottom: 0,
          left: size.width*0.33,
          child: buildImage(),
        ),
      ],
    ));
  }

  Widget buildImage() {
    var decodedImage = const Base64Decoder().convert(imagePath);
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        // : FileImage(File(imagePath));
        : Image.memory(decodedImage).image;

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      backgroundImage: imagePath != ''
          ? image
          : AssetImage('assets/images/default_profile_picture.png'),
      child: InkWell(
        onTap: onClicked,
      ),
    );
  }
}
