// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_catch_clause, non_constant_identifier_names
import 'dart:convert';
import 'dart:io';
import 'package:JoGenics/components/dialog.dart' as dialog;
import 'package:JoGenics/components/title_case.dart';
import 'package:JoGenics/db.dart' as db;
import 'package:JoGenics/components/countries.dart' as fetchcountries;
import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/components/custom_page_route.dart';
import 'package:JoGenics/components/rounded_button.dart';
import 'package:JoGenics/components/rounded_input_field.dart';
import 'package:JoGenics/constants.dart';
import 'package:JoGenics/main.dart';
import 'package:JoGenics/screens/Home/AdminHome/body.dart';
import 'package:JoGenics/screens/Home/AdminHome/profile_picture.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late int currentIndex = 0;

  late String _image = '', phone, address, province, country;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final standardRoomRateController = TextEditingController();
  final executiveRoomRateController = TextEditingController();
  final presidentialRoomRateController = TextEditingController();

  final nationalities = {''};
  late var states = {''};
  late String countryCode = '';
  late String countryCurrency = '';

  final style = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  getCountries() async {
    for (var data in fetchcountries.countries) {
      nationalities.add(data['name'] as String);
    }
  }

  DropdownMenuItem<String> buildNationalities(String Nationality) =>
      DropdownMenuItem(
          value: Nationality,
          child: Text(
            Nationality,
          ));

  getProvinces(country) {
    List liveData = [];
    liveData.clear();
    states = {''};
    stateOfOrigin = null;
    for (var data in fetchcountries.provinces) {
      if (country == data['countryName']) {
        liveData.add(data['regions']);
        for (var regions in liveData[0]) {
          states.add(regions['name']);
        }
      }
    }
    return liveData;
  }

  DropdownMenuItem<String> buildStates(String state) => DropdownMenuItem(
      value: state,
      child: Text(
        state,
      ));

  getCountryCodes(country) {
    countryCode = '';
    for (var data in fetchcountries.countries_and_phone_codes) {
      if (country == data['name']) {
        countryCode = data['dial_code'].toString();
      }
    }
  }

  getCountryCurrency(country) {
    countryCurrency = '';
    for (var data in fetchcountries.countries_and_currencies) {
      if (country == data['Entity']) {
        countryCurrency = data['AlphabeticCode'].toString();
      }
    }
  }

  @override
  void initState() {
    nationality = null;
    stateOfOrigin = null;
    getCountries();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    standardRoomRateController.dispose();
    executiveRoomRateController.dispose();
    presidentialRoomRateController.dispose();
    super.dispose();
  }

  _bottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Center(
              child: Container(
                height: size.height * 0.2,
                width: size.width * 0.8,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: size.width * 0.15,
                        height: size.height * 0.12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Icon(Icons.camera_alt_rounded,
                                  color: primaryColor, size: 40),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Camera',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        // final image = await ImagePicker().getImage(
                        //     source: ImageSource.camera, imageQuality: 50);

                        // if (image == null) return;
                      },
                    ),
                    SizedBox(width: size.width * 0.05),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: size.width * 0.15,
                          height: size.height * 0.12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Icon(Icons.photo,
                                    color: primaryColor, size: 40),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Gallery',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          FilePickerResult? image =
                              await FilePicker.platform.pickFiles(
                            dialogTitle: 'Select an image',
                            type: FileType.custom,
                            allowedExtensions: ['jpg', 'png'],
                          );
                          if (image == null && image!.files.isEmpty) return;
                          PlatformFile imageResult = image.files.single;
                          final imagePath = imageResult.path;
                          print(imagePath);
                          File imageFile = File(imagePath.toString());
                          // Uint8List imageBytes1 = await imageFile.readAsBytes();
                          // print(imageBytes1);

                          List<int> imageBytes = await imageFile.readAsBytes();
                          String base64Image = base64Encode(imageBytes);
                          _image = base64Image;
                          setState(() => _image = base64Image);
                        }),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MainWindowNavigation(
      leftChild: buildLeftChild(
          fullname: db.CurrentLoggedInUserLastname != ''
              ? db.CurrentLoggedInUserLastname.toTitleCase()
              : db.CurrentLoggedInUserLastname,
          emailaddress: db.CurrentLoggedInUserEmail,
          selected0: true,
          selected1: false,
          selected2: false,
          selected3: false,
          selected4: false,
          selected5: false,
          selected6: false,
          selected7: false,
          selected8: false,
          selectedPage: (value) async {
            setState(() {
              currentIndex = value;
            });
          }),
      rightChild: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/home.png'), fit: BoxFit.fill)),
        child: Scaffold(
            backgroundColor: whiteColor3,
            appBar: buildAppBar(context, "Edit Profile", blackColor, false),
            body: ListView(
              controller: ScrollController(),
              physics: const BouncingScrollPhysics(),
              children: [
                ProfilePicture(
                  radius: size.width * 0.07,
                  radius2: size.width * 0.018,
                  radius3: size.width * 0.016,
                  isEdit: true,
                  pressChangePicture: () async {
                    _bottomSheet(context);
                  },
                  pressEdit: () async {
                    await Navigator.push(
                      context,
                      CustomPageRoute(widget: EditProfile()),
                    );
                    setState(() {});
                  },
                  onClicked: () {
                    _bottomSheet(context);
                  },
                  imagePath: _image != ''
                      ? _image
                      : db.CurrentLoggedInUserProfilePicture,
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.01),
                        Divider(color: Colors.grey),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? SizedBox(height: size.height * 0.005)
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? RoundedInputField3c(
                                controller: addressController,
                                mainText: db.HotelAddress.toTitleCase(),
                                hintText: "Hotel's address",
                                icon: Icons.location_on_rounded,
                                onChanged: (value) {
                                  value = addressController.text;
                                },
                              )
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? SizedBox(height: size.height * 0.025)
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: transparentColor, width: 2),
                                  color: whiteColor,
                                ),
                                child: ListTile(
                                  leading: Icon(Icons.edit_location_alt_rounded,
                                      color: primaryColor),
                                  title: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text('Country'),
                                      isExpanded: true,
                                      value: nationality,
                                      iconSize: 30,
                                      items: nationalities
                                          .map(buildNationalities)
                                          .toList(),
                                      onChanged: (value) async => setState(() {
                                        nationality = value;
                                        getProvinces(nationality ?? '');
                                        getCountryCodes(nationality ?? '');
                                        getCountryCurrency(
                                            nationality!.toUpperCase());
                                      }),
                                    ),
                                  ),
                                ),
                              )
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? SizedBox(height: size.height * 0.03)
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: transparentColor, width: 2),
                                  color: whiteColor,
                                ),
                                child: ListTile(
                                  leading: Icon(Icons.edit_location_rounded,
                                      color: primaryColor),
                                  title: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint: Text('Province'),
                                      isExpanded: true,
                                      value: stateOfOrigin,
                                      iconSize: 30,
                                      items: states.map(buildStates).toList(),
                                      onChanged: (value) async => setState(() {
                                        stateOfOrigin = value;
                                      }),
                                    ),
                                  ),
                                ),
                              )
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? SizedBox(height: size.height * 0.02)
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? RoundedInputField3b(
                                width: size.width * 0.4,
                                radius: 20,
                                controller: phoneController,
                                hideText: false,
                                mainText: db.HotelPhone == ''
                                    ? countryCode
                                    : db.HotelPhone,
                                hintText: "Hotel's phone number",
                                warningText: 'Enter a valid phone number!',
                                icon: Icons.numbers,
                                onChanged: (value) {
                                  value = phoneController.text.trim();
                                },
                              )
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? SizedBox(height: size.height * 0.005)
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? RoundedInputField3b2(
                                width: size.width * 0.4,
                                radius: 20,
                                controller: standardRoomRateController,
                                mainText: db.StandardRoomRate.toString(),
                                hintText: 'Standard rooms rate',
                                warningText: 'Enter a valid price (integer)!',
                                icon: Icons.money,
                                onChanged: (value) {
                                  value = standardRoomRateController.text;
                                },
                              )
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? SizedBox(height: size.height * 0.005)
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? RoundedInputField3b2(
                                width: size.width * 0.4,
                                radius: 20,
                                controller: executiveRoomRateController,
                                mainText: db.ExecutiveRoomRate.toString(),
                                hintText: 'Executive rooms rate',
                                warningText: 'Enter a valid price (integer)!',
                                icon: Icons.money,
                                onChanged: (value) {
                                  value = executiveRoomRateController.text;
                                },
                              )
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? SizedBox(height: size.height * 0.005)
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? RoundedInputField3b2(
                                width: size.width * 0.4,
                                radius: 20,
                                controller: presidentialRoomRateController,
                                mainText: db.PresidentialRoomRate.toString(),
                                hintText: 'Presidential rooms rate',
                                warningText: 'Enter a valid price (integer)!',
                                icon: Icons.money,
                                onChanged: (value) {
                                  value = presidentialRoomRateController.text;
                                },
                              )
                            : Text(''),
                        db.CurrentLoggedInUserDesignation == 'owner'
                            ? SizedBox(height: size.height * 0.05)
                            : Text(''),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              color: customBackgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundedButtonGeneral(
                        isLoading: false,
                        text1: "Save",
                        text2: 'Updating..',
                        color: primaryColor2,
                        update: () async {
                          // final form = _formKey.currentState!;
                          if (db.CurrentLoggedInUserDesignation == 'owner') {
                            try {
                              if (await db.uploadAdminProfilePicture(_image != ''
                                          ? _image
                                          : db
                                              .CurrentLoggedInUserProfilePicture) ==
                                      true &&
                                  await db.updateHotelData(
                                          addressController.text != ''
                                              ? addressController.text.trim()
                                              : db.HotelAddress,
                                          nationality != null &&
                                                  nationality != ''
                                              ? nationality
                                              : db.HotelCountry,
                                          countryCurrency != ''
                                              ? countryCurrency
                                              : db.HotelCurrency,
                                          stateOfOrigin != null && stateOfOrigin != ''
                                              ? stateOfOrigin
                                              : db.HotelProvince,
                                          phoneController.text != ''
                                              ? phoneController.text.trim()
                                              : db.HotelPhone,
                                          standardRoomRateController.text != ''
                                              ? standardRoomRateController.text
                                                  .trim()
                                              : db.StandardRoomRate.toString(),
                                          executiveRoomRateController.text != ''
                                              ? executiveRoomRateController.text
                                                  .trim()
                                              : db.ExecutiveRoomRate.toString(),
                                          presidentialRoomRateController.text !=
                                                  ''
                                              ? presidentialRoomRateController
                                                  .text
                                                  .trim()
                                              : db.PresidentialRoomRate
                                                  .toString()) ==
                                      true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: primaryColor,
                                        content:
                                            Text("Operation succeeded..")));
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  CustomPageRoute(widget: AdminHome()),
                                );
                              } else {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return dialog.ReturnDialog1(
                                        title: Text('Error'),
                                        message: 'Operation failed!',
                                        color: errorColor,
                                        buttonText: 'Retry',
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    });
                              }
                            } on Exception catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: errorColor,
                                      content:
                                          Text("No internet connection!")));
                              return;
                            }
                          } else {
                            try {
                              if (_image != '') {
                                if (await db
                                        .uploadAdminProfilePicture(_image) ==
                                    true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: primaryColor,
                                          content:
                                              Text("Operation succeeded..")));
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    CustomPageRoute(widget: AdminHome()),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: errorColor,
                                        content: Text("No image selected!")));
                                return;
                              }
                            } on Exception catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: errorColor,
                                      content:
                                          Text("No internet connection!")));
                              return;
                            }
                          }
                        }),
                  ],
                ),
              ),
            )),
      ),
      isLogout: false, destroyApp: true
    );
    // );
  }

  // Future<dynamic> _saveScreenShot(ui.Image img) async {
  //   var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  //   var buffer = byteData!.buffer.asUint8List();
  //   final result = await ImageGallerySaver.saveImage(buffer);

  //   return result;
  // }
}
