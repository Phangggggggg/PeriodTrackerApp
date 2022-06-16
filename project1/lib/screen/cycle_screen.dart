import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:project1/colors.dart';
import '../main.dart';
import './models/period_info.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'home_screen/home_screen_ctl.dart';

class CycleScreen extends StatefulWidget {
  int numCycleDays;
  List<PeriodInfo> data;
  CycleScreen({this.data, this.numCycleDays});
  @override
  State<CycleScreen> createState() => _CycleScreenState();
}

class _CycleScreenState extends State<CycleScreen> {
  DateTime currentDate = DateTime.now();
  String predictionLabel = "";
  String dateLabel = DateFormat.yMMMd().format(DateTime.now());

  String stringModifier(double value) {
    final roundedValue = value.ceil().toInt().toString();
    return '$roundedValue';
  }

  PeriodInfo getDay(List<PeriodInfo> data, DateTime date) {
    PeriodInfo pfResult =
        data.firstWhere((pf) => date.difference(pf.date).inDays == 0);
    return pfResult;
  }

  PeriodInfo getDate(List<PeriodInfo> data, int numDay, int numCycle) {
    return data
        .firstWhere((pf) => pf.numDay == numDay && pf.cycleNum == numCycle);
  }

  int getCurrentCycleNum() {
    return getDay(widget.data, currentDate).cycleNum;
  }

  String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  Widget makeBox() {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Icon(
                    Icons.water_drop_rounded,
                    color: Colors.redAccent,
                    size: 36,
                  ),
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Next Period on ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            formatDate(ctl.nextPf.value.date),
                            style: TextStyle(fontSize: 18, color: secBlue),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  var ctl = Get.put(HomeScreenCtl());

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        makeBox(),
        SizedBox(
          height: 40,
        ),
        Container(
          child: SleekCircularSlider(
            min: 1,
            max: widget.numCycleDays.toDouble(),
            initialValue: getDay(widget.data, currentDate).numDay.toDouble(),
            appearance: CircularSliderAppearance(
              size: 200,
              startAngle: 270,
              angleRange: 360,
              infoProperties: InfoProperties(
                  modifier: stringModifier,
                  topLabelText: 'Day',
                  topLabelStyle: TextStyle(color: secBlue, fontSize: 20),
                  mainLabelStyle: TextStyle(fontSize: 48, color: secBlue),
                  bottomLabelText: predictionLabel,
                  bottomLabelStyle: TextStyle(
                    color: predictionLabel == 'Potentially fertile'
                        ? Color.fromARGB(255, 37, 126, 40)
                        : Colors.redAccent,
                    fontSize: 14,
                  )),
              customWidths: CustomSliderWidths(
                  progressBarWidth: 0, trackWidth: 1, handlerSize: 6),
              customColors: CustomSliderColors(
                  dotColor: Colors.redAccent,
                  shadowColor: Colors.grey.shade500,
                  progressBarColor: secBlue,
                  // progressBarColors:[red1,red2] ,
                  trackColor: Colors.grey),
            ),
            onChange: (double value) {
              int roundVal = value.ceil().toInt();
              double numDay =
                  getDay(widget.data, currentDate).numDay.toDouble();
              PeriodInfo changeDay =
                  getDate(widget.data, roundVal, ctl.curCycleNum.value);
              setState(() {
                dateLabel = formatDate(changeDay.date);
              });
              if (changeDay.isFertile) {
                setState(() {
                  predictionLabel = 'Potentially fertile';
                });
              } else if (roundVal >= 1 && roundVal <= 5) {
                setState(() {
                  predictionLabel = 'Might have a period';
                });
              } else {
                setState(() {
                  predictionLabel = '';
                });
              }
            },
            onChangeStart: (double startValue) {
              print(startValue);
            },
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: 18),
            // backgroundColor: kBlueDark
          ),
          onPressed: () {
            box.remove('symptoms');
            Navigator.popAndPushNamed(context, '/lastperiod');
          },
          child: Text(
            'Reset',
            style: TextStyle(color: Colors.redAccent),
          ),
        )
      ],
    );
  }
}
