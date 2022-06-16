import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project1/colors.dart';
import 'package:project1/screen/cycle2_screen.dart';
import 'package:project1/screen/models/period_symptom_info.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../get_storage.dart';
import '../../get_view.dart';
import '../widgets/calendar.dart';
import '../history_screen.dart';
import '../models/period_info.dart';
import '../cycle_screen.dart';
import '../widgets/page_view.dart';
import 'home_screen_ctl.dart';
import 'track_screen/p1.dart';
import 'track_screen/p2.dart';
import 'track_screen/p3.dart';
import 'package:intl/intl.dart';

Widget buildTabar(BuildContext context) {
  return DefaultTabController(
      length: 3,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            labelColor: Colors.redAccent,
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(
                child: Column(children: [
                  Icon(Icons.water_drop_rounded),
                  Text('Bleeding')
                ]),
              ),
              Tab(
                child: Column(
                    children: [Icon(Icons.sick_rounded), Text('Symptoms')]),
              ),
              Tab(
                child: Column(
                    children: [Icon(Icons.emoji_emotions), Text('Emotions')]),
              )
            ],
          ),

          // create widgets for each tab bar here
          Expanded(
              child: TabBarView(
            children: [
              // first tab bar view widget
              Container(
                child: buildP1(context),
              ),

              // second tab bar viiew widget
              Container(child: buildP2(context)),
              Container(child: buildP3(context))
            ],
          ))
        ],
      ));
}

Widget buildSlider(BuildContext context) {
  return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.redAccent,
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(
                child: SizedBox(
                  height: 0,
                  width: 0,
                ),
              ),
              Tab(
                child: SizedBox(
                  height: 0,
                  width: 0,
                ),
              )
            ],
          ),
          Expanded(
              child: TabBarView(
            children: [
              // first tab bar view widget
              Container(
                child: Text('2'),
              ),
              Container(child: Text('hello'))
            ],
          ))
        ],
      ));
}

class HomeScreen2 extends MyView<HomeScreenCtl> {
  String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  List<PeriodInfo> data;
  int numCycleDays;
  DateTime lastPeriodDay;

  void resetValue() {
    ctl.trackScreenP1.value = 0;

    ctl.trackScreenP2C4.value = false;
    ctl.trackScreenP2C1.value = false;
    ctl.trackScreenP2C2.value = false;
    ctl.trackScreenP2C3.value = false;
    ctl.trackScreenP3C4.value = false;
    ctl.trackScreenP3C1.value = false;
    ctl.trackScreenP3C2.value = false;
    ctl.trackScreenP3C3.value = false;
  }

  void calAddedFeature() {
    try {
      PeriodInfo pf = ctl.findPfByDate(ctl.data, ctl.selectedDay.value);
      ctl.curCycleNum.value = pf.cycleNum;
      PeriodInfo lastPf =
          ctl.getLastPeriodByCycle(ctl.curCycleNum.value, ctl.data);
      print(pf.cycleNum);
      final int difference = pf.date.difference(lastPf.date).inDays;
      int indexLastpf = ctl.data.indexOf(lastPf);
      int indexCurpf = ctl.data.indexOf(pf);
      ctl.clearLastPeriod(ctl.curCycleNum.value, ctl.data);
      ctl.updatedData.value = ctl.data.value;
      ctl.updatedData.value = ctl.updatedData.sublist(0, indexCurpf);
      ctl.storageList.value = ctl.storageList.sublist(0, indexCurpf);
      ctl.getFirstDayFourCycle(
          pf.date, difference, difference, ctl.curCycleNum.value);
      ctl.data = ctl.updatedData;
      box.write('data', ctl.storageList.value);
      box.write('lastPeriodDay', pf.date.toString());
      box.write('numCycleDays', difference);
    } catch (e) {
      print('cannot find pf');
    }
  }

