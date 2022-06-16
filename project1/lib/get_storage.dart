import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyStorage extends GetxService {
   GetStorage box;
  init() async {
    var res = await GetStorage.init(); // initilaize the get_storage
    box = Get.put(GetStorage());
    print('init storage');
    return res;
  }

  void write(String key, dynamic value) async { //write fucntion with the given key and value
    await box.write(key, value);
  }

  T read<T> (String key) { // read from the sorage
     return box.read(key); //use generic tupe cus we can have many types store
   }
}
