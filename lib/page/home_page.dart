import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smart_plant_communicator/data/dummy.dart';
import 'package:smart_plant_communicator/shared/theme.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool isOn = true;
  bool isAnimating = false;
  String inputTextToken = '';
  String inputTextName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeNotifications();
  }

  bool notificationShown = false;
  void _refreshData() {
    setState(() {
      // trashBin = getTrashBinData();
      notificationShown = false;
      checkTrashStatusAndNotify(infoBloom);
    });
  }

  void _initializeNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _showNotification(String title, String message) async {
    var androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      notificationDetails,
    );
  }

  void checkTrashStatusAndNotify(Map<String, dynamic> infoBloom) {
    if (infoBloom['status'] == 0 && !notificationShown) {
      _showNotification(
        infoBloom['name'],
        'Perlu Disiram Air',
      );
      notificationShown = true;
    } else if (infoBloom['status'] == 1 && !notificationShown) {
      _showNotification(
        infoBloom['name'],
        'Perlu Diberi Cahaya',
      );
      notificationShown = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isWebFullView = MediaQuery.of(context).size.width > 600;
    bool isCardView = true;
    return Scaffold(
        endDrawer: Drawer(
          child: Container(
            padding: EdgeInsets.only(top: 56),
            color: whiteColor,
            child: Column(
              children: [
                GradientText('BloomBuddy',
                    style: TextStyle(
                        fontWeight: semiBold,
                        fontFamily: 'Poppins',
                        fontSize: 17),
                    colors: [blueColor, purpleColor]),
                SizedBox(height: 144),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 46),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x263B4056),
                        offset: Offset(0, 20),
                        blurRadius: 40,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notifikasi',
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: "poppins",
                            color: darkGreyColor.withOpacity(0.6)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            if (!isAnimating) {
                              setState(() {
                                isAnimating = true;
                              });

                              Future.delayed(Duration(milliseconds: 300), () {
                                setState(() {
                                  isOn = !isOn;
                                  isAnimating = false;
                                });
                              });
                            }
                          },
                          child: Container(
                            height: 31,
                            width: 51,
                            margin: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFC9CED7), Color(0xFFE1E8F1)],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.8),
                                  offset: Offset(0, -0.5),
                                  blurRadius: 5,
                                  spreadRadius: -3,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  left: isOn ? 20.0 : 0.0,
                                  child: AnimatedContainer(
                                    duration: Duration(
                                        milliseconds:
                                            300), // Smooth animation duration
                                    width: 31,
                                    height: 31,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: isOn
                                            ? [
                                                blueColor,
                                                greenColor
                                              ] // Inner circle gradient when isOn is true
                                            : [whiteColor, greyColor],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _refreshData();
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 46),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 46),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x263B4056),
                          offset: Offset(0, 20),
                          blurRadius: 40,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text('Cek Notif'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Builder(builder: (BuildContext context) {
          return Container(
            color: whiteColor,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 56),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        width: 36,
                      ),
                      GradientText('BloomBuddy',
                          style: TextStyle(
                              fontWeight: semiBold,
                              fontFamily: 'Poppins',
                              fontSize: 17),
                          colors: [blueColor, purpleColor]),
                      GestureDetector(
                        onTap: () {
                          Scaffold.of(context)
                              .openEndDrawer(); // Open the right-side drawer
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          margin: EdgeInsets.only(right: 16),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                greyColor,
                                whiteColor,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.settings_outlined,
                              weight: 1,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 33),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3,
                    child: SfRadialGauge(
                      animationDuration: 3500,
                      enableLoadingAnimation: true,
                      axes: <RadialAxis>[
                        RadialAxis(
                            minimum: -50,
                            maximum: 150,
                            interval: isCardView ? 20 : 20,
                            minorTicksPerInterval: 9,
                            showAxisLine: false,
                            radiusFactor: isWebFullView ? 0.8 : 0.9,
                            labelOffset: 8,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                  startValue: -50,
                                  endValue: 0,
                                  startWidth: 0.265,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  endWidth: 0.265,
                                  color:
                                      const Color.fromRGBO(34, 144, 199, 0.75)),
                              GaugeRange(
                                  startValue: 0,
                                  endValue: 10,
                                  startWidth: 0.265,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  endWidth: 0.265,
                                  color: blueColor),
                              GaugeRange(
                                  startValue: 10,
                                  endValue: 30,
                                  startWidth: 0.265,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  endWidth: 0.265,
                                  color: greenColor),
                              GaugeRange(
                                  startValue: 30,
                                  endValue: 40,
                                  startWidth: 0.265,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  endWidth: 0.265,
                                  color:
                                      const Color.fromRGBO(238, 193, 34, 0.75)),
                              GaugeRange(
                                  startValue: 40,
                                  endValue: 150,
                                  startWidth: 0.265,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  endWidth: 0.265,
                                  color:
                                      const Color.fromRGBO(238, 79, 34, 0.65)),
                            ],
                            annotations: const <GaugeAnnotation>[
                              GaugeAnnotation(
                                  angle: 90,
                                  positionFactor: 0.35,
                                  widget: Text('Temp.°C',
                                      style: TextStyle(
                                          color: Color(0xFFF8B195),
                                          fontSize: 16))),
                              GaugeAnnotation(
                                angle: 90,
                                positionFactor: 0.8,
                                widget: Text(
                                  '  22.5  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              )
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(
                                value: 22.5,
                                needleStartWidth: isCardView ? 0 : 1,
                                needleEndWidth: isCardView ? 5 : 8,
                                animationType: AnimationType.easeOutBack,
                                enableAnimation: true,
                                animationDuration: 1200,
                                knobStyle: KnobStyle(
                                    knobRadius: isCardView ? 0.06 : 0.09,
                                    borderColor: const Color(0xFFF8B195),
                                    color: Colors.white,
                                    borderWidth: isCardView ? 0.035 : 0.05),
                                tailStyle: TailStyle(
                                    color: const Color(0xFFF8B195),
                                    width: isCardView ? 4 : 8,
                                    length: isCardView ? 0.15 : 0.2),
                                needleColor: const Color(0xFFF8B195),
                              )
                            ],
                            axisLabelStyle:
                                GaugeTextStyle(fontSize: isCardView ? 10 : 12),
                            majorTickStyle: const MajorTickStyle(
                                length: 0.25, lengthUnit: GaugeSizeUnit.factor),
                            minorTickStyle: const MinorTickStyle(
                                length: 0.13,
                                lengthUnit: GaugeSizeUnit.factor,
                                thickness: 1))
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (builder) {
                          return new Container(
                            height: 350.0,
                            color: Colors.transparent,
                            child: new Container(
                                padding: EdgeInsets.symmetric(vertical: 18),
                                decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(20.0),
                                        topRight: const Radius.circular(20.0))),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          _showInputDialog(context);
                                        },
                                        child: Container(
                                          height: 31,
                                          width: 51,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 24),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                greyColor,
                                                whiteColor,
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                            child: GradientText('+',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: semiBold),
                                                colors: [
                                                  blueColor,
                                                  greenColor
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 24),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: iotList.length,
                                          itemBuilder: (context, index) {
                                            List<ChoiceItem> sortedList =
                                                List.from(iotList)
                                                  ..sort((a, b) =>
                                                      b.isChoice ? 1 : 0);
                                            final item = sortedList[index];
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8),
                                              child: CardIoT(item.name,
                                                  item.isChoice, index),
                                            );
                                          }),
                                    )
                                  ],
                                )),
                          );
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 16, left: 83, right: 83),
                    padding: EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xffDEE2E7), Color(0xffDBE0E7)]),
                        borderRadius: BorderRadius.circular(22)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          iotList
                              .firstWhere((item) => item.isChoice,
                                  orElse: () =>
                                      ChoiceItem(name: '', isChoice: false))
                              .name,
                          style: TextStyle(
                              fontSize: 17,
                              color: darkGreyColor.withOpacity(0.6)),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: darkGreyColor.withOpacity(0.6),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 21),
                  margin: EdgeInsets.symmetric(horizontal: 41),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [blueColor, greenColor]),
                      borderRadius: BorderRadius.circular(22)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: whiteColor),
                        child: Center(
                            child: GradientText('!',
                                style: TextStyle(fontSize: 17),
                                colors: [blueColor, greenColor])),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Text(
                        infoBloom['status'] == 0
                            ? 'Perlu Disiram Air'
                            : infoBloom['status'] == 1
                                ? 'Perlu Diberi Cahaya'
                                : 'Tanamanmu Sehat',
                        style: TextStyle(
                          fontWeight: semiBold,
                          color: darkGreyColor.withOpacity(0.6),
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardInfo(0),
                    CardInfo(1),
                  ],
                )
              ],
            ),
          );
        }));
  }

  Widget CardInfo(type) {
    return Container(
      width: 144,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Color(0x263B4056),
            offset: Offset(0, 20),
            blurRadius: 40,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      blueColor.withOpacity(0.2),
                      greenColor.withOpacity(0.2)
                    ])),
            child: Center(
              child: GradientIcon(
                size: 24,
                icon: type == 0
                    ? Icons.landscape_outlined
                    : Icons.light_mode_outlined,
                colors: [blueColor, greenColor],
              ),
            ),
          ),
          SizedBox(height: 14),
          Text(
            type == 0 ? 'Kelembapan' : "Intensitas cahaya",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: semiBold,
              fontSize: 17,
              color: darkGreyColor.withOpacity(0.6),
              fontFamily: "poppins",
            ),
          ),
          SizedBox(height: 5),
          Text(
            type == 0 ? '5%' : '10°',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: semiBold,
              fontSize: 17,
              color: darkGreyColor.withOpacity(0.6),
              fontFamily: "poppins",
            ),
          ),
        ],
      ),
    );
  }

  Widget CardIoT(name, isChoice, index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < iotList.length; i++) {
            iotList[i].isChoice = false;
          }
          iotList[index].isChoice = true;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 24),
        padding: EdgeInsets.symmetric(vertical: 21, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Color(0x263B4056),
              offset: Offset(0, 20),
              blurRadius: 40,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(color: darkGreyColor.withOpacity(0.6)),
            ),
            Container(
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: isChoice
                      ? [blueColor, greenColor]
                      : [whiteColor, greyColor],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showInputDialog(BuildContext context) async {
    final TextEditingController _tokenController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();

    // Show the input dialog
    Map<String, String>? result = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Daftar Token and Nama'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tokenController,
                decoration:
                    InputDecoration(hintText: 'Masukkan Token BloomBuddy Anda'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration:
                    InputDecoration(hintText: 'Masukkan Nama Tanaman Anda'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_tokenController.text.isEmpty ||
                    _nameController.text.isEmpty) {
                } else {
                  Navigator.of(context).pop({
                    'token': _tokenController.text,
                    'name': _nameController.text,
                  });
                }
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog without any input
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      String newName = result['name'] ?? '';

      setState(() {
        for (var item in iotList) {
          item.isChoice = false;
        }

        iotList.add(ChoiceItem(name: newName, isChoice: true));
      });
    }
  }
}

class GradientIcon extends StatelessWidget {
  final List<Color> colors;
  final IconData icon;
  final num size;

  const GradientIcon({
    Key? key,
    required this.colors,
    required this.size,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: colors, // Using the provided list of colors
          begin: Alignment.topCenter, // Start from the top center
          end: Alignment.bottomCenter, // End at the bottom center
        ).createShader(bounds);
      },
      child: Icon(
        icon, // Using the provided icon
        size: 50, // Adjust icon size as needed
        color: Colors
            .white, // Set a default color for the icon (white is common for ShaderMask)
      ),
    );
  }
}
