import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'home_screen/home_screen_ctl.dart';
import 'package:project1/colors.dart';
import './models/period_info.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Cycle2Screen extends StatefulWidget {
  @override
  State<Cycle2Screen> createState() => _Cycle2ScreenState();
}

class _Cycle2ScreenState extends State<Cycle2Screen> {
  DateTime currentDate = DateTime.now();
  String predictionLabel = "";
  String dateLabel = DateFormat.yMMMd().format(DateTime.now());
  @override
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
    return getDay(ctl.data.value, currentDate).cycleNum;
  }

  String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }


  Widget makeBox(BuildContext context) {
    double widthBox = MediaQuery.of(context).size.width / 1.299;
    double heightBox = 90.0;
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: Text(
                    'Cycle Length',
                    style: TextStyle(
                        color: secBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          Container(
                                                        margin: EdgeInsets.only(left: 30.0),

                            child: Image.asset(
                              'lib/icons/cycle.png',
                              height: 40,
                              width: 40,
                              color: secBlue,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30.0),
                              child: Text('${ctl.numCycleDays.value.toString()} Days', style: TextStyle(color: Colors.redAccent, fontSize: 26, fontWeight: FontWeight.bold ), ),),
                        ]),
                        margin: EdgeInsets.all(5.0),
                        width: widthBox,
                        height: heightBox,
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.3),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(3.0),
                          ),
                        )),
                  ],
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text(
                        'Days left to next period',
                        style: TextStyle(
                            color: secBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Row(children: [
                              Container(
                                                            margin: EdgeInsets.only(left: 30.0),

                                child: Image.asset(
                                  'lib/icons/menstrual-cycle.png',
                                  height: 42,
                                  width: 42,
                                ),
                              ),
                              Container(margin: EdgeInsets.only(left: 30.0),child: Text('${ctl.countDownPeriod.value.toString()} Days',style: TextStyle(color: Colors.redAccent, fontSize: 26, fontWeight: FontWeight.bold ))),
                            ]),
                            margin: EdgeInsets.all(5.0),
                            width: widthBox,
                            height: heightBox,
                            decoration: BoxDecoration(
                              color: lightPink,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(
                                Radius.circular(3.0),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: Text(
                        'Days left to next ovulation',
                        style: TextStyle(
                            color: secBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Row(children: [
                              Container(
                                                                                        margin: EdgeInsets.only(left: 30.0),

                                child: Image.asset(
                                  'lib/icons/ovule.png',
                                  height: 42,
                                  width: 42,
                                ),
                              ),
                              Container(                                                        margin: EdgeInsets.only(left: 30.0),
child: Text('${ctl.countDownOvulation.value.toString()} Days',style: TextStyle(color: Colors.redAccent, fontSize: 26, fontWeight: FontWeight.bold ) )),
                            ]),
                            margin: EdgeInsets.all(5.0),
                            width: widthBox,
                            height: heightBox,
                            decoration: BoxDecoration(
                              color: kBlueDark,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(
                                Radius.circular(3.0),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
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
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        makeBox(context),
        SizedBox(
          height: 40,
        ),
      ],
    );
  
  }
}
