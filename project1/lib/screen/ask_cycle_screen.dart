import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:project1/colors.dart';
import 'package:project1/get_storage.dart';
import 'home_screen/home_screen.dart';
import './models/period_info.dart';
import 'home_screen/home_screen_ctl.dart';
import '/get_view.dart';

class AskCycleScreen extends StatefulWidget {
  DateTime lastPeriodDay;

  @override
  State<AskCycleScreen> createState() => _AskCycleScreenState();
  AskCycleScreen({this.lastPeriodDay});
}

class _AskCycleScreenState extends State<AskCycleScreen> {
  int numCycleDays = 25;
  var ctl = Get.put(HomeScreenCtl());
  final box = GetStorage();
  List storageList = [];
  void getFirstDayFourCycle(DateTime lastPeriodDay, int numCycles) {
    List<PeriodInfo> cycles = [];
    for (var i = 0; i < 7; i++) {
      List<PeriodInfo> cycle = getACycle(lastPeriodDay, numCycles, i);
      cycles.addAll(cycle);
      lastPeriodDay = lastPeriodDay.add(Duration(days: numCycleDays));
    }
  }

  PeriodInfo getDay(List<PeriodInfo> data, DateTime date) {
    PeriodInfo pfResult =
        data.firstWhere((pf) => date.difference(pf.date).inDays == 0);
    return pfResult;
  }

  DateTime findFirstPeriod(DateTime date, List<PeriodInfo> data, int curCycle) {
    return data
        .firstWhere((pf) => pf.cycleNum == curCycle && pf.isFirstDay)
        .date;
  }

  DateTime findLastPeriod(DateTime date, List<PeriodInfo> data, int curCycle) {
    return data
        .firstWhere((pf) => pf.cycleNum == curCycle && pf.isLastDay)
        .date;
  }

  List<PeriodInfo> getACycle(
      DateTime lastPeriodDay, int numCycles, int cycleNum) {
    List<PeriodInfo> data = [];
    for (var i = 0; i < numCycles; i++) {
      final storageMap = {};
      bool hasPeriod = false;
      bool isFertile = false;
      bool isFirstDay = false;
      bool isLastDay = false;
      DateTime nextDay = lastPeriodDay.add(Duration(days: 1));
      if (i == 0) {
        // first day of your period
        hasPeriod = true;
        isFertile = false;
        isFirstDay = true;
        isLastDay = false;
      } else if (i > 0 && i < 5) {
        //you have a period
        hasPeriod = true;
        isFertile = false;
        isFirstDay = false;
        isLastDay = false;
      } else if (i >= 13 && i < 16) {
        hasPeriod = false;
        isFertile = true;
        isFirstDay = false;
        isLastDay = false;
      } else if (i == numCycles) {
        hasPeriod = false;
        isFertile = false;
        isFirstDay = false;
        isLastDay = true;
      } else {
        hasPeriod = false;
        isFertile = false;
        isFirstDay = false;
        isLastDay = false;
      }
      storageMap['date'] = lastPeriodDay.toString();
      storageMap['cycleNum'] = cycleNum;
      storageMap['numCycles'] = numCycles;
      storageMap['hasPeriod'] = hasPeriod;
      storageMap['isFertile'] = isFertile;
      storageMap['isFirstDay'] = isFirstDay;
      storageMap['isLastDay'] = isLastDay;
      storageMap['numDay'] = i + 1;
      ctl.storageList.add(storageMap);
      data.add(PeriodInfo(
          date: lastPeriodDay,
          cycleNum: cycleNum,
          numDayInCycle: numCycles,
          hasPeriod: hasPeriod,
          isFertile: isFertile,
          isFirstDay: isFirstDay,
          isLastDay: isLastDay,
          numDay: i + 1));
      lastPeriodDay = nextDay;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 70.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: secBlue,
                    size: 40,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    'How long your average cycle last?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'The average cycle is between 28 - 32 days.',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => setState(() {
                            final newValue = numCycleDays - 1;
                            numCycleDays = newValue.clamp(25, 38);
                          }),
                        ),
                      ),
                      NumberPicker(
                        value: numCycleDays,
                        minValue: 25,
                        maxValue: 38,
                        itemHeight: 80,
                        textStyle: TextStyle(
                          color: secBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        selectedTextStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        axis: Axis.vertical,
                        onChanged: (value) =>
                            setState(() => numCycleDays = value),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                              color: Colors.black26, style: BorderStyle.solid),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.add),
                          color: secBlue,
                          onPressed: () => setState(() {
                            final newValue = numCycleDays + 1;
                            numCycleDays = newValue.clamp(25, 38);
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40.0),
                  child: RichText(
                    text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'Your menstrual cycle lasts '),
                          TextSpan(
                              text: '$numCycleDays',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent)),
                          TextSpan(text: ' days.'),
                        ],
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        )),
                  ),

                  //  Text('Your menstrual cycle lasts: $numCycleDays days.'),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 42.0, 0, 0.0),
                  width: 300,
                  child: TextButton(
                    child: Text('Let\'s get started',
                        style: TextStyle(fontSize: 12)),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(16)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.redAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                              side: BorderSide(color: Colors.redAccent))),
                    ),
                    onPressed: () {
                      ctl.storageList.value = [];
                      ctl.data.value = [];
                      getFirstDayFourCycle(widget.lastPeriodDay, numCycleDays);
                      box.write('data', ctl.storageList.value);
                      box.write(
                          'lastPeriodDay', widget.lastPeriodDay.toString());
                      box.write('numCycleDays', numCycleDays);
                      box.write('isShow', true);
                      print(box.read('isShow'));
                      Navigator.popAndPushNamed(context, '/home'); 
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
