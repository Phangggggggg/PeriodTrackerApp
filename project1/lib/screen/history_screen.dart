import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:project1/colors.dart';

import 'home_screen/home_screen_ctl.dart';

class HistoryScreen extends StatelessWidget {
  Widget makeBox(BuildContext context) {
    double widthBox = MediaQuery.of(context).size.width/1.2;
    double heightBox = MediaQuery.of(context).size.height / 1.299;
    return Container(
      height: heightBox,
      width: widthBox,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Container(
            height: 90,
             margin: EdgeInsets.all(12.0),
              color: index % 2  == 0 ? lightPink : kBlueDark,
            child: Row(
             
              children: <Widget>[
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Cycle ${(ctl.historyList[index].cycleNum+1).toString()}',
                            style: TextStyle(
                                color: secBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(' The period is on ${ctl.formatDate(ctl.historyList[index].date)}.',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: ctl.historyList.length,
        
      ),
    );
  }

  var ctl = Get.put(HomeScreenCtl());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(top: 28),
              child: Text(
                'History Cycles',
                style: TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold, color: secBlue),
              )),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Text('Show history cycle until the next cycle'),
          ),
          makeBox(context)
        ],
      ),
    );
  }
}
