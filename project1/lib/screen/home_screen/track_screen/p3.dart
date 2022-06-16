import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/screen/home_screen/home_screen_ctl.dart';
import 'package:project1/screen/widgets/custom_button.dart';

import '../../../colors.dart';

buildP3(BuildContext context) {
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
                                  ctl.trackScreenP3C4.value = !ctl.trackScreenP3C4.value;

              },
              height: MediaQuery.of(context).size.height/6,
              width:MediaQuery.of(context).size.height/6,
              activeColor: Colors.redAccent,
              inactiveColor: secBlue,
              active:  ctl.trackScreenP3C4.value,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Container(
                   
                    child: Image.asset('lib/icons/smiley.png', height: 40,
                    width: 40, color: Colors.white,),
                   
                  ),
                  Text('Happy',
                  style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
            MyButton(
              onTap: () {
              ctl.trackScreenP3C1.value = !ctl.trackScreenP3C1.value;

              },
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.height/6,
              activeColor: Colors.redAccent,
              inactiveColor: secBlue,
              active: ctl.trackScreenP3C1.value,
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Container(
                   
                    child: Image.asset('lib/icons/sensitive.png', height: 40,
                    width: 40, color: Colors.white,),
                   
                  ),
                  Text('Sensitive',
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
                              ctl.trackScreenP3C2.value = !ctl.trackScreenP3C2.value;

              },
              height:MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.height/6,
              activeColor: Colors.redAccent,
              inactiveColor: secBlue,
              active:  ctl.trackScreenP3C2.value,
              widget: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                
                  Container(
                   
                    child: Image.asset('lib/icons/sad.png', height: 40,
                    width: 40, color: Colors.white,),
                   
                  ),
                  
                  Text('Sad', style: TextStyle(color: Colors.white))
                ],
              ),
              // text: 'Light',
            ),
            MyButton(
              onTap: () {
                  ctl.trackScreenP3C3.value = !ctl.trackScreenP3C3.value;

              },
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.height/6,
              activeColor: Colors.redAccent,
              inactiveColor: secBlue,
              active:  ctl.trackScreenP3C3.value,
              widget: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                   
                    child: Image.asset('lib/icons/angry.png', height: 40,
                    width: 40, color: Colors.white,),
                   
                  ),
                  Text('Irritated',style: TextStyle(color: Colors.white))
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
