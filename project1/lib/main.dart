import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project1/get_storage.dart';
import 'page.dart';
import 'screen/last_period_screen.dart';
void main() async {
  await Get.putAsync(() => MyStorage().init());// initialise Getx storage which is the offline database for the app
  runApp(MyApp());
}





class MyApp extends StatelessWidget {
  final box = GetStorage();
  bool isShow = false;

  void checkIsShow() {
    dynamic result = box.read('isShow');
    if (result != null) {
      isShow = box.read('isShow');
    }
  }

  @override
  Widget build(BuildContext context) {
    checkIsShow();
    return 
         GetMaterialApp(
          title: 'Period Tracker',
          initialRoute: isShow ? '/home' : '/lastperiod',
          getPages: AllPages.all_pages,
        
        );
      }

  }

