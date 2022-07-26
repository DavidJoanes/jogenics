// ignore_for_file: prefer_const_constructors, unnecessary_this, prefer_const_literals_to_create_immutables, avoid_print

import 'package:JoGenics/components/app_bar.dart';
import 'package:JoGenics/constants.dart';
import "package:flutter/material.dart";
import 'dart:io';
import 'dart:ui' as ui;
import 'package:dart_vlc/dart_vlc.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  Player player = Player(
    id: 0,
    videoDimensions: VideoDimensions(640, 0),
    registerTexture: !Platform.isWindows,
  );
  MediaType mediaType = MediaType.file;
  CurrentState current = CurrentState();
  PositionState position = PositionState();
  PlaybackState playback = PlaybackState();
  GeneralState general = GeneralState();
  VideoDimensions videoDimensions = VideoDimensions(0, 0);
  List<Media> medias = <Media>[];
  List<Device> devices = <Device>[];
  // TextEditingController controller = TextEditingController();
  TextEditingController metasController = TextEditingController();
  double bufferingProgress = 0.0;
  Media? metasMedia;
  late String mediaFile = '';
  late String mediaPath = "videos/";
  late String title = '';

  final tutorialQuestionsForAdmin = {
    "How to sign up and sign in",
    "How to change password",
    "How to edit profile",
    "How to add employees",
    "How to monitor and checked in/out guests",
    "How to add & modify products in inventory",
    "How to monitor sales and invoices",
    "How to analyse daily, monthly and yearly income",
    "How to verify amount of products sold in a month",
    "How to subscribe to a package",
    "How to check for software update",
  };
  final tutorialQuestionsForEmployee = {
    "How to sign in",
    "How to check in a guest",
    "How to check out a guest",
    "How to record sales & print receipts",
  };
  DropdownMenuItem<String> buildQuestions(String questions) => DropdownMenuItem(
      value: questions,
      child: Text(
        questions,
      ));

  @override
  void initState() {
    super.initState();
    if (this.mounted) {
      this.player.currentStream.listen((current) {
        this.setState(() => this.current = current);
      });
      this.player.positionStream.listen((position) {
        this.setState(() => this.position = position);
      });
      this.player.playbackStream.listen((playback) {
        this.setState(() => this.playback = playback);
      });
      this.player.generalStream.listen((general) {
        this.setState(() => this.general = general);
      });
      this.player.videoDimensionsStream.listen((videoDimensions) {
        this.setState(() => this.videoDimensions = videoDimensions);
      });
      this.player.bufferingProgressStream.listen(
        (bufferingProgress) {
          this.setState(() => this.bufferingProgress = bufferingProgress);
        },
      );
      this.player.errorStream.listen((event) {
        print('vlc error.');
      });
      this.devices = Devices.all;
      Equalizer equalizer = Equalizer.createMode(EqualizerMode.live);
      equalizer.setPreAmp(10.0);
      equalizer.setBandAmp(31.25, 10.0);
      this.player.setEqualizer(equalizer);
    }
  }

  @override
  void dispose() {
    this.player.pause();
    this.player.dispose();
    this.medias.clear();
    tutorialQuestion = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isTablet;
    bool isPhone;
    final double devicePixelRatio = ui.window.devicePixelRatio;
    final double width = ui.window.physicalSize.width;
    final double height = ui.window.physicalSize.height;
    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isTablet = true;
      isPhone = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isTablet = true;
      isPhone = false;
    } else {
      isTablet = false;
      isPhone = true;
    }
    var textStyle = TextStyle(
        fontFamily: 'Biko', fontSize: size.width * 0.02, color: navyBlueColor);
    return Scaffold(
      appBar: buildAppBar(context, 'Tutorial', blackColor, false),
      backgroundColor: customBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: textStyle,
            ),
            SizedBox(height: size.height * 0.03),
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(4.0),
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Platform.isWindows
                        ? NativeVideo(
                            player: player,
                            width: isPhone ? 320 : size.width * 0.6,
                            height: isPhone ? 180 : size.height * 0.65,
                            volumeThumbColor: primaryColor,
                            volumeActiveColor: primaryColor2,
                            showControls: !isPhone,
                          )
                        : Video(
                            player: player,
                            width: isPhone ? 320 : 640,
                            height: isPhone ? 180 : 360,
                            volumeThumbColor: primaryColor2,
                            volumeActiveColor: primaryColor,
                            showControls: !isPhone,
                          ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.02),
                        child: Card(
                          elevation: 2.0,
                          margin: EdgeInsets.all(size.height * 0.01),
                          child: Container(
                            margin: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Playlist',
                                ),
                                Divider(
                                  height: 8.0,
                                  color: Colors.transparent,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: size.width * 0.9,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            size.width * 0.005),
                                        border: Border.all(
                                            color: transparentColor, width: 2),
                                        color: whiteColor,
                                      ),
                                      child: ListTile(
                                        leading: Icon(Icons.question_mark,
                                            color: primaryColor),
                                        title: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            hint: Text('Select a tutorial'),
                                            isExpanded: true,
                                            value: tutorialQuestion,
                                            iconSize: 30,
                                            items: isAdmin!
                                                ? tutorialQuestionsForAdmin
                                                    .map(buildQuestions)
                                                    .toList()
                                                : tutorialQuestionsForEmployee
                                                    .map(buildQuestions)
                                                    .toList(),
                                            onChanged: (value) async =>
                                                setState(() {
                                              mediaPath = "";
                                              tutorialQuestion = value;
                                              title = value!;
                                              tutorialQuestion ==
                                                      "How to sign up and sign in"
                                                  ? mediaFile = "signup.mp4"
                                                  : tutorialQuestion ==
                                                          "How to change password"
                                                      ? mediaFile =
                                                          "change password.mp4"
                                                      : tutorialQuestion ==
                                                              "How to edit profile"
                                                          ? mediaFile =
                                                              "edit profile.mp4"
                                                          : tutorialQuestion ==
                                                                  "How to add employees"
                                                              ? mediaFile =
                                                                  "add employees.mp4"
                                                              : tutorialQuestion ==
                                                                      "How to monitor and checked in/out guests"
                                                                  ? mediaFile =
                                                                      "monitor records.mp4"
                                                                  : tutorialQuestion ==
                                                                          "How to add & modify products in inventory"
                                                                      ? mediaFile =
                                                                          "add products.mp4"
                                                                      : tutorialQuestion ==
                                                                              "How to monitor sales and invoices"
                                                                          ? mediaFile =
                                                                              "invoices.mp4"
                                                                          : tutorialQuestion == "How to analyse daily, monthly and yearly income"
                                                                              ? mediaFile = "analysis income.mp4"
                                                                              : tutorialQuestion == "How to verify amount of products sold in a month"
                                                                                  ? mediaFile = "analysis inventory.mp4"
                                                                                  : tutorialQuestion == "How to subscribe to a package"
                                                                                      ? mediaFile = "subscription.mp4"
                                                                                      : tutorialQuestion == "How to check for software update"
                                                                                          ? mediaFile = "update.mp4"
                                                                                          : tutorialQuestion == "How to sign in"
                                                                                              ? mediaFile = "signin.mp4"
                                                                                              : tutorialQuestion == "How to check in a guest"
                                                                                                  ? mediaFile = "checkin.mp4"
                                                                                                  : tutorialQuestion == "How to check out a guest"
                                                                                                      ? mediaFile = "checkout.mp4"
                                                                                                      : mediaFile = "sales.mp4";
                                              mediaPath = "videos/$mediaFile";
                                              if (this.mediaType ==
                                                  MediaType.file) {
                                                this.medias.isNotEmpty
                                                    ? this.medias.removeAt(0)
                                                    : null;
                                                this.medias.add(
                                                      Media.file(
                                                        File(
                                                          mediaPath,
                                                        ),
                                                      ),
                                                    );
                                                setState(() {
                                                  this.player.open(
                                                        Playlist(
                                                          medias: this.medias,
                                                          playlistMode:
                                                              PlaylistMode
                                                                  .single,
                                                        ),
                                                      );
                                                });
                                              } else if (this.mediaType ==
                                                  MediaType.network) {
                                                this.medias.add(
                                                      Media.network(
                                                        mediaPath,
                                                      ),
                                                    );
                                              }
                                              this.setState(() {});
                                            }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
