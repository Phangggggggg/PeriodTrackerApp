import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/screen/home_screen/home_screen_ctl.dart';

import '../../../colors.dart';
import '../../widgets/custom_button.dart';

buildP2(BuildContext context) {
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
                              ctl.trackScreenP2C4.value = !ctl.trackScreenP2C4.value;

              },
              height: MediaQuery.of(context).size.height/6,
              width:MediaQuery.of(context).size.height/6,
              activeColor: Colors.redAccent,
              inactiveColor: secBlue,
              active:  ctl.trackScreenP2C4.value,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Container(
                   
                    child: Image.asset('lib/icons/abdominal-pain.png', height: 40,
                    width: 40, color: Colors.white,),
                   
                  ),
                  Text('Cramps',
                  style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
            MyButton(
              onTap: () {

              ctl.trackScreenP2C1.value = !ctl.trackScreenP2C1.value;
              },
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.height/6,
              activeColor: Colors.redAccent,
              inactiveColor: secBlue,
              active: ctl.trackScreenP2C1.value,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Container(
                   
                    child: Image.asset('lib/icons/pain.png', height: 40,
                    width: 40, color: Colors.white,),
                   
                  ),
                  Text('Headache',
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
                ctl.trackScreenP2C2.value = !ctl.trackScreenP2C2.value;
              },
              height:MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.height/6,
              activeColor: Colors.redAccent,
              inactiveColor: secBlue,
              active:  ctl.trackScreenP2C2.value,
              widget: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                
                  Container(
                   
                    child: Image.asset('lib/icons/nausea.png', height: 40,
                    width: 40, color: Colors.white,),
                   
                  ),
                  
                  Text('Nausea', style: TextStyle(color: Colors.white))
                ],
              ),
              // text: 'Light',
            ),
            MyButton(
              onTap: () {
                ctl.trackScreenP2C3.value = !ctl.trackScreenP2C3.value;
              },
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.height/6,
              activeColor: Colors.redAccent,
              inactiveColor: secBlue,
              active:  ctl.trackScreenP2C3.value,
              widget: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                   
                    child: Image.asset('lib/icons/pain-2.png', height: 40,
                    width: 40, color: Colors.white,),
                   
                  ),
                  Text('Tender Breast',style: TextStyle(color: Colors.white))
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



