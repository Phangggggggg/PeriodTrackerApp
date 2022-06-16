import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../colors.dart';
import '../models/period_info.dart';
import '../home_screen/home_screen_ctl.dart';

class Calendar extends StatefulWidget {
  DateTime lastPeriodDay;
  int numCycleDays;
  List<PeriodInfo> data;
  CalendarFormat format = CalendarFormat.month;

  Calendar({this.numCycleDays, this.lastPeriodDay, this.data, this.format});
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime selectedDay = DateTime.now();
  DateTime currentDay = DateTime.now();
  var ctl = Get.put(HomeScreenCtl());
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2012, 10, 16),
      lastDay: DateTime.utc(2032, 3, 14),
      focusedDay: ctl.selectedDay.value,
      calendarFormat: widget.format,
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekVisible: true,
      onDaySelected: (sd, cd) {
        setState(() {
          selectedDay = sd;
          currentDay = cd;
          ctl.setDate(sd);
        });
        
      },
      // pageAnimationEnabled:false,
      pageJumpingEnabled: false,
      selectedDayPredicate: (date) {
        return isSameDay(selectedDay, date);
      },
      daysOfWeekStyle: const DaysOfWeekStyle(
        // Weekend days color (Sat,Sun)
        weekdayStyle:
            TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
        weekendStyle:
            TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
      ),

      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        todayDecoration: BoxDecoration(color: secBlue, shape: BoxShape.circle),
        selectedDecoration: BoxDecoration(
            //color of slected
            color: Colors.redAccent,
            shape: BoxShape.circle),
        selectedTextStyle: TextStyle(color: Colors.white),
      ),

      headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Colors.redAccent,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: Colors.redAccent,
          )),

      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focuesedDay) {
          
          List<PeriodInfo> take =
              widget.data.where((pf) => pf.isFertile || pf.hasPeriod).toList();
          for (PeriodInfo d in take) {
            if (day.day == d.date.day &&
                day.month == d.date.month &&
                day.year == d.date.year &&
                d.hasPeriod) {
              return Container(
                width: 55,
                height: 50,
                decoration:  BoxDecoration(color: lightPink, shape: BoxShape.rectangle,
                 border: Border.all(color: lightPink),
                  borderRadius: BorderRadius.all(
                    Radius.circular(1.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            } else if (day.day == d.date.day &&
                day.month == d.date.month &&
                day.year == d.date.year &&
                d.isFertile) {
              return Container(
                width: 55,
                height: 50,
                decoration: BoxDecoration(
                  color: kBlueDark,
                  shape: BoxShape.rectangle,
          
                  borderRadius: BorderRadius.all(    
                    Radius.circular(1.0),
                  ),
                  border: Border.all(color: kBlueDark),
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(color: secBlue,fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
          }

          return null;
        },
      ),
    );
  }
}
