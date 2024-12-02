import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smart_plant_communicator/shared/theme.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool isWebFullView = MediaQuery.of(context).size.width > 600;
    bool isCardView = true;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [greyColor, whiteColor])),
                      child: Center(
                        child: Icon(
                          Icons.settings_outlined,
                          weight: 1,
                          color: darkGreyColor.withOpacity(0.6),
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
                                color: const Color.fromRGBO(238, 79, 34, 0.65)),
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
                                    fontWeight: FontWeight.bold, fontSize: 20),
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
              Container(
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
                      'JasmineKu',
                      style: TextStyle(
                          fontSize: 17, color: darkGreyColor.withOpacity(0.6)),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: darkGreyColor.withOpacity(0.6),
                    )
                  ],
                ),
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.symmetric(vertical: 11),
                margin: EdgeInsets.symmetric(horizontal: 41),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [blueColor, greenColor]),
                    borderRadius: BorderRadius.circular(22)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: whiteColor),
                      child: Center(
                          child: GradientText('!',
                              style: TextStyle(fontSize: 17),
                              colors: [blueColor, greenColor])),
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    Text(
                      'Perlu Disiram',
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
        ),
      ),
    );
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
            padding: EdgeInsets.all(16),
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
            type == 0 ? 'Kelembaban Tanah' : "Intensitas cahaya",
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
