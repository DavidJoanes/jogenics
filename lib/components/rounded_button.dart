// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable, no_logic_in_create_state, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:JoGenics/constants.dart';

// ADMIN
class RoundedButtonHome extends StatefulWidget {
  final String text;
  final Color color, textColor;
  final Icon icon;
  final Function onPressed;
  RoundedButtonHome({
    Key? key,
    required this.text,
    this.color = primaryColor,
    this.textColor = Colors.white,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<RoundedButtonHome> createState() => _RoundedButtonHomeState();
}

class _RoundedButtonHomeState extends State<RoundedButtonHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.2,
      height: size.height * 0.15,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: newElevatedButton(context),
      ),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 5, vertical: 16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            SizedBox(width: size.width * 0.01),
            Text(
              widget.text,
              style: TextStyle(
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.02),
            ),
          ],
        ),
        onPressed: () async {
          await widget.onPressed();
        });
  }
}

// GENERAL
class RoundedButtonGeneral extends StatefulWidget {
  final String text1;
  final String text2;
  final Color color, textColor;
  bool isLoading;
  final Function update;
  RoundedButtonGeneral({
    Key? key,
    required this.text1,
    required this.text2,
    required this.color,
    this.textColor = Colors.white,
    required this.isLoading,
    required this.update,
  }) : super(key: key);

  @override
  State<RoundedButtonGeneral> createState() => _RoundedButtonGeneralState();
}

class _RoundedButtonGeneralState extends State<RoundedButtonGeneral> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.17,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(context),
      ),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.color),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 5, vertical: 16)),
        ),
        child: widget.isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    widget.text2,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : Text(
                widget.text1,
                style: TextStyle(
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
        onPressed: () async {
          if (widget.isLoading) return;

          setState(() => widget.isLoading = true);
          await widget.update();
          // await Future.delayed(const Duration(seconds: 2));
          setState(() => widget.isLoading = false);
        });
  }
}

// GENERAL2
class RoundedButtonGeneral2 extends StatefulWidget {
  final String text1;
  final String text2;
  final Color color, textColor;
  bool isLoading;
  final Function update;
  RoundedButtonGeneral2({
    Key? key,
    required this.text1,
    required this.text2,
    required this.color,
    this.textColor = Colors.white,
    required this.isLoading,
    required this.update,
  }) : super(key: key);

  @override
  State<RoundedButtonGeneral2> createState() => _RoundedButtonGeneral2State();
}

class _RoundedButtonGeneral2State extends State<RoundedButtonGeneral2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.15,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(context),
      ),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.color),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 5, vertical: 16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text1,
              style: TextStyle(
                color: widget.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Text(
              widget.text2,
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        onPressed: () async {
          if (widget.isLoading) return;

          setState(() => widget.isLoading = true);
          await widget.update();
          // await Future.delayed(const Duration(seconds: 2));
          setState(() => widget.isLoading = false);
        });
  }
}

// LOGIN, SIGNUP, RESETPASSWORD
class RoundedButton extends StatefulWidget {
  RoundedButton(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.isLoading,
      required this.getData,
      required this.authenticate})
      : super(key: key);
  final String text1;
  final String text2;
  late bool isLoading;
  final Function getData;
  final Function authenticate;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(context),
      ),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
        ),
        child: widget.isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    widget.text2,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : Text(
                widget.text1,
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
        onPressed: () async {
          if (widget.isLoading) return;

          setState(() => widget.isLoading = true);
          widget.getData();
          await widget.authenticate();
          // await Future.delayed(const Duration(seconds: 3));
          setState(() => widget.isLoading = false);
        });
  }
}

// NAVIGATION BUTTON
class RoundedButtonNavigation extends StatefulWidget {
  RoundedButtonNavigation(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.authenticate})
      : super(key: key);
  final String text1;
  final String text2;
  final Function authenticate;

  @override
  State<RoundedButtonNavigation> createState() =>
      _RoundedButtonNavigationState();
}

class _RoundedButtonNavigationState extends State<RoundedButtonNavigation> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: newElevatedButton(context),
      ),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
        ),
        child: Text(
          widget.text1,
          style: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          await widget.authenticate();
        });
  }
}

// EDIT PROFILE
class RoundedButtonEditProfile extends StatefulWidget {
  final String text;
  final Color color, textColor;
  final Function onPressed;
  const RoundedButtonEditProfile({
    Key? key,
    required this.text,
    required this.color,
    this.textColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<RoundedButtonEditProfile> createState() =>
      _RoundedButtonEditProfileState();
}

class _RoundedButtonEditProfileState extends State<RoundedButtonEditProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.15,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(context),
      ),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.color),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 5, vertical: 16)),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          widget.onPressed();
        });
  }
}

