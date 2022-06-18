// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:JoGenics/constants.dart';
import 'package:flutter/material.dart';

class DisplayPicture extends StatefulWidget {
  DisplayPicture({Key? key, required this.image}) : super(key: key);
  late var image;
  // DisplayPicture({
  //   Key? key,
  //   required this.image,
  // }) : super(key: key);

  @override
  State<DisplayPicture> createState() => _DisplayPictureState();
}

class _DisplayPictureState extends State<DisplayPicture> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 0, vertical: size.height * 0.15),
      child: Container(
        decoration: BoxDecoration(
          color: transparentColor,
          // borderRadius: BorderRadius.circular(size.width * 0.1),
          image: DecorationImage(
            image: widget.image,
            fit: BoxFit.fitHeight,
          ),
    
        ),
        
      ),
    );
  }
}