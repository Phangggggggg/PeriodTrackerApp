
import 'package:project1/screen/models/period_info.dart';

class PeriodSymptomInfo {
  DateTime date;
  int bleeding; // 0 - light, medium - 1, heavy - 2, spotting -3'
  bool isCramp;
  bool isTenderBreast;
  bool isNusea;
  bool isVomit;
  bool isHappy;
  bool isSad;
  bool isSensitive;
  bool isIrritate;
  PeriodInfo pf;
  PeriodSymptomInfo({
    this.date,
   this.bleeding,
   this.isCramp,
   this.isTenderBreast,
   this.isNusea,
   this.isVomit,
   this.isHappy,
   this.isSad,
   this.isSensitive,
   this.isIrritate,
    this.pf
    });
}