// REMOVE PICTURE
class RoundedButtonRemovePicture extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  const RoundedButtonRemovePicture({
    Key? key,
    required this.text,
    required this.press,
    this.color = primaryColor,
  }) : super(key: key);

  final style = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.2,
      height: size.height * 0.12,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
      ),
      onPressed: press(),
      child: Column(children: [
        ClipOval(
          child: Icon(Icons.person_off_rounded, color: primaryColor, size: 40),
        ),
        SizedBox(height: 5),
        Text(
          text,
          style: style,
        )
      ]),
    );
  }
}

// CAMERA
class RoundedButtonCamera extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  const RoundedButtonCamera({
    Key? key,
    required this.text,
    required this.press,
    this.color = primaryColor,
  }) : super(key: key);

  final style = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.2,
      height: size.height * 0.12,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom
  Widget newElevatedButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
      ),
      onPressed: press(),
      child: Column(children: [
        ClipOval(
          child: Icon(Icons.camera_alt_rounded, color: primaryColor, size: 40),
        ),
        SizedBox(height: 5),
        Text(
          text,
          style: style,
        )
      ]),
    );
  }
}

// GALLERY
class RoundedButtonGallery extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  const RoundedButtonGallery({
    Key? key,
    required this.text,
    required this.press,
    this.color = primaryColor,
  }) : super(key: key);

  final style = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.2,
      height: size.height * 0.12,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom
  Widget newElevatedButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
      ),
      onPressed: press(),
      child: Column(children: [
        ClipOval(
          child: Icon(Icons.photo, color: primaryColor, size: 40),
        ),
        SizedBox(height: 5),
        Text(
          text,
          style: style,
        )
      ]),
    );
  }
}

// REFRESH ID
class RoundedButtonRefresh extends StatefulWidget {
  final Color color;
  final double size;
  final Function onPressed;
  const RoundedButtonRefresh({
    Key? key,
    required this.color,
    required this.size,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<RoundedButtonRefresh> createState() => _RoundedButtonRefreshState();
}

class _RoundedButtonRefreshState extends State<RoundedButtonRefresh> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.refresh, color: widget.color, size: widget.size),
      onPressed: () {
        widget.onPressed();
      },
    );
  }
}

// SEARCH ID
class RoundedButtonSearch extends StatefulWidget {
  final Color color;
  final double size;
  final Function onPressed;
  const RoundedButtonSearch({
    Key? key,
    required this.color,
    required this.size,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<RoundedButtonSearch> createState() => _RoundedButtonSearchState();
}

class _RoundedButtonSearchState extends State<RoundedButtonSearch> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search, color: widget.color, size: widget.size),
      onPressed: () {
        widget.onPressed();
      },
    );
  }
}

// # ROUNDED BUTTON MAIN
class RoundedButtonMain extends StatefulWidget {
  final String text1;
  final String text2;
  final double fontSize1;
  final double fontSize2;
  final double width;
  final double horizontalGap;
  final double verticalGap;
  final double radius;
  final Color color, textColor;
  bool isLoading;
  final Function function;
  RoundedButtonMain({
    Key? key,
    required this.text1,
    required this.text2,
    required this.fontSize1,
    required this.fontSize2,
    required this.width,
    required this.horizontalGap,
    required this.verticalGap,
    required this.radius,
    this.color = primaryColor,
    this.textColor = Colors.white,
    required this.isLoading,
    required this.function,
  }) : super(key: key);

  @override
  State<RoundedButtonMain> createState() => _RoundedButtonMainState();
}

class _RoundedButtonMainState extends State<RoundedButtonMain> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: widget.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: newElevatedButton(context),
      ),
    );
  }

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              horizontal: widget.horizontalGap, vertical: widget.verticalGap)),
        ),
        child: widget.isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.text2,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.fontSize2),
                  ),
                ],
              )
            : Text(
                widget.text1,
                style: TextStyle(
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: widget.fontSize1,
                ),
              ),
        onPressed: () async {
          if (widget.isLoading) return;

          setState(() => widget.isLoading = true);
          await widget.function();
          // await Future.delayed(const Duration(seconds: 2));
          setState(() => widget.isLoading = false);
        });
  }
}
