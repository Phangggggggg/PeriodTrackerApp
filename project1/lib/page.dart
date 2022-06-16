import 'package:get/get.dart';
import 'package:project1/screen/home_screen/home_screen_ctl.dart';
import 'package:project1/screen/last_period_screen.dart';

import 'screen/ask_cycle_screen.dart';
import 'screen/home_screen/home_screen.dart';

class AllPages {
  static final all_pages = [
    GetPage(
      name: '/lastperiod',
      page: () => LastPeriodScreen(),
      //   binding: BindingBuilder((){
      //       Get.lazyPut<ScreenCtl>(()=>ScreenCtl()),
      //   });
    ),
    GetPage(
      name: '/askcycle',
      page: () => AskCycleScreen(),
      //   binding: BindingBuilder((){
      //       Get.lazyPut<ScreenCtl>(()=>ScreenCtl()),
      //   });
    ),
    GetPage(
      name: '/home',
      page: () => HomeScreen2(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<HomeScreenCtl>(() => HomeScreenCtl());
        }, //activate this controller
      ),
    ),
    // GetPage(
    //   name: '/test',
    //   page: () => Test(),
    //   binding: BindingsBuilder(
    //     () {
    //       Get.lazyPut<TestCtl>(() => TestCtl());
    //     }, //activate this controller
    //   ),
    // ),
  ];
}
