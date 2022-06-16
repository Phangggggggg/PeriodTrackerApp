import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project1/screen/models/period_symptom_info.dart';
import 'package:intl/intl.dart';
import '../models/period_info.dart';

class HomeScreenCtl extends GetxController {
  var symptomsList = [].obs;
  var storageList = [].obs;
  var newDate = [].obs;

  var countDownPeriod = 0.obs;
  var countDownOvulation = 0.obs;

  var selectedValidate = 0.obs;
  var dummy = 'dummy'.obs;
  var selectedIndex = 0.obs;
  var infos = <PeriodSymptomInfo>[].obs;
  var updatedData = <PeriodInfo>[].obs;
  var currentDate = '...'.obs;

  var curCycleNum = 0.obs;
  Rx<PeriodInfo> nextPf = Rxn(null);
  var tabController = Rx(TabController);
  Rx<PeriodSymptomInfo> selectedPIF = Rx(null);
  Rx<PeriodInfo> selectedPF = Rx(null);

  /////track screen
  var trackScreenIndex = 0.obs;
  var trackScreenP1 = 0.obs;
  var trackScreenP2C1 = false.obs;
  var trackScreenP2C2 = false.obs;
  var trackScreenP2C3 = false.obs;
  var trackScreenP2C4 = false.obs;
  var trackScreenP3C1 = false.obs;
  var trackScreenP3C2 = false.obs;
  var trackScreenP3C3 = false.obs;
  var trackScreenP3C4 = false.obs;

  var historyList = <PeriodInfo>[].obs;

  /// from askcyclescreen
  Rx<DateTime> lastPeriodDay = DateTime.now().obs;
  var numCycleDays = 0.obs;
  var data = <PeriodInfo>[].obs;

  // Rx<List<PeriodInfo>> data = Rxn(null);
  Rx<DateTime> nextPeriodDay = DateTime.now().obs;

  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> currentDay = DateTime.now().obs;
  void onTabItem(int index) {
    selectedIndex.value = index;
    print('selectedIndex=${selectedIndex}');
  }

  PeriodInfo findPfByDate(List<PeriodInfo> data, DateTime date) {
    PeriodInfo pfResult =
        data.firstWhere((pf) => date.difference(pf.date).inDays == 0);
    return pfResult;
  }

  void restoreSymptoms(GetStorage box, String key) {
    infos.value = [];
    symptomsList.value = box.read(key);
    for (int i = 0; i < symptomsList.length; i++) {
      final map = symptomsList[i];
      DateTime day = DateTime.parse(map['date']);
      PeriodInfo pf = findPfByDate(data, day);
      PeriodSymptomInfo pfi = PeriodSymptomInfo(
          date: day,
          bleeding: map['bleeding'],
          isCramp: map['isCramp'],
          isTenderBreast: map['isTenderBreast'],
          isNusea: map['isNusea'],
          isVomit: map['isVomit'],
          isHappy: map['isHappy'],
          isSad: map['isSad'],
          isSensitive: map['isSensitive'],
          isIrritate: map['isIrritate'],
          pf: pf);

      infos.add(pfi); // adding Tasks back to your normal Task list
    }
  }

  void findHistory() {
    historyList.value = [];
    try {
      PeriodInfo pf = findPfByDate(data, DateTime.now());
      int firstCycle = data[0].cycleNum;
      int curCycle = curCycleNum.value;
      for (var i = -1; i < curCycle + 1; i++) {
        PeriodInfo thisPf = getNextPeriod(i, data);
        historyList.add(thisPf);
      }
    } catch (e) {
      print('cannot find pf in findhistory');
    }
  }

  void restorePeriodInfoList(GetStorage box, String key) {
    data.value = [];
    lastPeriodDay.value = DateTime.parse(box.read('lastPeriodDay'));
    numCycleDays.value = box.read('numCycleDays');
    storageList.value = box.read(key);
    // initializing list from storage

// looping through the storage list to parse out Task objects from maps
    for (int i = 0; i < storageList.value.length; i++) {
      final map = storageList.value[i];

      // index for retreival keys accounting for index starting at 0

      PeriodInfo period_info = PeriodInfo(
          date: DateTime.parse(map['date']),
          numDayInCycle: map['numDayInCycle'],
          cycleNum: map['cycleNum'],
          hasPeriod: map['hasPeriod'],
          isFirstDay: map['isFirstDay'],
          isLastDay: map['isisLastDay'],
          isFertile: map['isFertile'],
          numDay: map['numDay']);

      data.add(period_info); // adding Tasks back to your normal Task list
    }
  }

