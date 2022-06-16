import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/get_storage.dart';
import 'package:get_storage/get_storage.dart';

abstract class MyView<T> extends StatelessWidget {
  const MyView({Key key}) : super(key: key);

  final String tag = null;
  T get ctl => GetInstance().find<T>(tag: tag);
  GetStorage get box => Get.find<GetStorage>();

  @override
  build(context) {
    return Obx(() => buildObx(context));
  }

  buildObx(context) {
    return Container();
  }
}
