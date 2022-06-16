import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '/screen/ask_cycle_screen.dart';
import '/colors.dart';
import 'package:intl/intl.dart';
class LastPeriodScreen extends StatefulWidget {
  @override
  State<LastPeriodScreen> createState() => _LastPeriodScreenState();
}

class _LastPeriodScreenState extends State<LastPeriodScreen> {
  DateTime selectedDay = DateTime.now();
  DateTime currentDay = DateTime.now();
  String formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You cannot choose ${formatDate(selectedDay)}.',style: TextStyle(color: secBlue),),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('The selected date is after today\'s date. Please choose the new valid date by clicking Ok.', style: TextStyle(
                  fontSize: 12
                ),),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text('Ok', style: TextStyle(color: Colors.redAccent),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      collapsedHeight: 100,
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 200,
      backgroundColor: darkpink,
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              child: Icon(
                Icons.water_drop_rounded,
                color: Colors.redAccent,
              ),
            ),
            Text(
              'When did your last period start?',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              //  width: MediaQuery.of(context).size.width/2,
              margin: const EdgeInsets.only(top: 8.0),

              child: AppBar(
                backgroundColor: Colors.white,
                toolbarHeight: 150,
                elevation: 0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                      child: Icon(
                        Icons.water_drop_rounded,
                        color: Colors.redAccent,
                        size: 38,
                      ),
                    ),
                    Text(
                      'When did your last period start?',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'You can estimate if you are unsure.',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Column(children: [
                SingleChildScrollView(
                  child: TableCalendar(
                    firstDay: DateTime.utc(2012, 10, 16),
                    lastDay: DateTime.utc(2032, 3, 14),
                    focusedDay: selectedDay,
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    daysOfWeekVisible: true,
                    onDaySelected: (sd, cd) {
                      setState(() {
                        selectedDay = sd;
                        currentDay = cd;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      focusedDay = focusedDay;
                    },
                    selectedDayPredicate: (date) {
                      return isSameDay(selectedDay, date);
                    },
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      // Weekend days color (Sat,Sun)
                      weekdayStyle: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black87),
                      weekendStyle: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black87),
                    ),
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      todayDecoration:
                          BoxDecoration(color: secBlue, shape: BoxShape.circle),
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
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 24.0, 0, 0.0),
                    width: 300,
                    child: TextButton(
                      child: const Text(
                        'Next',
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
                      onPressed: () {
                        if (selectedDay.isAfter(DateTime.now())) {
                          _showMyDialog();
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AskCycleScreen(
                                      lastPeriodDay: selectedDay)));
                        }
                      },
                    ),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