  PeriodInfo getdDay(
    List<PeriodInfo> data,
    DateTime date,
  ) {
    PeriodInfo pfResult =
        data.firstWhere((pf) => date.difference(pf.date).inDays == 0);
    return pfResult;
  }

  getPfByCycleNum(int curNum, List<PeriodInfo> data) {
    return data.firstWhere((pf) => pf.cycleNum == curNum && pf.hasPeriod);
  }

  String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  int getCurrCycleNum(List<PeriodInfo> data, DateTime currentDate) {
    return getdDay(data, currentDate).cycleNum;
  }

  PeriodInfo getLastPeriodByCycle(int curNum, List<PeriodInfo> data) {
    int lastCur = curNum - 1;
    if (curNum > 0) {
      return data.firstWhere((pf) => pf.cycleNum == lastCur && pf.isFirstDay);
    } else {
      return data.firstWhere((pf) => pf.cycleNum == curNum && pf.isFirstDay);
    }
  }

  void clearLastPeriod(int curNum, List<PeriodInfo> data) {
    PeriodInfo nowFirstCurPf = getPfByCycleNum(curNum, data);
    print("nowFirstCurPf: ");
    print(nowFirstCurPf.date);

    int indexNowPf = data.indexOf(nowFirstCurPf);
    for (var i = indexNowPf; i < indexNowPf + 5; i++) {
      dynamic currentPf = storageList[i];
      currentPf['hasPeriod'] = false;
      currentPf['isFirstDay'] = false;
      data[i].hasPeriod = false;
      data[i].isFirstDay = false;
    }
    print(nowFirstCurPf.hasPeriod);
  }

  getFirstDayFourCycle(DateTime lastPeriodDay, int numCycles, int numCycleDays,
      int idxCycleNum) {
    for (var i = idxCycleNum; i < idxCycleNum + 5; i++) {
      getACycle(lastPeriodDay, numCycles, i);
      lastPeriodDay = lastPeriodDay.add(Duration(days: numCycleDays));
    }
  }

  void getACycle(DateTime lastPeriodDay, int numCycles, int cycleNum) {
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
      storageList.add(storageMap);
      updatedData.add(PeriodInfo(
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
  }

  PeriodInfo getNextPeriod(int curNum, List<PeriodInfo> data) {
    int nextCur = curNum + 1;

    return data.firstWhere((pf) => pf.cycleNum == nextCur && pf.hasPeriod);
  }



  PeriodInfo getNextOvulation(int curNum, List<PeriodInfo> data) {
    try {
      PeriodInfo x =
          data.firstWhere((pf) => pf.cycleNum == curNum && pf.isFertile);

      if (x.date.isBefore(DateTime.now())) {
        // print('here1');
        int nextCur = curNum + 1;
        return data.firstWhere((pf) => pf.cycleNum == nextCur && pf.isFertile);
      }
    } catch (e) {

      return data.firstWhere((pf) => pf.cycleNum == curNum && pf.isFertile);
    }
    return data.firstWhere((pf) => pf.cycleNum == curNum && pf.isFertile);
  }

  setDate(sd) {
    selectedDay.value = sd;
    selectedValidate.value = 0;
    // print(data.value);
    // print(infos.value);
    // print(sd.toString());
    if (infos.isNotEmpty) {
      try {
        PeriodSymptomInfo pfi =
            infos.firstWhere((info) => sd.difference(info.date).inDays == 0);
        selectedPIF.value = pfi;
        selectedPF.value = pfi.pf;
        selectedValidate.value = 1;
      } catch (e) {
        try {
          PeriodInfo pfSd =
              data.value.firstWhere((pf) => sd.difference(pf.date).inDays == 0);
          selectedPF.value = pfSd;
          selectedValidate.value = 2;
        } catch (err) {
          print('err');
          // print('here0');
          selectedValidate.value = 0;
        }
      }
    } else {
      try {
        PeriodInfo pfSd =
            data.value.firstWhere((pf) => sd.difference(pf.date).inDays == 0);
        selectedPF.value = pfSd;
        selectedValidate.value = 2;
      } catch (err) {
        print('err');
        selectedValidate.value = 0;
      }
    }
  }
}
