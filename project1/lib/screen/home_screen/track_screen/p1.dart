import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/colors.dart';
import 'package:project1/screen/home_screen/home_screen_ctl.dart';


import '../../widgets/custom_button.dart';

buildP1(BuildContext context) {
 
  var ctl = Get.find<HomeScreenCtl>();
  return Container(
    margin: EdgeInsets.fromLTRB(20.0,20.0,20.0,0),
    child: Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 10.0,
        ),
        Row(
              mainAxisAlignment: MainAxisAlignment.center,

          children: [
            MyButton(
              onTap: () {
                ctl.trackScreenP1.value = 0;
              },
              height: MediaQuery.of(context).size.height/6,
              width:MediaQuery.of(context).size.height/6,
              activeColor: Colors.redAccent,
              inactiveColor: secBlue,
              active: (ctl.trackScreenP1.value == 0) ? true : false,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.water_drop_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text('Light',
                  style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
            MyButton(
              onTap: () {
                ctl.trackScreenP1.value = 1;
              },
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.height/6,
              activeColor: Colors.redAccent,
              inactiveColor: secBlue,
              active: (ctl.trackScreenP1.value == 1) ? true : false,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.water_drop_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      Icon(
                        Icons.water_drop_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                  Text('Medium',
                  style: TextStyle(color: Colors.white),)
                ],
              ),
              // text: 'Medium',
            ),
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              onTap: () {
                ctl.trackScreenP1.value = 2;
              },
              height:MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.height/6,
              activeColor: Colors.redAccent,
              inactiveColor: secBlue,
              active: (ctl.trackScreenP1.value == 2) ? true : false,
              widget: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(
                    Icons.water_drop_rounded,
                    color: Colors.white,
                        size: 30,
                  ),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.water_drop_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      Icon(
                        Icons.water_drop_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                  Text('Heavy', style: TextStyle(color: Colors.white))
                ],
              ),
              // text: 'Light',
            ),
            MyButton(
              onTap: () {
                ctl.trackScreenP1.value = 4;
              },
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.height/6,
              activeColor: Colors.redAccent,
              inactiveColor: secBlue,
              active: (ctl.trackScreenP1.value == 4) ? true : false,
              widget: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 50,
                      ),
                  Text('Spotting',style: TextStyle(color: Colors.white))
                ],
              ),
              // text: 'Medium',
            ),
          ],
        ),
      ],
    ),
  );
}