  Widget adddedFeatureButton(BuildContext context) {
    return GestureDetector(
      child: Text("My period starts on this day.",
          style: TextStyle(
              decoration: TextDecoration.underline, color: Colors.red)),
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Are you sure you have a period on ${formatDate(ctl.selectedDay.value)}?',
            style: TextStyle(fontSize: 18, color: secBlue),
          ),
          content: Text(
            'By clicking Ok, the app will display next period day according to your new data.',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                calAddedFeature();
                Navigator.pop(
                  context,
                  'OK',
                );
              },
              child: Text('OK', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNoInfoBox() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon(Icons.calendar_today),
            Container(
              margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 15.0),
              child: Text(
                'Tracked on ${formatDate(ctl.selectedDay.value)}: ',
                style: TextStyle(
                    color: secBlue, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Container(
          // margin: EdgeInsets.fromLTRB(0, 0, 0, 0.0),
          width: 300,
          child: TextButton(
            child: const Text(
              'Add record',
              style: TextStyle(fontSize: 12),
            ),
            style: ButtonStyle(
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.redAccent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: BorderSide(color: Colors.redAccent))),
            ),
            onPressed: () {
              // ctl.selectedIndex.value = 1;
              ctl.onTabItem(1);
              // ctl.onTabItem;
            },
          ),
        ),
        // Container(
        //     margin: EdgeInsets.only(top: 12), child: adddedFeatureButton()),
      ],
    );
  }

  Widget buildForPeriod(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon(Icons.calendar_today),
            Container(
              margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 15.0),
              child: Text(
                'Tracked on ${formatDate(ctl.selectedDay.value)}: ',
                style: TextStyle(
                    color: secBlue, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 15.0),
                child: (ctl.selectedPF.value.hasPeriod)
                    ? Text(
                        'Menstruation',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      )
                    : (ctl.selectedPF.value.isFertile)
                        ? Text('Ovulation',
                            style: TextStyle(
                                color: secBlue, fontWeight: FontWeight.bold))
                        : Text(''))
          ],
        ),
        Container(
          // margin: EdgeInsets.fromLTRB(0, 0, 0, 0.0),
          width: 300,
          child: TextButton(
              child: const Text(
                'Add record',
                style: TextStyle(fontSize: 12),
              ),
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                        side: BorderSide(color: Colors.redAccent))),
              ),
              onPressed: () {
                // ctl.selectedIndex.value = 1;
                ctl.onTabItem(1);
                print('xxx');
              }),
        ),
        Container(
            margin: EdgeInsets.only(top: 12),
            child: adddedFeatureButton(context)),
      ],
    );
  }

  Widget buildInfoBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon(Icons.calendar_today),
            Container(
              margin: EdgeInsets.fromLTRB(3.0, 0.0, 0.0, 0.0),
              child: Text(
                'Tracked on ${formatDate(ctl.selectedPIF.value.date)}: ',
                style: TextStyle(
                    color: secBlue, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: (ctl.selectedPIF.value.pf.hasPeriod)
                    ? Text(
                        'Menstruation',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      )
                    : (ctl.selectedPIF.value.pf.isFertile)
                        ? Text('Ovulation',
                            style: TextStyle(
                                color: secBlue, fontWeight: FontWeight.bold))
                        : Text(''))
          ],
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Icon(Icons.water_drop_rounded, size: 12,),

              Container(
                  child: Text(
                'Bleeding: ',
              )),
              // SizedBox(height: 3.0,),
              Container(
                  // margin: EdgeInsets.fromLTRB(2.0, 5.0, 0.0, 0.0),
                  child: (ctl.selectedPIF.value.bleeding == 0)
                      ? Text('Light')
                      : (ctl.selectedPIF.value.bleeding == 1)
                          ? Text('Medium')
                          : (ctl.selectedPIF.value.bleeding == 2)
                              ? Text('Heavy')
                              : Text('Spotting')),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
          child: Row(
            children: [
              Container(
                  child: Text(
                'Symptoms: ',
              )),
              Container(
                  // margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                  child: (ctl.selectedPIF.value.isCramp)
                      ? Text('Cramps ')
                      : Text('')),
              Container(
                  child: (ctl.selectedPIF.value.isVomit)
                      ? Text('Headache ')
                      : Text('')),
              Container(
                  child: (ctl.selectedPIF.value.isNusea)
                      ? Text('Nausea ')
                      : Text('')),
              Container(
                  child: (ctl.selectedPIF.value.isTenderBreast == true)
                      ? Text('Tender Breast')
                      : Text(''))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
          child: Row(
            children: [
              Container(
                  child: Text(
                'Emotions: ',
              )),
              Container(
                  // margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                  child: (ctl.selectedPIF.value.isHappy)
                      ? Text('Happy ')
                      : Text('')),
              Container(
                  child:
                      (ctl.selectedPIF.value.isSad) ? Text('Sad ') : Text('')),
              Container(
                  child: (ctl.selectedPIF.value.isIrritate)
                      ? Text('Irritated ')
                      : Text('')),
              Container(
                  child: (ctl.selectedPIF.value.isSensitive)
                      ? Text('Sensitive')
                      : Text(''))
            ],
          ),
        ),
        // add here

        Center(
          child: Container(
              margin: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
              child: adddedFeatureButton(context)),
        ),
        Center(
          child: Container(
            // margin: EdgeInsets.fromLTRB(0, 0, 0, 0.0),
            width: 300,
            child: TextButton(
                child: const Text(
                  'Delete',
                  style: TextStyle(fontSize: 12),
                ),
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                          side: BorderSide(color: Colors.redAccent))),
                ),
                onPressed: () {
                  final idx = ctl.infos.indexWhere((element) =>
                      isSameDay(element.date, ctl.selectedDay.value));
                  ctl.infos.removeAt(idx);
                  ctl.symptomsList.removeAt(idx);
                  box.write('symptoms', ctl.symptomsList.value);
                  ctl.infos.refresh();
                  ctl.symptomsList.refresh();

                  ctl.selectedIndex.value = 0;
                  ctl.onTabItem;
                }),
          ),
        ),
      ],
    );
  }

  PeriodInfo findPfByDate(List<PeriodInfo> data, DateTime date) {
    PeriodInfo pfResult =
        data.firstWhere((pf) => date.difference(pf.date).inDays == 0);
    return pfResult;
  }

  PeriodSymptomInfo findPsiByDate(List<PeriodSymptomInfo> data, DateTime date) {
    PeriodSymptomInfo pfResult =
        data.firstWhere((pf) => date.difference(pf.date).inDays == 0);
    return pfResult;
  }

  Widget builAppBar(String text, Color color, double fontsize) {
    return Center(
      child: Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,
                  style: TextStyle(
                    color: color,
                    fontSize: fontsize,
                  )),
            ],
          )),
    );
  }

  Widget makeEButton(Icon icon) {
    return ElevatedButton(
      onPressed: () {},
      child: icon,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
        backgroundColor:
            MaterialStateProperty.all(Colors.blue), // <-- Button color
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed))
            return Colors.red; // <-- Splash color
        }),
      ),
    );
  }

  void callSymptom() {
    if (box.read('symptoms') != null) {
      ctl.restoreSymptoms(box, 'symptoms');
    }
  }

  void restoreAll() {
    ctl.restorePeriodInfoList(box, 'data');
    data = ctl.data;
    numCycleDays = ctl.numCycleDays.value;
    lastPeriodDay = ctl.lastPeriodDay.value;
    ctl.curCycleNum.value = ctl.getCurrCycleNum(ctl.data, DateTime.now());
    ctl.nextPf.value = ctl.getNextPeriod(ctl.curCycleNum.value, ctl.data.value);
     ctl.findHistory();
    ctl.countDownPeriod.value =
        ctl.nextPf.value.date.difference(DateTime.now()).inDays;
    PeriodInfo ovulation =
        ctl.getNextOvulation(ctl.curCycleNum.value, ctl.data.value);
    ctl.countDownOvulation.value =
        ovulation.date.difference(DateTime.now()).inDays;
    callSymptom();
   
  }

  @override
  buildObx(context) {
    restoreAll();
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom:
                            BorderSide(width: 1.0, color: Colors.grey.shade200),
                      )),
                  child: (ctl.selectedIndex.value == 0)
                      ? builAppBar('Your current cycle', secBlue, 20)
                      : (ctl.selectedIndex.value == 1)
                          ? builAppBar('Your period tracker', secBlue, 20)
                          : builAppBar('Your calendar', secBlue, 20)),
            ),
            SliverToBoxAdapter(
              child: Column(children: [
                if (ctl.selectedIndex.value == 0) ...[
                  // Container( height: MediaQuery.of(context).size.height,child: buildSlider(context)),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: PageSlider(
                      page1: CycleScreen(
                        data: data,
                        numCycleDays: numCycleDays,
                      ),
                      page2: Cycle2Screen(),
                      page3: HistoryScreen(),
                    ),
                  ),
                ] else if (ctl.selectedIndex.value == 1) ...[
                  Calendar(
                    numCycleDays: numCycleDays,
                    lastPeriodDay: lastPeriodDay,
                    data: ctl.data,
                    format: CalendarFormat.week,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height / 1.9999,
                      child: buildTabar(context)),
                  Container(
                    // margin: EdgeInsets.fromLTRB(0, 0, 0, 0.0),
                    width: 300,
                    child: TextButton(
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(16)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(secBlue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22),
                                    side: BorderSide(color: secBlue))),
                      ),
                      onPressed: () async {
                        var storageMap = {};

                        storageMap['date'] =
                            ctl.selectedDay.value.toString(); // date -> string

                        storageMap['bleeding'] = ctl.trackScreenP1.value; //int

                        // bool
                        storageMap['isCramp'] = ctl.trackScreenP2C4.value;
                        storageMap['isTenderBreast'] =
                            ctl.trackScreenP2C3.value;
                        storageMap['isNusea'] = ctl.trackScreenP2C2.value;
                        storageMap['isVomit'] = ctl.trackScreenP2C1.value;
                        storageMap['isHappy'] = ctl.trackScreenP3C4.value;
                        storageMap['isSensitive'] = ctl.trackScreenP3C1.value;
                        storageMap['isSad'] = ctl.trackScreenP3C2.value;
                        storageMap['isIrritate'] = ctl.trackScreenP3C3.value;
                        ctl.symptomsList.add(storageMap);

                        await box.write('symptoms', ctl.symptomsList.value);

                        ctl.restoreSymptoms(box, 'symptoms');
                        resetValue();
                        ctl.selectedIndex.value = 0;
                        ctl.onTabItem;
                      },
                    ),
                  )
                ] else ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Calendar(
                        numCycleDays: numCycleDays,
                        lastPeriodDay: lastPeriodDay,
                        data: data,
                        format: CalendarFormat.month,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 5,
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: (ctl.selectedValidate.value == 1)
                                  ? buildInfoBox(context)
                                  : (ctl.selectedValidate.value == 2)
                                      ? buildForPeriod(context)
                                      : buildNoInfoBox(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ]
              ]),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey.shade200))),
          child: BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.data_usage),
                  label: 'Cycle',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Track',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_rounded),
                  label: 'Calendar',
                ),
              ],
              currentIndex: ctl.selectedIndex.value, //RxInt,
              selectedItemColor: Colors.redAccent,
              onTap: ctl.onTabItem),
        ));
  }
}
